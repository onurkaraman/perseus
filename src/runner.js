var parser = require("./parser").parser;

var INDENT = 'INDENT';
var DEDENT = 'DEDENT';
var PREVIOUS_TOKEN = null;
var STACK = [0];

// REFERENCE https://github.com/zaach/jison/issues/47

var oldAction = parser.lexer.performAction;
parser.lexer.performAction = function(lineno, yy){
	var ret = oldAction.apply(this, arguments);
	if(ret != null)
	{
		var currentToken =parser.terminals_[ret];
		var isNewline = PREVIOUS_TOKEN == 'NEWLINE' || PREVIOUS_TOKEN == null;

		console.log("matched '%s' with token '%s'", ret, currentToken);
		if(yy.match != yy.yytext)
		{
			console.log("Replaced: '%s' with: '%s'", yy.match, yy.yytext);
		}
		if(isNewline)
		{
			lexIndentation(yy, currentToken);
		}
		PREVIOUS_TOKEN = currentToken;
	}
	else
	{
		console.log("Ignored '%s'", yy.match);
	}
	return ret;
};

function lexIndentation(yy, currentToken)
{
	var isIndented = currentToken == 'WHITESPACE';
	var level = isIndented ? yy.yytext.length : 0;
	previousLevel = STACK[STACK.length - 1];
	while(level < previousLevel)
	{
		STACK.pop();
		previousLevel = STACK[STACK.length - 1];
		parser.lexer.yy.match = 'DEDENT';
	}
	if(level > previousLevel)
	{
		STACK.push(level);
		parser.lexer.yy.match = 'INDENT';
	}
}

var input = process.argv[2];
console.log(parser.parse(input));

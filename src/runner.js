/**
 * HEAVILY REFERENCED https://github.com/zaach/jison/issues/47
 */

var parser = require("./parser").parser;
var mode = process.argv[2];

var INDENT = 'INDENT';
var DEDENT = 'DEDENT';
var PREVIOUS_TOKEN = null;
var STACK = [0];

/**
 * Overwrites the lexer's default action performed so we can distinguish 
 * whitespace as indent or dedent
 */
var oldAction = parser.lexer.performAction;
parser.lexer.performAction = function(lineno, yy){
	var ret = oldAction.apply(this, arguments);
	if(ret != null)
	{
		var currentToken =parser.terminals_[ret];
		var isNewline = PREVIOUS_TOKEN == 'NEWLINE' || PREVIOUS_TOKEN == null;
		if(mode == 'DEBUG')
		{
			console.log("matched '%s' with token '%s'", yy.match, currentToken);
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

/**
 * Figures out whether the current line's indentation should be considered
 * an indent or dedent, or none
 */
function lexIndentation(yy, currentToken)
{
	var isIndented = currentToken == 'WHITESPACE';
	var level = isIndented ? yy.yytext.length : 0;
	var previousLevel = STACK[STACK.length - 1];
	while(level < previousLevel)
	{
		STACK.pop();
		previousLevel = STACK[STACK.length - 1];
		parser.lexer.yy.match = 'DEDENT'; //TODO: Figure out how to apply multiple tokens during this stage
	}
	if(level > previousLevel)
	{
		STACK.push(level);
		parser.lexer.yy.match = 'INDENT';
	}
}

var input = process.argv[3];
console.log(parser.parse(input));

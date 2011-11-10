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
		if(isNewline || currentToken == 'WHITESPACE')
		{
			if(currentToken != 'WHITESPACE')
			{
				while( STACK.length > 1)
				{
					STACK.pop();
					previousLevel = 0;
					console.log("DEDENT");
				}
			}
			var level = yy.yytext.length;
			previousLevel = STACK[STACK.length - 1];
			while(level < previousLevel)
			{
				STACK.pop();
				previousLevel = STACK[STACK.length - 1];
				console.log("DEDENT"); 
			}
			if(level > previousLevel)
			{
				STACK.push(level);
				console.log("INDENT");
			}
		}
		PREVIOUS_TOKEN = currentToken;
	}
	else
	{
		console.log("Ignored '%s'", yy.match);
	}
	return ret;
};

var input = process.argv[2];
input = ['[1,1.2,3]', '   [5]', ' [6]'].join('\n'); //Get rid of this line when done
console.log(parser.parse(input));

var parser = require("./parser").parser;

var INDENT = 'INDENT';
var DEDENT = 'DEDENT';
var stack = [0];

// REFERENCE https://github.com/zaach/jison/issues/47
var oldAction = parser.lexer.performAction;
parser.lexer.performAction = function(lineno, yy){
	var ret = oldAction.apply(this, arguments);
	if(ret != null)
	{
		console.log("matched '%s' with token '%s'", ret, parser.terminals_[ret]);
		if(yy.match != yy.yytext)
		{
			console.log("Replaced: '%s' with: '%s'", yy.match, yy.yytext);
		}
	}
	else
	{
		console.log("Ignored '%s'", yy.match);
	}
	return ret;
};

var input = process.argv[2];
console.log(parser.parse(input));

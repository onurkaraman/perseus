/**
 * HEAVILY REFERENCED https://github.com/zaach/jison/issues/47
 */

var parser = require("./parser").parser;
var NORMAL = 'NORMAL';
var DEBUG = 'DEBUG';
var MODE = NORMAL;

var INDENT = 'INDENT';
var DEDENT = 'DEDENT';
var PREVIOUS_TOKEN = null;
var STACK = [0];

/**
 * Overwrites the lexer's default action performed so we can distinguish 
 * whitespace as indent, dedent, or just whitespace
 */
var oldAction = parser.lexer.performAction;
parser.lexer.performAction = function(lineno, yy){
	var ret = oldAction.apply(this, arguments);
	if(ret != null)
	{
		var currentToken =parser.terminals_[ret];
		var isNewline = PREVIOUS_TOKEN == 'NEWLINE';
		if(MODE == DEBUG)
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

var oldParserAction = parser.performAction;
parser.performAction = function(yytext, yyleng, yylineno, yy, yystate, $$, _$){
	var ret = oldParserAction.apply(this, arguments);
	if(parser.lexer.yy.match === "INDENT")
	{
		var customYYState = 12; //magic number specified in parser's performAction switch statement
		ret = oldParserAction(yytext, yyleng, yylineno, yy, customYYState, $$, _$);
	}
	else if(parser.lexer.yy.match === "DEDENT")
	{
		var customYYState = 13; //magic number specified in parser's performAction switch statement
		ret = oldParserAction(yytext, yyleng, yylineno, yy, customYYState, $$, _$);
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
	if(level < previousLevel)
	{
		STACK.pop();
		previousLevel = STACK[STACK.length - 1];
		parser.lexer.yy.match = 'DEDENT';
	}
	else if(level > previousLevel)
	{
		STACK.push(level);
		parser.lexer.yy.match = 'INDENT';
	}
}

exports.execute = function(input, mode)
{
	MODE = mode || NORMAL;
	return parser.parse(input);
}

/**
 * Allow for calls through console of format node src/runner.js (TEST|DEBUG) '[4]'
 */
if(process.argv.length == 4)
{
	var mode = process.argv[2];
	var input = process.argv[3];
	console.log( exports.execute(input,mode) );
}

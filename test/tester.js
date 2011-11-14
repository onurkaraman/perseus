var path = require('path');
require('should');

var basePath = path.dirname(__dirname);
var runnerPath = path.join(basePath, 'src/runner');
var RUNNER = require(runnerPath);

module.exports = {
	"Empty Test": function(){
		var actual = RUNNER.execute('');
		var expected = [];
		actual.should.eql(expected);
	},
	"Keyword Test": function(){
		var keywords = [
			'and', 'del', 'from', 'not', 'while',
			'as', 'elif', 'global', 'or', 'with',
			'assert', 'else', 'if', 'pass', 'yield',
			'break', 'except', 'import', 'print',
			'class', 'exec', 'in', 'raise',
			'continue', 'finally', 'is', 'return',
			'def', 'for', 'lambda', 'try'
		];
		for(var i = 0; i < keywords.length; i++)
		{
			var keyword = keywords[i];
			var actual = RUNNER.execute(keyword);
			var expected = [keyword.toUpperCase()];
			actual.should.eql(expected);
		}

	},
	"Operator Test": function(){
		var operators = [
			'+', '-', '*', '**',
			'/', '//', '%', '<<',
			'>>', '&', '|', '^',
			'~', '<', '>', '<=',
			'>=', '==', '!=', '<>'
		];
		for(var i = 0; i < operators.length; i++)
		{
			var operator = operators[i];
			var actual = RUNNER.execute(operator);
			var expected = [operator];
			actual.should.eql(expected);
		}
	},
	"Integer Test": function(){
		var actual = RUNNER.execute('9001');
		var expected = [9001];
		actual.should.eql(expected);
	},
	"Float Number Test": function(){
		var actual = RUNNER.execute('9000.1');
		var expected = [9000.1];
		actual.should.eql(expected);
	},
	"String Test": function(){
		var testString = '"Great Scott!"';
		var actual = RUNNER.execute(testString);
		var expected = [testString];
		actual.should.eql(expected);
	},
	"Empty Array Test": function(){
		var emptyArray = '[]';
		var actual = RUNNER.execute(emptyArray);
		var expected = [ [] ];
		actual.should.eql(expected);
	},
	"Single Integer Array Test": function(){
		var integerArray = '[4]';
		var actual = RUNNER.execute(integerArray);
		var expected = [ [4] ];
		actual.should.eql(expected);
	},
	"Multiple Integer Array Test": function(){
		var integerArray = '[4,8,3]';
		var actual = RUNNER.execute(integerArray);
		var expected = [ [4, 8, 3] ];
		actual.should.eql(expected);
	},
	"Single Float Number Array Test": function(){
		var floatArray = '[1.2]';
		var actual = RUNNER.execute(floatArray);
		var expected = [ [1.2] ];
		actual.should.eql(expected);
	},
	"Multiple Float Array Test": function(){
		var integerArray = '[4.0,8.2,3.8]';
		var actual = RUNNER.execute(integerArray);
		var expected = [ [4.0, 8.2, 3.8] ];
		actual.should.eql(expected);
	},
	"Heterogeneous Number Array Test": function(){
		var numberArray = '[4,9.2,3]';
		var actual = RUNNER.execute(numberArray);
		var expected = [ [4, 9.2, 3] ];
		actual.should.eql(expected);
	},
	"Whitespaced Array Test": function(){
		var array = '[4,9.2, 3]';
		var actual = RUNNER.execute(array);
		var expected = [ [4, 9.2, 3] ];
		actual.should.eql(expected);
	},
	"Single String Array Test": function(){
		var stringArray = '["hello"]';
		var actual = RUNNER.execute(stringArray);
		var expected = [ ['hello'] ];
		actual.should.eql(expected);
	},
	"Multiple String Array Test": function(){
		var stringArray = '["hello", "world"]';
		var actual = RUNNER.execute(stringArray);
		var expected = [ ['hello', 'world'] ];
		actual.should.eql(expected);
	},
	"Heterogenous Number and String Array Test": function(){
		var mixedArray = '[0,1.2, "hi"]';
		var actual = RUNNER.execute(mixedArray);
		var expected = [ [0, 1.2, 'hi'] ];
		actual.should.eql(expected);
	},
	"Simple Indentation Test": function(){
		var indentedStatement = '    [0, 1.2, "hi"]';
		var actual = RUNNER.execute(indentedStatement);
		var expected = [ '    ', [ 0, 1.2, 'hi' ] ];
		actual.should.eql(expected);
	}
};

/**
 * parseBuilder.js takes in grammar represented as json and generates javascript parser
*/
var fs = require('fs');
var path = require('path');
var Parser = require('jison').Parser;
var grammarPath = path.join(__dirname, 'grammar.json');

fs.readFile(grammarPath, 'utf8', function(err, result)
{
	if(err)
		throw err;
	var json = JSON.parse(result);
	var parser = new Parser(json);
	var parserSource = parser.generate();
	var parserPath = path.join(__dirname, 'parser.js');
	fs.writeFile(parserPath, parserSource, function(writeErr)
	{
		if(writeErr)
			throw writeErr;
	});
});

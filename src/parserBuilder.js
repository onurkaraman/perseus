/**
 * parseBuilder.js takes in grammar represented as json and generates javascript parser
*/
var fs = require('fs');
var Parser = require('jison').Parser;

fs.readFile('grammar.json', 'ascii', function(err, result)
{
	if(err)
		throw err;
	json = JSON.parse(result);
	var parser = new Parser(json);
	var parserSource = parser.generate();
	fs.writeFile('parser.js', parserSource, function(writeErr)
	{
		if(writeErr)
			throw writeErr;
	});
});

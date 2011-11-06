var parser = require("./parser").parser;

var input = process.argv[2];

console.log(parser.parse(input));

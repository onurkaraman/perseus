build:
	node src/generator.js
test:
	make build
	node src/runner.js '[]'
	node src/runner.js '[4]'
	node src/runner.js '[44]'
	node src/runner.js '[0.2]'
	node src/runner.js '["string"]'
	node src/runner.js '[4,5]'
	node src/runner.js '[0,1.2,"string"]'
	node src/runner.js '  	[0,1.2,"string"]'
#manually type in node src/runner.js '[1,2]
#   [3]
#      [4]
#[5]'
clean:
	rm src/parser.js

build:
	node src/generator.js
test:
	make build
	node src/runner.js TEST '[]'
	node src/runner.js TEST '[4]'
	node src/runner.js TEST '[44]'
	node src/runner.js TEST '[0.2]'
	node src/runner.js TEST '["string"]'
	node src/runner.js TEST '[4,5]'
	node src/runner.js TEST '[0,1.2,"string"]'
	node src/runner.js TEST '  	[0,1.2,"string"]'
	node src/runner.js TEST 'for'
	node src/runner.js TEST 'in'
	node src/runner.js TEST '>>'
	node src/runner.js TEST '=='
	node src/runner.js TEST '!='
	node src/runner.js TEST '+'
	node src/runner.js TEST '-'
	node src/runner.js TEST '*'
	node src/runner.js TEST '**'
	node src/runner.js TEST '/'
	node src/runner.js TEST '//'
	node src/runner.js TEST '%'
debug:
	make build
	node src/runner.js DEBUG '[]'
	node src/runner.js DEBUG '[4]'
	node src/runner.js DEBUG '[44]'
	node src/runner.js DEBUG '[0.2]'
	node src/runner.js DEBUG '["string"]'
	node src/runner.js DEBUG '[4,5]'
	node src/runner.js DEBUG '[0,1.2,"string"]'
	node src/runner.js DEBUG '  	[0,1.2,"string"]'
	node src/runner.js DEBUG 'for'
	node src/runner.js DEBUG 'in'
	node src/runner.js TEST '>>'
	node src/runner.js TEST '=='
	node src/runner.js TEST '!='
	node src/runner.js TEST '+'
	node src/runner.js TEST '-'
	node src/runner.js TEST '*'
	node src/runner.js TEST '**'
	node src/runner.js TEST '/'
	node src/runner.js TEST '//'
	node src/runner.js TEST '%'
#manually type in node src/runner.js '[1,2]
#   [3]
#      [4]
#[5]'
clean:
	rm src/parser.js


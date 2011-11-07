build:
	node src/generator.js

test:
	make build
	node src/runner.js '[4]'
	node src/runner.js '[44]'
	node src/runner.js '[0.2]'
clean:
	rm src/parser.js

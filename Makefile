build:
	node src/generator.js

test:
	make build
	node src/runner.js '[4]'
clean:
	rm src/parser.js

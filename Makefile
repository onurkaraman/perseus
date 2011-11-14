build:
	node src/generator.js
test: FORCE
	make build
	expresso test/tester.js
clean:
	rm src/parser.js
FORCE:

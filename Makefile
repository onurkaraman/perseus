define TEST_STRING
5
   6
3
   7
2
endef
export TEST_STRING
build:
	node src/generator.js
test: FORCE
	make build
	expresso test/tester.js
clean:
	rm src/parser.js
temp: FORCE
	make clean
	make build
	node src/runner.js TEST "$$TEST_STRING"

FORCE:

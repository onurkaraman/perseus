build:
	coffee -o ./ -cpbj src/builtin/* > pythonScript.js

clean:
	rm pythonScript.js

.PHONY: doc subset
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 
subset:
	coffee -cpbj exceptions.coffee helper.coffee object.coffee primitive.coffee number.coffee integer.coffee iterable.coffee sequence.coffee string.coffee 

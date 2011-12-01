build:
	coffee -o ./ -cpbj src/builtin/* > pythonScript.js

clean:
	rm pythonScript.js

.PHONY: doc
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 

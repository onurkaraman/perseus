build:
	coffee -o ./ -cpbj src/builtin/* > pythonScript.js

clean:
	rm pythonScript.js

.PHONY: doc subset intSubset strSubset
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 

subset:
	coffee -cpbj src/builtin/exceptions.coffee src/builtin/helper.coffee src/builtin/object.coffee src/builtin/primitive.coffee src/builtin/number.coffee src/builtin/integer.coffee src/builtin/iterable.coffee src/builtin/sequence.coffee src/builtin/string.coffee > pythonScript.js 

intSubset:
	coffee -cpbj src/builtin/exceptions.coffee src/builtin/helper.coffee src/builtin/object.coffee src/builtin/primitive.coffee src/builtin/number.coffee src/builtin/integer.coffee

strSubset:
	coffee -cpbj src/builtin/exceptions.coffee src/builtin/helper.coffee src/builtin/object.coffee src/builtin/primitive.coffee src/builtin/iterable.coffee src/builtin/sequence.coffee src/builtin/string.coffee > pythonScript.js

dictSubset:
	coffee -cpbj src/builtin/exceptions.coffee src/builtin/helper.coffee src/builtin/object.coffee src/builtin/primitive.coffee src/builtin/iterable.coffee src/builtin/mapping.coffee src/builtin/set.coffee src/builtin/iterator.coffee src/builtin/dictionary-keyiterator.coffee src/builtin/dict.coffee > pythonScript.js

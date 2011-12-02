BASE="src/builtin/exceptions.coffee src/builtin/helper.coffee"
PYTHONSCRIPT=pythonScript.js
BUILTIN=src/builtin

build:
	coffee -o ./ -cpbj src/builtin/* > $(PYTHONSCRIPT)

clean:
	rm pythonScript.js

.PHONY: doc subset intSubset strSubset
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 

subset:
	coffee -cpbj $(BASE) $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/number.coffee $(BUILTIN)/integer.coffee $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/string.coffee > $(PYTHONSCRIPT) 

intSubset:
	coffee -cpbj $(BASE) $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/number.coffee $(BUILTIN)/integer.coffee > $(PYTHONSCRIPT)

strSubset:
	coffee -cpbj $(BASE) $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/string.coffee > $(PYTHONSCRIPT)

listSubset:
	coffee -cpbj $(BASE) $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/list.coffee > $(PYTHONSCRIPT)

dictSetSubset:
	coffee -cpbj $(BASE) $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/iterable.coffee $(BUILTIN)/mapping.coffee $(BUILTIN)/set.coffee $(BUILTIN)/iterator.coffee $(BUILTIN)/dictionary-keyiterator.coffee $(BUILTIN)/dict.coffee > $(PYTHONSCRIPT)

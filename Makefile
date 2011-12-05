BUILTIN=src/builtin
PYTHONSCRIPT=pythonScript.js
BASE=$(BUILTIN)/exceptions.coffee $(BUILTIN)/helper.coffee $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/exceptions.coffee $(BUILTIN)/functions.coffee

build:
	coffee -cpbj src/builtin/*.coffee > $(PYTHONSCRIPT)

clean:
	rm -f pythonScript.js
	rm -f src/builtin/*.js

.PHONY: doc subset intSubset strSubset listSubset dictSetSubset iteratorSubset
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 

subset:
	coffee -cpbj $(BASE) $(BUILTIN)/number.coffee $(BUILTIN)/float.coffee $(BUILTIN)/integer.coffee $(BUILTIN)/bool.coffee $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/string.coffee $(BUILTIN)/list.coffee $(BUILTIN)/mapping.coffee $(BUILTIN)/set.coffee $(BUILTIN)/iterator.coffee $(BUILTIN)/dictionary-keyiterator.coffee $(BUILTIN)/dictionary-valueiterator.coffee $(BUILTIN)/dict.coffee > $(PYTHONSCRIPT)

setset:
	coffee -cpbj $(BASE) $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/list.coffee $(BUILTIN)/mapping.coffee $(BUILTIN)/set.coffee $(BUILTIN)/iterator.coffee $(BUILTIN)/dictionary-keyiterator.coffee $(BUILTIN)/dictionary-valueiterator.coffee $(BUILTIN)/dict.coffee > $(PYTHONSCRIPT)

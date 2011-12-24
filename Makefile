BUILTIN=src/builtin
PERSEUS=perseus.js
BASE=$(BUILTIN)/exceptions.coffee $(BUILTIN)/helper.coffee $(BUILTIN)/object.coffee $(BUILTIN)/primitive.coffee $(BUILTIN)/exceptions.coffee $(BUILTIN)/functions.coffee

build:
	coffee -cpbj src/builtin/*.coffee > $(PERSEUS)

clean:
	rm -f perseus.js
	rm -f src/builtin/*.js

.PHONY: doc subset setset test
doc:
	rm -rf docs/
	docco src/node/*.py src/builtin/*.coffee 

subset:
	coffee -cpbj $(BASE) $(BUILTIN)/number.coffee $(BUILTIN)/float.coffee $(BUILTIN)/integer.coffee $(BUILTIN)/bool.coffee $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/string.coffee $(BUILTIN)/list.coffee $(BUILTIN)/mapping.coffee $(BUILTIN)/set.coffee $(BUILTIN)/iterator.coffee $(BUILTIN)/dictionary-keyiterator.coffee $(BUILTIN)/dictionary-valueiterator.coffee $(BUILTIN)/dict.coffee > $(PERSEUS)

setset:
	coffee -cpbj $(BASE) $(BUILTIN)/iterable.coffee $(BUILTIN)/sequence.coffee $(BUILTIN)/list.coffee $(BUILTIN)/mapping.coffee $(BUILTIN)/set.coffee $(BUILTIN)/iterator.coffee $(BUILTIN)/dictionary-keyiterator.coffee $(BUILTIN)/dictionary-valueiterator.coffee $(BUILTIN)/dict.coffee > $(PERSEUS)

test:
	cd test; python tester.py

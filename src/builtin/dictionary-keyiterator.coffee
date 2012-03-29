# DictionaryKeyIterator class is an iterator class containing methods for Python's built-in 
# dictionary-keyiterator type.
class DictionaryKeyIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.keys()
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index++))

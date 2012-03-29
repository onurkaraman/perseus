# DictionaryValueIterator class is an iterator class containing methods for Python's built-in 
# dictionary-valueiterator type.
class DictionaryValueIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.values()
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index++))

# DictionaryItemIterator class is an iterator class containing methods for Python's built-in 
# dictionary-itemiterator type.
class DictionaryItemIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = List()
    for key in dictionary.value
      tuple = new Tuple(key, dictionary.__getitem__(key])
      iterable.append(tuple)
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)
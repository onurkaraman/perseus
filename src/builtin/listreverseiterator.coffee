# ListReverseIterator class is an iterator class containing methods for Python's built-in 
# listreverseiterator type.
class ListReverseIterator extends Iterator
  constructor: (list) ->
    @iterable = list
    @index = len(list).value - 1

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index < 0
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index--))

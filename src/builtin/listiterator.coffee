# ListIterator class is an iterator class containing methods for Python's built-in 
# listiterator type.
class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list.copy()
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)
# ListIterator class is an iterator class containing methods for Python's built-in 
# listiterator type.
class ListIterator extends Iterator
  constructor: (list) ->
    @iterable = list #TODO: check if we need a copy here
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  # TODO: raise RuntimeError if the list is changed while iterating
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index++))

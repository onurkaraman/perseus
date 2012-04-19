# TupleIterator class is an iterator class containing methods for Python's built-in 
# tupleiterator type.
class TupleIterator extends Iterator
  constructor: (tuple) ->
    @iterable =  tuple.value #TODO: check if we need a copy here
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  # TODO: raise RuntimeError if the list is changed while iterating
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index++))

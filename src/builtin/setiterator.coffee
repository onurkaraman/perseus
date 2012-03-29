# SetIterator class is an iterator class containing methods for Python's built-in 
# setiterator type.
class SetIterator extends Iterator
  constructor: (set) ->
    @iterable = set.value.keys() # set contains a value attribute which is a hashset
    @index = 0

  # http://docs.python.org/library/stdtypes.html#iterator.next
  next: ->
    if @index >= len(@iterable).value
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(new Int(@index++))

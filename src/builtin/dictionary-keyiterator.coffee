class DictionaryKeyIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = dictionary.keys()
    @index = 0

  next: ->
    if @index >= @iterable.length
      raise new StopIteration "StopIteration"
    else
      return @iterable[@index++]
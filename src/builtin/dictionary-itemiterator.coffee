class DictionaryItemIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = []
    for key in dictionary
      tuple = new Tuple(key, @dictionary[key])
      iterable.push(tuple)
    @index = 0

  next: ->
    if @index >= @iterable.__len__()
      (new StopIteration "StopIteration").raise()
    else
      return @iterable.index(@index++)
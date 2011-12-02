class DictionaryItemIterator extends Iterator
  constructor: (dictionary) ->
    @iterable = List()
    for key in dictionary.value
      tuple = new Tuple(key, dictionary.__getitem__(key])
      iterable.append(tuple)
    @index = 0

  next: ->
    if @index >= len(@iterable)
      raise new StopIteration "StopIteration"
    else
      return @iterable.__getitem__(@index++)
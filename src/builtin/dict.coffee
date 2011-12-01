class Dict extends Mapping
  constructor: (iterable) ->
    @value = {}
    for key in iterable
      @value[key] = iterable[key]

  __contains__: (key) ->
    return key in @value

  __delitem__: (key) ->
    delete @value[key]

  # ** Unimplemented **
  __eq__: (dict) ->
    
  # ** Unimplemented **
  __ge__: (dict) ->

  # ** Unimplemented **
  __getattribute__: (attr) ->

  __getitem__: (key) ->
    return @value[key]

  # ** Unimplemented **
  __gt__: (dict) ->

  # ** Unimplemented **
  __init__: ->

  __iter__: ->
    return new DictionaryKeyIterator(@)

  # ** Unimplemented **
  __le__: (dict) ->

  __len__: ->
    return Object.keys(Object(@value)).length

  # ** Unimplemented **
  __lt__: (dict) ->

  __ne__: (dict) ->
    return not @__eq__(dict)

  # ** Unimplemented **
  __repr__: ->

  __setitem__: (key, value) ->
    @value[key] = value
    return
  
  #** Unimplemented **
  __sizeof__: ->
  
  clear: ->
    @value = {} #just reset the dictionary
    return

  # Returns a shallow copy of this
  copy: ->
    copy = {}
    for key in @value
      copy[key] = @value[key]
    return copy

  get: (key, d) ->
    if key in @value
      return @value[key]
    else
      return d

  has_key: (key) ->
    return key in @value

  items: ->
    items = []
    for key in @value
      
      tuple = new Tuple(key, @value[key])
      items.push(tuple)
    return items

  iteritems: ->
    return new DictionaryItemIterator(@)

  iterkeys: ->
    return new DictionaryKeyIterator(@)

  itervalues: ->
    return new DictionaryKeyIterator(@)

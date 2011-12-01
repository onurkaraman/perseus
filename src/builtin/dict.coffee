class Dict extends Mapping
  constructor: (iterable) ->
    @value = {}
    for key in iterable
      @value[key] = iterable[key]

  # Checks if the key exists in this
  __contains__: (key) ->
    return key in @value

  # Removes the key,value pair from this
  __delitem__: (key) ->
    delete @__getitem__(key)

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
    copy = Dict()
    for key in @value
      val = @__getitem__(key)
      copy.__setitem__(key, val)
    return copy

  get: (key, d) ->
    if key in @value
      return @__getitem__(key)
    else
      return d

  has_key: (key) ->
    return key in @value

  items: ->
    items = [] #Unsure if this should be JS list or Pythonscript List
    for key in @value
      val = @__getitem__(key)
      tuple = new Tuple(key, val)
      items.push(tuple)
    return items

  iteritems: ->
    return new DictionaryItemIterator(@)

  iterkeys: ->
    return new DictionaryKeyIterator(@)

  itervalues: ->
    return new DictionaryValueIterator(@)

  keys: ->
    return Object.keys(@value)

  pop: (key, d) ->
    if key in @keys()
      return @value.pop(key)
    else if d?
      return d
    else
      (new KeyError "#{key}").raise()

  popitem: ->
    if @__len__() == 0
      (new KeyError "popitem(): dictionary is empty").raise()

  setdefault: (key, d) ->
    if key not in @keys()
      @__setitem__(key, d)
    return @value[key]

  # ** Unimplemented **
  update: ->
  
  values: ->
    keys = @keys()
    values = []
    for key in keys
      val = @__getitem__(key)
      values.push(val)
    return values

  # ** Unimplemented **
  viewitems: ->

  # ** Unimplemented **
  viewkeys: ->

  # ** Unimplemented **
  viewvalues: ->
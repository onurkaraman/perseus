# http://docs.python.org/library/stdtypes.html#dict
class Dict extends Mapping
  constructor: (iterable) ->
    @value = {}
    if iterable?
      for key, value of iterable # TODO: Coffeescript uses in when using array, of when using object
        if not key.__hash__?
            raise new TypeError("unhashable type: '{#key.__class__.__name__}'")
        @__setitem__(key, value)

  # Checks if the key exists in this
  __contains__: (key) ->
    return new Bool(key.__hash__().value of @value)

  # Removes the key,value pair from this
  __delitem__: (key) ->
    delete @value[key.__hash__().value]
    return
    ###
      TODO: Implement __hash__() for all hashable types
            Build global table mapping __hash__ integers to their objects
    ###

  # http://docs.python.org/release/2.3.5/ref/comparisons.html
  __eq__: (otherDict) ->
    keys = @keys()
    otherKeys = otherDict.keys()
    if keys.__ne__(otherKeys).value #if keys are different, not equal
      return new Bool(false)
    for key in keys.value
      val = @__getitem__(key)
      otherVal = otherDict.__getitem__(key)
      if val.__ne__(otherVal).value
        return new Bool(false)
    return new Bool(true)
    
  __ge__: (otherDict) ->
    return new Bool(@__gt__(otherDict).value or @__eq__(otherDict).value)

  # **Unimplemented**
  __getattribute__: (attr) ->

  # Gets the item from this: like `x[key]`
  __getitem__: (key) ->
    if @__contains__(key)
      return @value[key.__hash__().value]
    else
      raise new KeyError("#{key}")

  __gt__: (otherDict) ->
    return new Bool(not @__le__(otherDict).value)

  # **Unimplemented**
  __init__: ->

  __iter__: ->
    return new DictionaryKeyIterator(@)

  __le__: (otherDict) ->
    return new Bool(@__lt__(otherDict).value or @__eq__(otherDict).value)

  __len__: ->
    return @keys().__len__()

  # First checks length of dictionary, then compares sorted keys and their associated values
  __lt__: (otherDict) ->
    length = @__len__()
    otherLength = otherDict.__len__()
    if length.__ne__(otherLength).value
      return length.__lt__(otherLength)
    else
      keys = Object.keys(@value).sort()
      otherKeys = Object.keys(dict.value).sort()
      for key,i in keys
        otherKey = otherKeys.__getitem__(i)
        if key.__ge__(otherKey).value
          return new Bool(false)
        val = @__getitem__(key)
        otherVal = @__getitem__(otherKey)
        if val.__ge__(otherVal).value
          return new Bool(false)
      return new Bool(true)

  __ne__: (otherDict) ->
    return new Bool(not @__eq__(otherDict).value)

  # **Unimplemented**
  __repr__: ->

  # Sets a value to the key in this: like `x[key] = value`
  __setitem__: (key, value) ->
    @value[key.__hash__().value] = value
    return
  
  #** Unimplemented **
  __sizeof__: ->
  
  # http://docs.python.org/library/stdtypes.html#dict.clear
  clear: ->
    @value = {} #just reset the dictionary
    return

  # http://docs.python.org/library/stdtypes.html#dict.copy
  copy: ->
    copy = new Dict(@)
    return copy

  # http://docs.python.org/library/stdtypes.html#dict.fromkeys
  @fromkeys: ->

  # http://docs.python.org/library/stdtypes.html#dict.get
  get: (key, d) ->
    if @__contains__(key).value
      return @__getitem__(key)
    else
      return d

  # http://docs.python.org/library/stdtypes.html#dict.has_key
  has_key: (key) ->
    return @__contains__(key)

  # http://docs.python.org/library/stdtypes.html#dict.items
  items: ->
    items = new List()
    for key of @value
      val = @__getitem__(key)
      tuple = new Tuple([key, val])
      items.append(tuple)
    return items

  # http://docs.python.org/library/stdtypes.html#dict.iteritems
  iteritems: ->
    return new DictionaryItemIterator(@)

  # http://docs.python.org/library/stdtypes.html#dict.iterkeys
  iterkeys: ->
    return new DictionaryKeyIterator(@)

  # http://docs.python.org/library/stdtypes.html#dict.itervalues
  itervalues: ->
    return new DictionaryValueIterator(@)

  # http://docs.python.org/library/stdtypes.html#dict.keys
  keys: ->
    ###
      TODO: Perform lookup on global hash-to-object-mapping table
        to get actual key objects instead of just their hashes
    ###
    keys = new List(Object.keys(@value))
    return keys

  # http://docs.python.org/library/stdtypes.html#dict.pop
  pop: (key, d) ->
    keys = @keys()
    if keys.__contains__(key).value
      val = @__getitem__(key)
      @__delitem__(key)
      return val
    else if d?
      return d
    else
      raise new KeyError("#{key}")

  # http://docs.python.org/library/stdtypes.html#dict.popitem
  popitem: ->
    if @__len__().value == 0
      raise new KeyError("popitem(): dictionary is empty")
    keys = @keys()
    randomKey = keys.__getitem__(new Int(0))
    randomValue = @__getitem__(randomKey)
    return new Tuple([randomKey, randomValue])

  # http://docs.python.org/library/stdtypes.html#dict.setdefault
  setdefault: (key, d) ->
    if not @__contains__(key).value
      @__setitem__(key, d)
    return @__getitem__(key)

  # **Unimplemented**
  # http://docs.python.org/library/stdtypes.html#dict.update
  update: ->
  
  # http://docs.python.org/library/stdtypes.html#dict.values
  values: ->
    keys = @keys()
    values = new List()
    for key in keys.value
      val = @__getitem__(key)
      values.append(val)
    return values

  # **Unimplemented**
  # http://docs.python.org/library/stdtypes.html#dict.viewitems
  viewitems: ->

  # **Unimplemented**
  # http://docs.python.org/library/stdtypes.html#dict.viewkeys 
  viewkeys: ->

  # **Unimplemented**
  # http://docs.python.org/library/stdtypes.html#dict.viewvalues
  viewvalues: ->

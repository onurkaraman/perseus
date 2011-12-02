class Dict extends Mapping
  constructor: (iterable) ->
    @value = {}
    if iterable?
      for key, value of iterable # TODO: Coffeescript uses in when using array, of when using object
        @value[key] = value

  # Checks if the key exists in this
  __contains__: (key) ->
    return new Bool key of @value

  # Removes the key,value pair from this
  __delitem__: (key) ->
    delete @value[key]
    return

  __eq__: (dict) ->
    keys = Object.keys(@value)
    otherKeys = Object.keys(dict.value)
    set = new Set(keys)
    otherSet = new Set(otherKeys)
    if set.__ne__(otherSet) #if keys are different, not equal
      return new Bool false
    for key in keys
      val = @__getitem__(key)
      otherVal = dict.__getitem__(key)
      if val != otherVal #if values differ, not equal. Unsure if this should be __ne__
        return new Bool false
    return new Bool true
    
  __ge__: (dict) ->
    return new Bool @__gt__(dict) or @__eq__(dict)

  __getattribute__: (attr) ->

  # Gets the item from this: like `x[key]`
  __getitem__: (key) ->
    return @value[key]

  __gt__: (dict) ->
    return new Bool not @__le__(dict)

  # **Unimplemented**
  __init__: ->

  __iter__: ->
    return new DictionaryKeyIterator(@)

  __le__: (dict) ->
    return new Bool @__lt__(dict) or @__eq__(dict)

  __len__: ->
    return new Int Object.keys(Object(@value)).length

  # First checks length of dictionary, then compares sorted keys and their associated values
  __lt__: (dict) ->
    if @__len__().value < dict.__len__().value
      return new Bool true
    else if @__len__().value > dict.__len__().value
      return new Bool false
    else
      keys = Object.keys(@value).sort()
      otherKeys = Object.keys(dict.value).sort()
      for key,i in keys
        if key >= otherKeys[i]
          return new Bool false
        val = @__getitem__ key
        otherVal = @__getitem__ otherKeys[i]
        if val >= otherVal
          return new Bool false
      return new Bool true

  __ne__: (dict) ->
    return new Bool not @__eq__ dict

  # **Unimplemented**
  __repr__: ->

  # Sets a value to the key in this: like `x[key] = value`
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
    copy = new Dict(@)
    return copy

  # Gets the value of the `key` if key exists. Otherwise return default `d`
  get: (key, d) ->
    if key of @value
      return @__getitem__(key)
    else
      return d

  has_key: (key) ->
    return new Bool key of @value

  items: ->
    items = new List()
    for key of @value
      val = @__getitem__ key
      tuple = new Tuple [key, val]
      items.append tuple
    return items

  iteritems: ->
    return new DictionaryItemIterator(@)

  iterkeys: ->
    return new DictionaryKeyIterator(@)

  itervalues: ->
    return new DictionaryValueIterator(@)

  # Returns a list of keys of this
  keys: ->
    keys = new List Object.keys(@value)
    return keys

  # Returns the popped value at key if key exists. 
  # Else returns `d` if default `d` exists
  # Else raises `KeyError`
  pop: (key, d) ->
    keys = @keys()
    if keys.__contains__(key)
      val = @value[key]
      delete @value[key]
      return val
    else if d?
      return d
    else
      raise new KeyError "#{key}"

  # Pops random item from this and returns a 2-tuple
  popitem: ->
    if @__len__().value == 0
      raise new KeyError "popitem(): dictionary is empty"
    keys = @keys()
    randomKey = keys.__getitem__ 0
    randomValue = @__getitem__ randomKey
    return new Tuple [randomKey, randomValue]

  setdefault: (key, d) ->
    if key not in @keys().value
      @__setitem__ key, d
    return @value[key]

  # **Unimplemented**
  update: ->
  
  # Returns a list of values of this
  values: ->
    keys = @keys()
    values = new List()
    for key in keys.value
      val = @__getitem__(key)
      values.append(val)
    return values

  # **Unimplemented**
  viewitems: ->

  # **Unimplemented**
  viewkeys: ->

  # **Unimplemented**
  viewvalues: ->
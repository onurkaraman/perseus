class Set extends Iterable
  constructor: (iterable) ->
    @value = Dictionary() # set just is a wrapped version of our own Dictionary class
    for item in iterable
      @value.__setitem__(item) = true

  __and__: (other) ->
    intersect = List()
    intersect.append(item) for item in @value when other.__contains__(item)
    return new Set(intersect)

  __cmp__: (set) ->
    (new TypeError "cannot compare sets using cmp()").raise()

  __contains__: (other) ->
    return other in @value

  # Checks to see if this is equivalent to set
  __eq__: (set) ->
    for item in set
      if not @__contains__(item) return false
    for item in @value
      if not set.__contains__(item) return false
    return true

  # Checks to see if this is a superset of set
  __ge__: (set) ->
    for item in set
      if not @__contains__(item) return false
    return true
  
  __getattribute__: ->

  # Checks to see if this is a proper superset of set
  __gt__: (set) ->
    if @__eq__(set)
      return false
    for item in set
      if not @__contains__(item) return false
    return true
  
  # Inplace and operation. x.__iand__(y) changes x
  __iand__: (set) ->
    deletedKeys = List()
    for item in @value
      if not set.__contains__(item)
        deletedKeys.append(item)
    for deletedKey in deletedKeys
      @value.pop(deletedKey)
  
  __init__: ->
    
  __ior__: (set) ->
    for item in set
      @add(item)
  # Checks to see if this is a subset of set
  __le__: (set) ->
    for item in @value
      if not set.__contains__(item) return false
    return true

  __len__: ->
    return @value.__len__()

  # Checks to see if this is a proper subset of set, meaning this is a subset and not equal to set
  __lt__: (set) ->
    if @__eq__(set)
      return false
    for item in @value
      if not set.__contains__(item) return false
    return true

  # Checks to see if this is not equivalent to set
  __ne__: (set) ->
    return not @__eq__(set)

  __or__: (set) ->
    union = List()
    union.append(item) for item in @value
    union.append(item) for item in set
    return new Set(union)
    
  # Checks to see if this and set are disjoint, meaning this intersected with set is the empty set 
  isdisjoint: (set) ->
    return @__and__(set).__len__() == 0
  
  issubset: (set) ->
    return @__le__(set)
  
  issuperset: (set) ->
    return @__ge__(set)

class Set extends Iterable
  constructor: (iterable) ->
    @value = Dictionary() # set just is a wrapped version of our own Dictionary class
    for item in iterable
      @value.__setitem__(item) = true

  __contains__: (other) ->
    return other in @value

  __cmp__: (set) ->
    (new TypeError "cannot compare sets using cmp()").raise()

  # Checks to see if this is a proper subset of set, meaning this is a subset and not equal to set
  __lt__: (set) ->
    if @__eq__(set)
      return false
    for item in @value
      if not set.__contains__(item) return false
    return true
  
  # Checks to see if this is a subset of set
  __le__: (set) ->
    for item in @value
      if not set.__contains__(item) return false
    return true

  # Checks to see if this is equivalent to set
  __eq__: (set) ->
    for item in set
      if not @__contains__(item) return false
    for item in @value
      if not set.__contains__(item) return false
    return true

  # Checks to see if this is not equivalent to set
  __ne__: (set) ->
    return not @__eq__(set)

  # Checks to see if this is a proper superset of set
  __gt__: (set) ->
    if @__eq__(set)
      return false
    for item in set
      if not @__contains__(item) return false
    return true

  # Checks to see if this is a superset of set
  __ge__: (set) ->
    for item in set
      if not @__contains__(item) return false
    return true

  # Checks to see if this and set are disjoint, meaning this intersected with set is the empty set 
  isdisjoint: (set) ->
    return @__and__(set).__len__() == 0
  
  issubset: (set) ->
    return @__le__(set)
  
  issuperset: (set) ->
    return @__ge__(set)

  __len__: ->
    return @value.__len__()

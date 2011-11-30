class Set extends Iterable
  constructor: (iterable) ->
    @dict = Dictionary() # set just is a wrapped version of our own Dictionary class
    for item in iterable
      @dict.__setitem__(item) = true

  __contains__: (other) ->
    return other in @dict

  __cmp__: (set) ->
    (new TypeError "cannot compare sets using cmp()").raise()

  __lt__: (set) ->
    if @__eq__(set)
      return false
    for item in @dict
      if not set.__contains__(item) return false
    return true
    
  __le__: (set) ->
    for item in @dict
      if not set.__contains__(item) return false
    return true

  __eq__: (set) ->
    for item in set
      if not @__contains__(item) return false
    for item in @dict
      if not set.__contains__(item) return false
    return true

  __ne__: (set) ->
    return not @__eq__(set)

  __gt__: (set) ->
    if @__eq__(set)
      return false
    for item in set
      if not @__contains__(item) return false
    return true

  __ge__: (set) ->
    for item in set
      if not @__contains__(item) return false
    return true

  isdisjoint: (set) ->
    return @__and__(set).__len__() == 0
  
  issubset: (set) ->
    return @__le__(set)
  
  issuperset: (set) ->
    return @__ge__(set)

  __len__: ->
    return @dict.__len__()

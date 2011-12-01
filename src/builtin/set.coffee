# http://docs.python.org/library/stdtypes.html#set-types-set-frozenset
class Set extends Iterable
  constructor: (iterable) ->
    @value = Dictionary() # set just is a wrapped version of our own Dictionary class
    for item in iterable.value
      @value.__setitem__(item, true)

  __and__: (other) ->
    intersect = List()
    intersect.append(item) for item in @value.value when other.__contains__(item)
    return new Set(intersect)

  __cmp__: (set) ->
    (new TypeError "cannot compare sets using cmp()").raise()

  __contains__: (other) ->
    return other in @value.value

  # Checks to see if this is equivalent to set
  __eq__: (set) ->
    for item in set.value
      if not @__contains__(item)
        return false
    for item in @value.value
      if not set.__contains__(item)
        return false
    return true

  # Checks to see if this is a superset of set
  __ge__: (set) ->
    for item in set.value
      if not @__contains__(item)
        return false
    return true
  
  __getattribute__: ->

  # Checks to see if this is a proper superset of set
  __gt__: (set) ->
    if @__eq__(set)
      return false
    for item in set.value
      if not @__contains__(item)
        return false
    return true
  
  # Inplace and operation. x.__iand__(y) changes x
  __iand__: (set) ->
    deletedKeys = List()
    for item in @value.value
      if not set.__contains__(item)
        deletedKeys.append(item)
    for deletedKey in deletedKeys.value
      @value.pop(deletedKey)
    return @
  
  __init__: ->
    
  __ior__: (set) ->
    for item in set.value
      @add(item)
    return @
  
  __isub__: (set) ->
    for item in set.value
      if @__contains__(item)
        @value.pop(item)
    return @

  __iter__: ->
    return new Iterator(@)
  
  __ixor__: (set) ->
    xorKeys = List()
    for item in set.value
      if not @__contains__(item)
        xorKeys.append(item)
    for item in @value.value
      if not set.__contains__(item)
        xorKeys.append(item)
    @clear()
    for item in xorKeys.value
        @add(item)
    return @

  # Checks to see if this is a subset of set
  __le__: (set) ->
    for item in @value.value
      if not set.__contains__(item)
        return false
    return true

  __len__: ->
    return @value.__len__()

  # Checks to see if this is a proper subset of set, meaning this is a subset and not equal to set
  __lt__: (set) ->
    if @__eq__(set)
      return false
    for item in @value.value
      if not set.__contains__(item)
        return false
    return true

  # Checks to see if this is not equivalent to set
  __ne__: (set) ->
    return not @__eq__(set)

  __or__: (set) ->
    union = List()
    union.append(item) for item in @value.value
    union.append(item) for item in set.value
    return new Set(union)

  # Same as and since intersection is symmetric
  __rand__: (set) ->
    return @__and__(set)
    
  __reduce__: ->
  
  __repr__: ->
  
  # Same as and since union is symmetric  
  __ror__: (set) ->
    return @__or__(set)

  __rsub__: (set) ->
    return set.__sub__(@)
  
  # Same as and since xor is symmetric  
  __rxor__: (set) ->
    return @__xor__(set)

  __sizeof__: ->
  
  __sub__: (set) ->
    difference = @copy()
    for item in set.value
      if @__contains__(item)
        difference.value.pop(item)
    return difference

  __xor__: (set) ->
    diff1 = @__sub__(set)
    diff2 = set.__sub__(xor)
    xor = diff1.__or__(diff2)
    return xor
  
  add: (element) ->
    @value.__setitem__(item, true)
    return
    
  clear: ->
    @value.clear()
  
  # Returns a shallow copy of this
  copy: ->
    return new Set(@)
  
  difference: (others...) ->
    difference = @copy()
    for other in others
      difference.__isub__(other)
    return difference

  difference_update: (others...) ->
    for other in others
      @__isub__(other)
    return

  discard: (elem) ->
    @value.pop(elem)
    return

  intersection: (others...) ->
    intersect = @copy()
    for other in others
      intersect.__isub__(other)
    return intersect

  intersection_update: (others...) ->
    for other in others
      @.__isub__(other)
    return

  # Checks to see if this and set are disjoint, meaning this intersected with set is the empty set 
  isdisjoint: (set) ->
    return @__and__(set).__len__() == 0
  
  issubset: (set) ->
    return @__le__(set)
  
  issuperset: (set) ->
    return @__ge__(set)

  pop: ->
    if @value.__len__ == 0
      (new KeyError "'pop from an empty set'").raise()
    else
      keys = @value.keys()
      randomKey = keys[0]
      @value.pop(randomKey)
      return randomKey

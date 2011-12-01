# http://docs.python.org/library/stdtypes.html#set-types-set-frozenset
class Set extends Iterable
  constructor: (iterable) ->
    @value = Dictionary() # set just is a wrapped version of our own Dictionary class
    for item in iterable?.value # Handles empty constructor call too
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
  
  # **Unimplemented**
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
  
  # **Unimplemented**
  __init__: ->
  
  # Inplace set union
  __ior__: (set) ->
    for item in set.value
      @add(item)
    return @
  
  # Inplace set difference
  __isub__: (set) ->
    for item in set.value
      if @__contains__(item)
        @value.pop(item)
    return @

  __iter__: ->
    return new SetIterator(@)
  
  # Inplace xor
  __ixor__: (set) ->
    diff1 = @__sub__(set)
    diff2 = set.__sub__(xor)
    xor = diff1.__or__(diff2)
    @clear()
    for item in xor.value
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

  # Returns a new Set containing items from this or set
  __or__: (set) ->
    union = List()
    union.append(item) for item in @value.value
    union.append(item) for item in set.value
    return new Set(union)

  # Same as __and__ since intersection is symmetric
  __rand__: (set) ->
    return @__and__(set)
  
  # **Unimplemented**
  __reduce__: ->
  
  # **Unimplemented**
  __repr__: ->
  
  # Same as __or__ since union is symmetric  
  __ror__: (set) ->
    return @__or__(set)

  # Subtract this from set
  __rsub__: (set) ->
    return set.__sub__(@)
  
  # Same as __xor__ since xor is symmetric  
  __rxor__: (set) ->
    return @__xor__(set)

  # **Unimplemented**
  __sizeof__: ->
  
  # Subtract new set containing this - set
  __sub__: (set) ->
    difference = @copy()
    for item in set.value
      if @__contains__(item)
        difference.value.pop(item)
    return difference

  # Returns new Set containing items in this or set, but not both
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
  
  # Returns a new set containing items in this but not any set in others
  difference: (others...) ->
    difference = @copy()
    for other in others
      difference.__isub__(other)
    return difference
  
  # Inplace difference of this and every set in others
  difference_update: (others...) ->
    for other in others
      @__isub__(other)
    return

  # Removes an element from the this if it can, otherwise does nothing
  discard: (elem) ->
    if @value.__contains__(elem)
      @value.pop(elem)
    return

  # Returns new set containing elements in common with this and each set in others
  intersection: (others...) ->
    intersect = @copy()
    for other in others
      intersect.__iand__(other)
    return intersect

  # Inplace update of this, keeping values only found in it and all others
  intersection_update: (others...) ->
    for other in others
      @__iand__(other)
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
      (new KeyError "pop from an empty set").raise()
    else
      randomItem = @value.popitem() # dict.popitem() pops a random item
      randomKey = randomItem.__getitem__(0)
      return randomKey

  remove: (elem) ->
    if elem not in @value.value
      (new KeyError "#{elem}").raise()
    else
      @value.pop(elem)
    return

  symmetric_difference: (other) ->
    return @__xor__(other)

  symmetric_difference_update: (other) ->
    @__ixor__(other)
    return

  union: (others...) ->
    union = @copy()
    for other in others
      union.__ior__(other)
    return union

  update: (others...) ->
    for other in others
      @__ior__(other)
    return
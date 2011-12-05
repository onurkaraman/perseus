# http://docs.python.org/library/stdtypes.html#set
class Set extends Iterable
  constructor: (iterable) ->
    @value = new Dict() # set just is a wrapped version of our own Dict class
    if iterable?
      for item in iterable # Handles empty constructor call too
        @value.__setitem__(item, true)

  __and__: (other) ->
    intersect = []
    intersect.push(item) for item in @value.value when other.__contains__(item)
    return new Set(intersect)

  __cmp__: (set) ->
    (new TypeError "cannot compare sets using cmp()").raise()

  __contains__: (other) ->
    return @value.__contains__(other)

  # Checks to see if this is equivalent to set
  __eq__: (set) ->
    for item in set.value.keys()
      if not @__contains__(item)
        return false
    for item in @value.keys()
      if not set.__contains__(item)
        return false
    return true

  # Checks to see if this is a superset of set
  __ge__: (set) ->
    for item in set.value.keys()
      if not @__contains__(item)
        return false
    return true
  
  # **Unimplemented**
  __getattribute__: ->

  # Checks to see if this is a proper superset of set
  __gt__: (set) ->
    if @__eq__(set)
      return false
    for item in set.value.keys()
      if not @__contains__(item)
        return false
    return true
  
  # Inplace and operation. x.__iand__(y) changes x
  __iand__: (set) ->
    deletedKeys = []
    for item in @value.keys()
      if not set.__contains__(item)
        deletedKeys.push(item)
    for deletedKey in deletedKeys
      @value.pop(deletedKey)
    return @
  
  # **Unimplemented**
  __init__: ->
  
  # Inplace set union
  __ior__: (set) ->
    for item in set.value.keys()
      @add(item)
    return @
  
  # Inplace set difference
  __isub__: (set) ->
    for item in set.value.keys()
      if @__contains__(item)
        @value.pop(item)
    return @

  __iter__: ->
    return new SetIterator(@)
  
  # Inplace xor
  __ixor__: (set) ->
    diff1 = @__sub__(set)
    diff2 = set.__sub__(@)
    xor = diff1.__or__(diff2)
    @clear()
    for item in xor.value.keys()
        @add(item)
    return @

  # Checks to see if this is a subset of set
  __le__: (set) ->
    for item in @value.keys()
      if not set.__contains__(item)
        return false
    return true

  # Gets the len of this set
  __len__: ->
    return @value.__len__()

  # Checks to see if this is a proper subset of set, meaning this is a subset and not equal to set
  __lt__: (set) ->
    if @__eq__(set)
      return false
    for item in @value.keys()
      if not set.__contains__(item)
        return false
    return true

  # Checks to see if this is not equivalent to set
  __ne__: (set) ->
    return not @__eq__(set)

  # Returns a new Set containing items from this or set
  __or__: (set) ->
    union = []
    union.push(item) for item in @value.keys()
    union.push(item) for item in set.value.keys()
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
    for item in set.value.keys()
      if @__contains__(item)
        difference.value.pop(item)
    return difference

  # Returns new Set containing items in this or set, but not both
  __xor__: (set) ->
    diff1 = @__sub__(set)
    diff2 = set.__sub__(@)
    xor = diff1.__or__(diff2)
    return xor
  
  # http://docs.python.org/library/stdtypes.html#set.add
  add: (element) ->
    @value.__setitem__(element, true)
    return
    
  # http://docs.python.org/library/stdtypes.html#set.clear
  clear: ->
    @value.clear()
  
  # http://docs.python.org/library/stdtypes.html#set.copy
  copy: ->
    keys = @keys()
    return new Set(keys)
  
  # http://docs.python.org/library/stdtypes.html#set.difference
  difference: (others...) ->
    difference = @copy()
    for other in others
      difference.__isub__(other)
    return difference
  
  # http://docs.python.org/library/stdtypes.html#set.difference_update
  difference_update: (others...) ->
    for other in others
      @__isub__(other)
    return

  # http://docs.python.org/library/stdtypes.html#set.discard
  discard: (elem) ->
    if @value.__contains__(elem)
      @value.pop(elem)
    return

  # http://docs.python.org/library/stdtypes.html#set.intersection
  intersection: (others...) ->
    intersect = @copy()
    for other in others
      intersect.__iand__(other)
    return intersect

  # http://docs.python.org/library/stdtypes.html#set.intersection_update
  intersection_update: (others...) ->
    for other in others
      @__iand__(other)
    return

  # http://docs.python.org/library/stdtypes.html#set.isdisjoint
  isdisjoint: (set) ->
    return @__and__(set).__len__() == 0
  
  # http://docs.python.org/library/stdtypes.html#set.issubset
  issubset: (set) ->
    return @__le__(set)
  
  # http://docs.python.org/library/stdtypes.html#set.issuperset
  issuperset: (set) ->
    return @__ge__(set)

  # http://docs.python.org/library/stdtypes.html#set.pop
  pop: ->
    if @value.__len__ == 0
      (new KeyError "pop from an empty set").raise()
    else
      randomItem = @value.popitem() # dict.popitem() pops a random item
      randomKey = randomItem.__getitem__(0)
      return randomKey

  # http://docs.python.org/library/stdtypes.html#set.remove
  remove: (elem) ->
    if elem not in @value.value
      (new KeyError "#{elem}").raise()
    else
      @value.pop(elem)
    return

  # http://docs.python.org/library/stdtypes.html#set.symmetric_difference
  symmetric_difference: (other) ->
    return @__xor__(other)

  # http://docs.python.org/library/stdtypes.html#set.symmetric_difference_update
  symmetric_difference_update: (other) ->
    @__ixor__(other)
    return

  # http://docs.python.org/library/stdtypes.html#set.union
  union: (others...) ->
    union = @copy()
    for other in others
      union.__ior__(other)
    return union

  # http://docs.python.org/library/stdtypes.html#set.update
  update: (others...) ->
    for other in others
      @__ior__(other)
    return

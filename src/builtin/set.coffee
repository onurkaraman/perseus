# http://docs.python.org/library/stdtypes.html#set
class Set extends Iterable
  constructor: (iterable) ->
    @value = new Dict() # set just is a wrapped version of our own Dict class
    if iterable?
      for item in iterable # Handles empty constructor call too
        @value.__setitem__(item, new Bool(true))

  __and__: (otherSet) ->
    intersect = new Set()
    intersect.__or__(item) for item of @value.value when otherSet.__contains__(item).value
    return intersect

  __cmp__: (otherSet) ->
    raise new TypeError("cannot compare sets using cmp()")

  __contains__: (item) ->
    return @value.__contains__(item)

  # Checks to see if this is equivalent to set
  __eq__: (otherSet) ->
    xorSet = @__xor__(otherSet)
    return len(xorSet).__eq__(new Int(0))

  # Checks to see if this is a superset of set
  __ge__: (otherSet) ->
    for item in otherSet.value.keys().value
      if not @__contains__(item).value
        return new Bool(false)
    return new Bool(true)
  
  # **Unimplemented**
  __getattribute__: ->

  # Checks to see if this is a proper superset of set
  __gt__: (otherSet) ->
    if @__eq__(otherSet).value
      return new Bool(false)
    return @__ge__(otherSet)
  
  # **Unimplemented**
  __init__: ->

  __iter__: ->
    return new SetIterator(@)

  # Checks to see if this is a subset of set
  __le__: (otherSet) ->
    for item in @value.keys().value
      if not otherSet.__contains__(item).value
        return new Bool(false)
    return new Bool(true)

  # Gets the len of this set
  __len__: ->
    return @value.__len__()

  # Checks to see if this is a proper subset of set, meaning this is a subset and not equal to set
  __lt__: (otherSet) ->
    if @__eq__(otherSet).value
      return new Bool(false)
    return @__le__(otherSet)

  # Checks to see if this is not equivalent to set
  __ne__: (set) ->
    return new Bool(not @__eq__(set).value)

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
      if @__contains__(item).value
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
    @value.__setitem__(element, new Bool(true))
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
    if @__contains__(elem).value
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
    if len(@).value == 0
      raise new KeyError("pop from an empty set")
    else
      randomItem = @value.popitem() # dict.popitem() pops a random item
      randomKey = randomItem.__getitem__(0)
      return randomKey

  # http://docs.python.org/library/stdtypes.html#set.remove
  remove: (elem) ->
    if elem not in @value.value
      raise new KeyError("#{elem}")
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

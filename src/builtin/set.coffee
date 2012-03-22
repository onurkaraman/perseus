# http://docs.python.org/library/stdtypes.html#set
class Set extends Iterable
  constructor: (iterable) ->
    @value = new Dict() # set just is a wrapped version of our own Dict class
    if iterable?
      for item in iterable.value # Temporary assumption: iterable is List of pythonic objects
        @value.__setitem__(item, new Bool(true))

  __and__: (otherSet) ->
    intersect = new Set()
    intersect.__ior__(item) for item of @value.keys().value when otherSet.__contains__(item).value
    return intersect

  __cmp__: (otherSet) ->
    raise new TypeError("cannot compare sets using cmp()")

  __contains__: (item) ->
    return @value.__contains__(item)

  # Checks to see if this is equivalent to otherSet
  __eq__: (otherSet) ->
    xorSet = @__xor__(otherSet)
    return len(xorSet).__eq__(new Int(0))

  # Checks to see if this is a superset of otherSet
  __ge__: (otherSet) ->
    for item in otherSet.value.keys().value
      if not @__contains__(item).value
        return new Bool(false)
    return new Bool(true)
  
  # **Unimplemented**
  __getattribute__: ->

  # Checks to see if this is a proper superset of otherSet
  __gt__: (otherSet) ->
    if @__eq__(otherSet).value
      return new Bool(false)
    return @__ge__(otherSet)
  
  # **Unimplemented**
  __init__: ->

  __iter__: ->
    return new SetIterator(@)

  # Checks to see if this is a subset of otherSet
  __le__: (otherSet) ->
    for item in @value.keys().value
      if not otherSet.__contains__(item).value
        return new Bool(false)
    return new Bool(true)

  # Gets the len of this set
  __len__: ->
    return @value.__len__()

  # Checks to see if this is a proper subset of otherSet, meaning this is a subset and not equal to otherSet
  __lt__: (otherSet) ->
    if @__eq__(otherSet).value
      return new Bool(false)
    return @__le__(otherSet)

  # Checks to see if this is not equivalent to otherSet
  __ne__: (otherSet) ->
    return new Bool(not @__eq__(otherSet).value)

  # Returns a new Set containing items from this or otherSet
  __or__: (otherSet) ->
    union = new List()
    union.append(item) for item in @value.keys().value
    union.append(item) for item in otherSet.value.keys().value
    return new Set(union)

  # Same as __and__ since intersection is symmetric
  __rand__: (otherSet) ->
    return @__and__(otherSet)
  
  # **Unimplemented**
  __reduce__: ->
  
  # **Unimplemented**
  __repr__: ->
  
  # Same as __or__ since union is symmetric  
  __ror__: (otherSet) ->
    return @__or__(otherSet)

  # Subtract this from otherSet
  __rsub__: (otherSet) ->
    return otherSet.__sub__(@)
  
  # Same as __xor__ since xor is symmetric  
  __rxor__: (otherSet) ->
    return @__xor__(otherSet)

  # **Unimplemented**
  __sizeof__: ->
  
  # Returns new set containing this - otherSet
  __sub__: (otherSet) ->
    difference = @copy()
    for item in otherSet.value.keys().value
      if @__contains__(item).value
        difference.value.pop(item)
    return difference

  # Returns new Set containing items in this or otherSet, but not both
  __xor__: (otherSet) ->
    diff1 = @__sub__(otherSet)
    diff2 = otherSet.__sub__(@)
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
    keys = @value.keys()
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
  isdisjoint: (otherSet) ->
    intersect = @__and__(otherSet)
    return len(intersect).__eq__(new Int(0))
  
  # http://docs.python.org/library/stdtypes.html#set.issubset
  issubset: (otherSet) ->
    return @__le__(otherSet)
  
  # http://docs.python.org/library/stdtypes.html#set.issuperset
  issuperset: (otherSet) ->
    return @__ge__(otherSet)

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
    if @value.__contains__(elem).value
      @value.pop(elem)
    else
      raise new KeyError("#{elem}")
    return

  # http://docs.python.org/library/stdtypes.html#set.symmetric_difference
  symmetric_difference: (otherSet) ->
    return @__xor__(otherSet)

  # http://docs.python.org/library/stdtypes.html#set.symmetric_difference_update
  symmetric_difference_update: (otherSet) ->
    @__ixor__(otherSet)
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

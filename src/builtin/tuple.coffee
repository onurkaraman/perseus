class Tuple extends Sequence
  constructor: (elements) ->
    @value = new List(elements)

  __add__: (otherTuple) ->
    otherList = new List(otherTuple.value)
    concatList = new List(@value)
    concatList.extend(otherList)
    return new Tuple(concatList)

  __contains__: (operand) ->
    return @value.__contains__(operand)

  __eq__: (otherTuple) ->
    return @value.__eq__(otherTuple.value)

  __ge__: (otherTuple) ->
    return @value.__ge__(otherTuple.value)

  # **Unimplemented**
  __getattribute__: (name) ->

  __getitem__: (index) ->
    return @value.__getitem__(index)

  # **Unimplemented**
  __getnewargs__: ->


  __getslice__: (leftIndex, rightIndex) ->
    return new Tuple(@value.__getslice__(leftIndex, rightIndex))

  __gt__: (otherTuple) ->
    return @value.__gt__(otherTuple.value)

  # Implementation found at http://effbot.org/zone/python-hash.htm
  __hash__: ->
    val = 0x345678
    for element in @value.value
      val = ((1000003 * val) & 0xFFFFFFFF) ^ hash(element)
    val = val ^ len(@).value
    if val is -1
      return new Int(-2)
    return new Int(val)

  __iter__: ->
    return new TupleIterator(@)

  __le__: (otherTuple) ->
    return @value.__le__(otherTuple.value)

  __len__: ->
    return len(@value)

  __lt__: (otherTuple) ->
    return @value.__lt__(otherTuple.value)

  __mul__: (scalar) ->
    result = new Tuple()
    for i in [1..scalar.value]
      result.__add__(@)
    return result

  __ne__: (otherTuple) ->
    return @value.__ne__(otherTuple.value)

  # **Unimplemented**
  __repr__: ->

  __rmul__: (scalar) ->
    return @__mul__(scalar)

  # **Unimplemented**
  __sizeof__: ->

  count: (operand) ->
    return @value.count(operand)

  index: (operand) ->
    return @value.index(operand)

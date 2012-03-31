class List extends Sequence
  constructor: (elements) ->
    if elements?
      @value = elements
    else
      @value = []
  
  __contains__: (operand) ->
    for element in @value
      if operand.__eq__(element).value
        return new Bool(true)
    return new Bool(false)

  __delitem__: (index) ->
    exceededNegativeRange = index.__abs__().__gt__(len(@)).value
    exceededPositiveRange = index.__ge__(len(@)).value
    if exceededNegativeRange or exceededPositiveRange
      raise new IndexError "list assignment index out of range"
    if index.value > -1
      @value.splice(index.value, 1)
    else
      @value.splice(len(@).value + index.value, 1)
    return
  
  # **Unimplemented**
  __delslice__: (leftIndex, rightIndex) ->

  __eq__: (otherList) ->
    if len(@).value != len(otherList).value
      return new Bool(false)
    for element, index in @value
      otherVal = otherList.__getitem__(new Int(index))
      if element.__ne__(otherVal).value
        return new Bool(false)
    return new Bool(true)

  __ge__: (otherList) ->
    return new Bool(not @__lt__(otherList).value)

  __getitem__: (index) ->
    exceededNegativeRange = index.__abs__().__gt__(len(@)).value
    exceededPositiveRange = index.__ge__(len(@)).value
    if exceededNegativeRange or exceededPositiveRange
      raise new IndexError "list index out of range"
    if index.value > -1
      @value[index.value]
    else
      @value[len(@).value + index.value]

  # **Unimplemented**
  __getslice__: (leftIndex, rightIndex) ->

  # http://www.linuxtopia.org/online_books/programming_books/python_programming/python_ch14s04.html
  __gt__: (otherList) ->
    minLength = Math.min(len(@).value, len(otherList).value)
    for index in [0...minLength]
      element = @__getitem__(new Int(index))
      otherElement = otherList.__getitem__(new Int(index))
      if (type(element) != type(otherElement))
        nameIsGreater = element.__class__().__name__() > otherElement.__class__().__name__() # if types don't match, compare type names
        return new Bool(nameIsGreater)
      else if element.__le__(otherElement).value
        return new Bool(false)
    return new Bool(true)

  __ne__: (otherList) ->
    return new Bool(not @__eq__(otherList).value)

  append: (element) ->
    @value.push element
    return
  
  extend: (list) ->
    @__iadd__ list
    return
    
  insert: (index, element) ->
    @value.splice index, 0, element
    return
    
  remove: (element) ->
    @value = @pop @index element
    return
    
  pop: (index = new Int @__len__().value - 1) ->
    if @__len__().value == 0
      raise new IndexError "pop from empty list"
    else if index.value < 0 or index.value >= @__len__().value
      raise new IndexError "pop index out of range"
    else
      [removed] = @value.splice index.value, 1 # Javascript returns array. Just want element
      removed
    
  sort: ->
    @value = 
      @value
      .sort (a, b) ->
        if a.__lt__ b
          return -1
        else if a.__eq__ b
          return 0
        else if a.__gt__ b
          return 1
    return
    
  reverse: (operand) ->
    @value = @value.reverse()
    return

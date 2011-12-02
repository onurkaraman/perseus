class List extends Sequence
  constructor: (elements) ->
    if elements?
      @value = elements
    else
      @value = []
  
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
      (new IndexError "pop from empty list").raise()
    else if index.value < 0 or index.value >= @__len__().value
      (new IndexError "pop index out of range").raise()
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
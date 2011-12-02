class List extends Sequence
  constructor: (elements) ->
    if not elements?
      @value = []
    else
      @value = elements
  
  append: (element) ->
    @value.push(element)
    return
  
  extend: (list) ->
    @__iadd__(list)
    return
    
  insert: (index, element) ->
    @value.splice(index, 0, element)
    return
    
  remove: (element) ->
    @value = @pop(@index(element))
    return
    
  pop: (index)  ->
    @value = @value.splice(index, 1)
    return
    
  sort: ->
    @value = 
      @value
      .sort (a, b) ->
        if a.__lt__(b)
          return -1
        else if a.__eq__(b)
          return 0
        else if a.__gt__(b)
          return 1
    return
    
  reverse: (operand) ->
    @value = @value.reverse()
    return
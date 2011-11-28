class List extends Sequence
  append: (element) ->
    @value.push(element)
    return
  
  extend: (list) ->
    @__iadd__(list)
    return
    
  insert: (index, element) ->
    
  remove: (element) ->
    @pop(@index(element))
    return
    
  pop: (index)  ->
    
  sort: ->
    
  reverse: (operand) ->
    @value.reverse()

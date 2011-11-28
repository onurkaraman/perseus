class Sequence extends Primitive
  __add__: (operand) ->
    if isSubInstance operand, @
      return @value.concat(operand.value)
    else
      super operand
    
  __contains__: (operand)->
    return operand.value in @value
    
  __len__: ->
    return @value.length
    
  __min__: ->
    @value reduce (a, b) ->
      return a if a <= b else b
      
  __max__: ->
    @value reduce (a, b) ->
      return a if a >= b else b
  
  __mul__: (operand) ->
    if 'Integer' in operand.__class__.__bases__
      newValue = new @::constructor()
      for i in [0...operand.value]
        newValue.__iadd__(@value)
      return newValue
    else
      super operand

  __slice__: (start, end, step)->
    if not step?
      return @value.slice(start, end)
    else
      # TODO: implementation for step > 1
      
  __iadd__: (operand) ->
    return @value = @value.__add__(operand)
  
  __imul__: (operand) ->
    return @value = @value.__mul__(operand)
      
  # TODO: The above `__contains__` uses a fallback definition of Array.prototype
  # .indexOf.  Any way to trigger this?  
  index: (operand) ->
    return Array.prototype.indexOf(@value, operand.value)
    
  count: (operand) ->
    total = 0
    for element in @value
      if element.__eq__(operand)
        total += 1
        
    return total
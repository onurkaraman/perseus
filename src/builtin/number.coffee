class Number extends Primitive
  __abs__: ->
    if (@value < 0)
      return @__neg__()
    else
      return @value
      
  __add__: (operand) ->
    if isSubInstance operand, @
      return @value + operand.value
    else
      super operand
  
  __div__: (operand) ->
    if isSubInstance(operand, @)
      return @value / operand.value
    else
      super operand
      
  __floordiv__: (operand) ->
    if isSubInstance operand, @
      return Math.floor(@value / operand.value)
    else
      super operand
  
  __mul__: (operand) ->
    if isSubInstance(operand, @)
      return @value * operand.value
    else
      super operand
  
  __neg__: ->
    return -@value
    
  __pos__: ->
    return +@value
    
  __pow__: (operand) ->
    if isSubInstance(operand, @)
      return Math.pow(@value, operand.value)
    else
      super operand
    
  __sub__: (operand) ->
    if isSubInstance operand, @
      return @value - operand.value
    else
      super operand
  
  # In-place operators
  # XXX: Should not be allowed to do these on literals
  # This is currently caught by the ASTparser.
  __iadd__: (operand) ->
    return @value = @__add__(operand)

  __ifloordiv__: (operand) ->
    return @value = @__floordiv__(operand)
      
  __imul__: (operand) ->
    return @value = @__mul__(operand)
      
  __ipow__: (operand) ->
    return @value = @__pow__(operand)
    
  __isub__: (operand) ->
    return @value = @__sub__(operand)

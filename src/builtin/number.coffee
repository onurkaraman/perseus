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
      
  __floordiv__: (operand) ->
    if isSubInstance operand, @
      return Math.floor(@value / operand.value)
    else
      super operand
  
  __neg__: ->
    return -@value
    
  __pos__: ->
    return +@value
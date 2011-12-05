class Num extends Primitive
  __abs__: ->
    if (@value < 0)
      @__neg__()
    else
      @
      
  __add__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value + operand.value
    else
      super operand
  
  __div__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value / operand.value
    else
      super operand
  
  # **Fix-me**
  #
  #     Math.floor(7.2, 3)
  #
  # yields 2.0 in Python and 2 in JS
  # Should also probably return a `Float` instead of the same type as `this`
  __floordiv__: (operand) ->
    if issubinstance operand, @
      new (type(@)) Math.floor(@value / operand.value)
    else
      super operand
  
  __mul__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value * operand.value
    else
      super operand
  
  __neg__: ->
    new (type(@)) -@value
    
  __pos__: ->
    new (type(@)) +@value
    
  __pow__: (operand) ->
    if issubinstance operand, @
      new (type(@)) Math.pow @value, operand.value
    else
      super operand
    
  __sub__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value - operand.value
    else
      super operand
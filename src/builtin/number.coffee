class Number extends Primitive
  __abs__: ->
    if (@value < 0)
      return -@value
    else
      return @value
      
  __add__: (other) ->
    return @value + other.value
      
  __floordiv__: (other) ->
    return Math.floor(@value / other.value)
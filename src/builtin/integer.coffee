# http://docs.python.org/library/operator.html
class Integer extends Number
  constructor: (@value) ->  
  
  __and__: (other) ->
    # TODO: verify other type is also 'Integer'.  If not, use Primitive.method()
    return @value & other.value
  
  __div__: (other) ->
    otherType = getType(other)
    
    if otherType is 'Integer'
      return @__floordiv__(other)
    else if otherType is 'Float'
      return @value / other.value

  __invert__: ->
    return ~@value
  
  __lshift__: (bits) ->
    # TODO: verify other type is also 'Integer'.  If not, use Primitive.method()
    return @value << bits
  
  __mod__: (divisor) ->
    # TODO: verify other type is also 'Integer'.  If not, use Primitive.method()
    return @value % divisor
    
  

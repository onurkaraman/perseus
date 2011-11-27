# http://docs.python.org/library/operator.html
class Integer extends Number
  constructor: (@value) ->  
  
  __and__: (other) ->
    if other.__isType__('Integer')
      return @value & other.value
    else
      return Primitive.__and__.call(this, other)
  
  __div__: (other) ->
    otherType = getType(other)
    
    if otherType is 'Integer'
      return @__floordiv__(other)
    else if otherType is 'Float'
      return @value / other.value

  __invert__: ->
    return ~@value
  
  __lshift__: (bits) ->
    if bits.__isType__('Integer')
      return @value << bits.value
    else
      return Primitive.__lshift__.call(this, bits)
  
  __mod__: (divisor) ->
    if divisor.__isType__('Integer')
      return @value % divisor.value
    else
      return Primitive.__mod__.call(this, divisor)
    
  __mul__: (other) ->
    if other.__isType__('Integer')
      return @value * other.value
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    else if other.__isType__('String')
      return String.__mul__.call(other, this)
    # TODO: need to add another branch for lists
    else
      return Primitive.__mul__.call(this, other)
    
  

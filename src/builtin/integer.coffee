# http://docs.python.org/library/operator.html
class Integer extends Number
  __and__: (operand) ->
    if operand.__isType__('Integer')
      return @value & operand.value
    else
      return Object.__and__.call(this, operand)
  
  __div__: (operand) ->
    operandType = getType(operand)
    
    if operandType is 'Integer'
      return @__floordiv__(operand)
    else if operandType is 'Float'
      return @value / operand.value

  __invert__: ->
    return ~@value
  
  __lshift__: (operand) ->
    if operand.__isType__('Integer')
      return @value << operand.value
    else
      return Object.__lshift__.call(this, operand)
  
  __mod__: (operand) ->
    if operand.__isType__('Integer')
      return @value % operand.value
    else
      return Object.__mod__.call(this, operand)
    
  __mul__: (operand) ->
    if operand.__isType__('Number')
      return @value * operand.value
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    else if operand.__isType__('String')
      return String.__mul__.call(operand, this)
    # TODO: need to add another branch for lists
    else
      return Object.__mul__.call(this, operand)
    
  

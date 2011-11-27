# http://docs.python.org/library/operator.html
class Integer extends Number
  __and__: (operand) ->
    operandType = operand.__class__.__name__
    
    if operandType is 'Integer'
      return @value & operand.value
    else
      super operand
  
  __div__: (operand) ->
    operandType = operand.__class__.__name__
    
    if operandType is 'Integer'
      return @__floordiv__(operand)
    else if operandType is 'Float'
      return @value / operand.value
    else
      super operand

  __invert__: ->
    return ~@value
  
  __lshift__: (operand) ->
    operandType = operand.__class__.__name__
    if operandType is 'Integer'
      return @value << operand.value
    else
      super operand
  
  __mod__: (operand) ->
    operandType = operand.__class__.__name__
    if operandType is 'Integer'
      return @value % operand.value
    else
      super operand
    
  __mul__: (operand) ->
    operandType = operand.__class__.__name__
    if operandType is 'Number'
      return @value * operand.value
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    else if operandType is 'String'
      return String.__mul__.call(operand, this)
    # TODO: need to add another branch for lists
    else
      super operand
    
  

# http://docs.python.org/library/operator.html
class Integer extends Number
  __and__: (operand) ->
    if isSubInstance(operand, @)
      return @value & operand.value
    else
      super operand
  
  __div__: (operand) ->
    if isSubInstance(operand, @)
      return @__floordiv__(operand)
    else
      super operand

  __invert__: ->
    return ~@value
  
  __lshift__: (operand) ->
    if isSubInstance(operand, @)
      return @value << operand.value
    else
      super operand
  
  __mod__: (operand) ->
    if isSubInstance(operand, @)
      return @value % operand.value
    else
      super operand
    
  __mul__: (operand) ->
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    if 'String' in operand.__class__.__bases__
      return String.__mul__.call(operand, this)
    # TODO: need to add another branch for lists
    else
      super operand
  
  __or__: (operand) ->
    if isSubInstance(operand, @)
      return @value | operand.value
    else
      super operand
  
  __rshift__: (operand) ->
    if isSubInstance(operand, @)
      return @value >> operand.value
    else
      super operand
    
  __xor__: (operand) ->
    if isSubInstance(operand, @)
      return @value ^ operand.value
    else
      super operand

  __iand__: (operand) ->
    return @value = @.__and__(operand)
  
  __idiv__: (operand) ->
    return @value = @.__div__(operand)
      
  __ilshift__: (operand) ->
    return @value = @.__lshift__(operand)
      
  __imod__: (operand) ->
    return @value = @.__mod__(operand)
      
  __ior__: (operand) ->
    return @value = @.__or__(operand)
    
  __irshift__: (operand) ->
    return @value = @.__rshift__(operand)

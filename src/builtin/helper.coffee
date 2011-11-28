# Returns whether or not obj1's type is a subclass of obj2's type.
isSubInstance = (obj1, obj2) ->
  return obj2.__class__.__name__ in obj1.__class__.__bases__
    
raiseUnaryException: (operator, operand) ->
  operandType = operand.__class__.__name__
  throw new TypeError "bad operand type for #{operator}: '#{operandType}'"
  
raiseBinaryException: (operator, operand1, operand2) ->
  operand1Type = operand1.__class__.__name__
  operand2Type = operand2.__class__.__name__
  throw new TypeError "unsupported operand type(s) for #{operator}: '#{operand1Type}' and '#{operand2Type}'"
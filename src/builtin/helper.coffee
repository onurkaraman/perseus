class Helper
  # Takes either an instance or a class as an argument.
  # Returns the string representation of the class name.
  getClass: (object) ->
    # Object.prototype.toString.call(object).slice(8, -1)
    object.constructor.name
  
  # Returns whether or not obj1's type is a subclass of obj2's type.
  isSubInstance: (obj1, obj2) ->
    obj2.__class__.__name__ in obj1.__class__.__bases__
      
  raiseUnaryException: (operator, operand) ->
    operandType = operand.__class__.__name__
    (new TypeError "bad operand type for #{operator}: '#{operandType}'").raise()
    
  raiseBinaryException: (operator, operand1, operand2) ->
    operand1Type = operand1.__class__.__name__
    operand2Type = operand2.__class__.__name__
    (new TypeError "unsupported operand type(s) for #{operator}: '#{operand1Type}' and '#{operand2Type}'").raise()
    
  raiseNotIterableException: (operand) ->
    operandType = operand.__class__.__name__
    (new TypeError("argument of type '#{type}' is not iterable")).raise()
    
  raiseNotSubscriptableException: (operand) ->
    operandType = operand.__class__.__name__
    (new TypeError("argument of type '#{type}' is not subscriptable")).raise()

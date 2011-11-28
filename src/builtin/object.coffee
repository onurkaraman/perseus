class Object
  @__bases__: ->
    # TODO: need to implement tuples - it's a tuple of the base classes
  
  @__name__: ->
    return Object.prototype.toString.call(@).slice(8, -1)
  
  # XXX: This appears to be the most accurate way to get the class of an object
  # Using `@prototype` fails for simple primitives such as ints and strings.  
  __class__: ->
    return @constructor.prototype
  
  __cmp__: (operand) ->
    if @.__lt__(operand)
      return -1
    if @.__eq__(operand)
      return 0
    if @.__gt__(operand)
      return 1
  
  # XXX: This appears to be how objects evaluate undefined operators.
  __lt__: (operand) ->
    return true
    
  __le__: (operand) ->
    return true
  
  __eq__: (operand) ->
    return false
    
  __ne__: (operand) ->
    return true
    
  __ge__: (operand) ->
    return true
    
  __gt__: (operand) ->
    return true
  
  __not__: ->
    return !@value
  #
    
  # These two functions are supposed to test for object equality.
  # We need to compare memory addresses, which may be JS implementation-
  # dependent.
  # [Relevant](http://stackoverflow.com/questions/639514/how-can-i-get-the-memory-address-of-a-javascript-variable)
  __is__: ->
    # TODO: Stub
    
  __is_not__: ->
    # TODO: Stub
  #
  
  __abs__: ->
    raiseUnaryException('abs()', @)
  
  __add__: (operand) ->
    raiseBinaryException('+', @, operand)
  
  __and__: (operand) ->
    raiseBinaryException('&', @, operand)
  
  __div__: (operand) ->
    raiseBinaryException('/', @, operand)
  
  __floordiv__: (operand) ->
    raiseBinaryException('//', @, operand)
  
  # Throw an exception, as it's only defined for integers in Python.
  __invert__: ->
    raiseUnaryException('unary ~', @)
    
  __lshift__: (operand) ->
    raiseBinaryException('<<', @, operand)
    
  __mod__: (operand) ->
    raiseBinaryException('%', @, operand)
  
  __mul__: (operand) ->
    raiseBinaryException('*', @, operand)
  
  __neg__: ->
    raiseUnaryException('unary -', @)

  __or__: (operand) ->
    raiseBinaryException('|', @, operand)
    
  __pos__: ->
    raiseUnaryException('unary +', @)
    
  __rshift__: (operand) ->
    raiseBinaryException('>>', @, operand)

  __sub__: (operand) ->
    raiseBinaryException('-', @, operand)
    
  __xor__: (operand) ->
    raiseBinaryException('^', @, operand)
    
  __iadd__: (operand) ->
    raiseBinaryException('+=', @, operand)
  
  __iand__: (operand) ->
    raiseBinaryException('&=', @, operand)
    
  __idiv__: (operand) ->
    raiseBinaryException('/=', @, operand)
    
  __ifloordiv__: (operand) ->
    raiseBinaryException('//=', @, operand)
    
  __ilshift__: (operand) ->
    raiseBinaryException('<<=', @, operand)

  __imod__: (operand) ->
    raiseBinaryException('%=', @, operand)
    
  __imul__: (operand) ->
    raiseBinaryException('*=', @, operand)
    
  __ior__: (operand) ->
    raiseBinaryException('|=', @, operand)
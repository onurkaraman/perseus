class Obj
  raiseUnaryException = (operator, operand) ->
    operandType = operand.__class__.__name__
    raise new TypeError "bad operand type for #{operator}: '#{operandType}'"
    
  raiseBinaryException = (operator, operand1, operand2) ->
    operand1Type = operand1.__class__.__name__
    operand2Type = operand2.__class__.__name__
    raise new TypeError "unsupported operand type(s) for #{operator}: '#{operand1Type}' and '#{operand2Type}'"
    
  raiseNotIterableException = (operand) ->
    operandType = operand.__class__.__name__
    raise new TypeError "argument of type '#{type}' is not iterable"
    
  raiseNotSubscriptableException = (operand) ->
    operandType = operand.__class__.__name__
    raise new TypeError "argument of type '#{type}' is not subscriptable"
  
  # __bases__ returns a tuple of classes it inherits from
  #
  # **To-do** 
  # *  Return a Tuple instead of a JS array.
  # *  __bases__ needs to be modifiable at runtime.  This means we actually need
  # to have a rewriter that converts the attribute loads into their equivalent
  # JS form - prototype.
  # * Support multiple inheritance.
  @__bases__: -> [@__super__.constructor]
    # if (@ == Obj)
      # return [@__name__()]
    # else
      # tree = @__super__.constructor.__bases__()
      # tree.push @__name__()
      # return tree
  
  @__name__: -> @.name
  
  # **To-do** See note about rewriting in @_bases().  
  __class__: -> type(@)
  
  __cmp__: (operand) ->
    if @__lt__(operand)
      return -1
    if @__eq__(operand)
      return 0
    if @__gt__(operand)
      return 1
  
  # This appears to be how objects evaluate undefined operators.
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
  
  # **Unimplemented**
  __is__: ->
 
  # **Unimplemented**   
  __is_not__: ->
 
  __contains__: ->
    type = @__class__.__name__
    raise new TypeError "argument of type '#{type}' is not iterable"
  
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
    
  __pow__: (operand) ->
    raiseBinaryException('**', @, operand)
    
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
    
  __ipow__: (operand) ->
    raiseBinaryException('**=', @, operand)
    
  __irshift__: (operand) ->
    raiseBinaryException('>>=', @, operand)
    
  __isub__: (operand) ->
    raiseBinaryException('-=', @, operand)
    
  __ixor__: (operand) ->
    raiseBinaryException('^=', @, operand)
    
  __contains__: (operand) ->
    raiseNotIterableException(@)
    
  __len__: ->
    type = @__class__.__name__
    raise new TypeError "object of type '#{type}' has no len()"
    
  __min__: ->
    raiseNotIterableException(@)
    
  __max__: ->
    raiseNotIterableException(@)
    
  __slice__: ->
    raiseNotSubscriptableException(@)
    

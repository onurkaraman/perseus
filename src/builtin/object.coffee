class Object
  __getType__: ->
    return Object.prototype.toString.call(@).slice(8, -1)
  
  # Argument needs to be a string.  Will traverse up the inheritance tree
  # looking to see if the string matches any of the classes
  __inherits__: (type) ->
    inheritanceLevel = @
    classString = @__getType__()
    
    # 'Undefined' means we've reached the end of the tree.  
    while classString isnt 'Undefined'
      if classString is typeAsString
        return true
      inheritanceLevel = @prototype
      classString = @__getType__()
    
    return false
  
  __raiseUnaryException__: (operator) ->
    throw new TypeError "bad operand type for #{operator}: '#{getType(this)}'"
  
  __raiseBinaryException__: (operator, operand) ->
    ownType = getType(this)
    operandType = getType(operand)
    throw new TypeError "unsupported operand type(s) for #{operator}: '#{ownType}' and '#{operandType}'"
  
  # TODO: python returns a 'classobj', e.g. <class __main__.Int at 0xdeadbeef>
  __class__: this
  
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
    @__raiseUnaryException__('abs()')
  
  __add__: (operand) ->
    @__raiseBinaryException__('+', operand)
  
  __and__: (operand) ->
    @__raiseBinaryException__('&', operand)
  
  __div__: (operand) ->
    @__raiseBinaryException__('/', operand)
  
  __floordiv__: (operand) ->
    @__raiseBinaryException__('//', operand)
  
  # Throw an exception, as it's only defined for integers in Python.
  __invert__: ->
    @__raiseUnaryException__('unary ~')
    
  __mod__: (operand) ->
    @__raiseBinaryException__('%', operand)
  
  __mul__: (operand) ->
    @__raiseBinaryException__('*', operand)
  
  __neg__: ->
    @__raiseUnaryException__('unary -')
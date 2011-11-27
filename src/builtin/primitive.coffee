# TODO: All user-created classes should inherit from this - how to make this
# seamless?
class Primitive
  
  __isType__: (type) ->
    inheritanceLevel = @
    classString = getType(@)
      
    while classString isnt 'Undefined'
      if classString is type
        return true
      inheritanceLevel = @prototype
      classString = getType(@)
    
    return false
  
  __raiseUnaryException__: (operand) ->
    throw new TypeError "bad operand type for #{operand}: '#{getType(this)}'"
  
  __raiseBinaryException__: (operand, other) ->
    ownType = getType(this)
    otherType = getType(other)
    throw new TypeError "unsupported operand type(s) for #{operand}: '#{ownType}' and '#{otherType}'"
  
  # TODO: python returns a 'classobj', e.g. <class __main__.Int at 0xdeadbeef>
  __class__: this
  
  __cmp__: (other) ->
    if @value < other.value
      return -1
    if @value is other.value
      return 0
    if @value > other.value
      return 1
  
  __lt__: (other) ->
    return @value < other.value
    
  __le__: (other) ->
    return @value <= other.value
  
  __eq__: (other) ->
    return @value == other.value
    
  __ne__: (other) ->
    return @value != other.value
    
  __ge__: (other) ->
    return @value >= other.value
    
  __gt__: (other) ->
    return @value > other.value
  
  __not__: ->
    return !@value
  
  # These two functions are supposed to test for object equality.
  # We need to compare memory addresses, which may be JS implementation-
  # dependent.
  # [Relevant](http://stackoverflow.com/questions/639514/how-can-i-get-the-memory-address-of-a-javascript-variable)
  __is__: ->
    # Stub
    
  __is_not__: ->
    # Stub
  #
  
  __abs__: ->
    @__raiseUnaryException__('abs()')
  
  __add__: (other) ->
    @__raiseBinaryException__('+', other)
  
  __and__: (other) ->
    @__raiseBinaryException__('&', other)
  
  __div__: (other) ->
    @__raiseBinaryException__('/', other)
  
  __floordiv__: (other) ->
    @__raiseBinaryException__('//', other)
  
  # Throw an exception, as it's only defined for integers in Python.
  __invert__: ->
    @__raiseUnaryException__('unary ~')
    
  __mod__: (divisor) ->
    @__raiseBinaryException__('%')
  
  __mul__: (divisor) ->
    @__raiseBinaryException__('*')
    
  # TODO: difference between __repr__ and __str__?
  # Need to consider how this will affect console.log / print / concatenation
  __str__: ->
    return @value
# http://docs.python.org/library/operator.html
class Int extends Num
  __and__: (operand) ->
    if issubinstance operand, @
      new Int @value & operand.value
    else
      super operand
  
  __div__: (operand) ->
    if issubinstance operand, @
      new Int @__floordiv__ operand
    else
      super operand

  # http://effbot.org/zone/python-hash.htm
  __hash__: ->
    if @value == -1
      return new Int(-2)
    return @
    
  __invert__: ->
    new Int ~@value
  
  __lshift__: (operand) ->
    if issubinstance operand, @
      new Int @value << operand.value
    else
      super operand
  
  __mod__: (operand) ->
    if issubinstance operand, @
      new Int @value % operand.value
    else
      super operand
    
  __mul__: (operand) ->
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    if issubclass type(operand), Sequence
      operand.__mul__ @
    # **To-do** Add another branch for lists.
    else if issubinstance operand, @
      new Int @value * operand.value
    else
      super operand
    
  __or__: (operand) ->
    if issubinstance operand, @
      new Int @value | operand.value
    else
      super operand
  
  __rshift__: (operand) ->
    if issubinstance operand, @
      new Int @value >> operand.value
    else
      super operand
    
  __xor__: (operand) ->
    if issubinstance operand, @
      new Int @value ^ operand.value
    else
      super operand

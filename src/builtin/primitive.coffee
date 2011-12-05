# A 'Primitive' is anything that is considered a Python built-in type
class Primitive extends Obj
  constructor: (@value) ->  
  
  # For these comparison operators, we are allowed to use their new definitions
  # iff the operand is a subclass of the current object, since the definition
  # would make sense in that context.  However, if it doesn't, we default to the
  # quirky implementation used by Python for generic objects.
  __lt__: (operand) ->
    if issubinstance operand, @
      new Bool @value < operand.value
    else
      super operand
    
  __le__: (operand) ->
    if issubinstance operand, @
      new Bool <= operand.value
    else
      super operand
  
  __eq__: (operand) ->
    if issubinstance operand, @
      new Bool @value == operand.value
    else
      super operand
    
  __ne__: (operand) ->
    if issubinstance operand, @
      new Bool @value != operand.value
    else
      super operand
    
  __ge__: (operand) ->
    if issubinstance operand, @
      new Bool @value >= operand.value
    else
      super operand
    
  __gt__: (operand) ->
    if issubinstance operand, @
      new Bool @value > operand.value
    else
      super operand
      
  #### In-place operators
  # **Consideration** 
  # Could probably refactor this into:
  # 
  #     __iadd__: inplace('add')
  #
  # and further refactor this into: 
  #
  #     for iop in ["__iadd__", ...]:
  #       @::[iop] = inplace(iop)
  #
  # but is this desirable? (readability)
  # 
  # Should not be allowed to do these on literals.
  # This is currently caught by the Python ASTparser.
  
  __iadd__: (operand) ->
    @value = @__add__(operand).value
    @
  
  __iand__: (operand) ->
    @value = @__and__(operand).value
    @
  
  __idiv__: (operand) ->
    @value = @__div__(operand).value
    @
      
  __ifloordiv__: (operand) ->
    @value = @__floordiv__(operand).value
    @
    
  __ilshift__: (operand) ->
    @value = @__lshift__(operand).value
    @
      
  __imod__: (operand) ->
    @value = @__mod__(operand).value
    @
    
  __imul__: (operand) ->
    @value = @__mul__(operand).value
    @
      
  __ior__: (operand) ->
    @value = @__or__(operand).value
    @
    
  __ipow__: (operand) ->
    @value = @__or__(operand).value
    @
    
  __irshift__: (operand) ->
    @value = @__rshift__(operand).value
    @

  __isub__: (operand) ->
    @value = @__sub__(operand).value
    @

  __ixor__: (operand) ->
    @value = @__xor__(operand).value
    @
    
  # **Consideration** What is the difference between __repr__ and __str__?
  # How does this affect console.log / print / concatenation?
  __str__: ->
    new Str @value.toString()
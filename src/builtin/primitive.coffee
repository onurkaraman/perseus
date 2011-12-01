# A 'Primitive' is anything that is considered a Python built-in type
class Primitive extends Obj
  constructor: (@value) ->  
  
  # For these comparison operators, we are allowed to use their new definitions
  # iff the operand is a subclass of the current object, since the definition
  # would make sense in that context.  However, if it doesn't, we default to the
  # quirky implementation used by Python for generic objects.
  __lt__: (operand) ->
    if isSubInstance operand, @
      return @value < operand.value
    else
      super operand
    
  __le__: (operand) ->
    if isSubInstance operand, @
      return @value <= operand.value
    else
      super operand
  
  __eq__: (operand) ->
    if isSubInstance operand, @
      return @value == operand.value
    else
      super operand
    
  __ne__: (operand) ->
    if isSubInstance operand, @
      return @value != operand.value
    else
      super operand
    
  __ge__: (operand) ->
    if isSubInstance operand, @
      return @value >= operand.value
    else
      super operand
    
  __gt__: (operand) ->
    if isSubInstance operand, @
      return @value > operand.value
    else
      super operand
    
  # **Consideration** What is the difference between __repr__ and __str__?
  # How does this affect console.log / print / concatenation?
  __str__: ->
    return @value.toString()

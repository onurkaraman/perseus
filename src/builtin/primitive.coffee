# A 'Primitive' is anything that is considered a JS primitive - it can be
# represented using 1 variable in Javascript
# e.g. Array, Boolean, Dictionary, Integer/Float, String
class Primitive extends Object
  constructor: (@value) ->  
  
  # For these comparison operators, we are allowed to use their new definitions
  # iff the operand is a subclass of the current object, since the definition
  # would make sense in that context.  However, if it doesn't, we default to the
  # quirky 
  __lt__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
      return @value < operand.value
    
  __le__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
      return @value <= operand.value
  
  __eq__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
      return @value == operand.value
    
  __ne__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
       return @value != operand.value
    
  __ge__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
      return @value >= operand.value
    
  __gt__: (operand) ->
    if not operand.__inherits__(@)
      super operand
    else
      return @value > operand.value
    
  # TODO: difference between __repr__ and __str__?
  # Need to consider how this will affect console.log / print / concatenation
  __str__: ->
    return @value
# A 'Primitive' is anything that is considered a JS primitive - it can be
# represented using 1 variable in Javascript
# e.g. Array, Boolean, Dictionary, Integer/Float, String
class Primitive extends Object
  constructor: (@value) ->  
  
  __lt__: (operand) ->
    return @value < operand.value
    
  __le__: (operand) ->
    return @value <= operand.value
  
  __eq__: (operand) ->
    return @value == operand.value
    
  __ne__: (operand) ->
    return @value != operand.value
    
  __ge__: (operand) ->
    return @value >= operand.value
    
  __gt__: (operand) ->
    return @value > operand.value
    
  # TODO: difference between __repr__ and __str__?
  # Need to consider how this will affect console.log / print / concatenation
  __str__: ->
    return @value
# http://docs.python.org/library/operator.html
class Int extends Num
  __and__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value & operand.value)
    else
      super operand
  
  __add__: (operand) ->
    if issubinstance(operand, @)
       new Int(@value + operand.value)
    else
      super operand

  __div__: (operand) ->
    if issubinstance(operand, @)
      new Int(@__floordiv__(operand))
    else
      super operand

  __invert__: ->  
    new Int(~@value)
  
  __lshift__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value << operand.value)
    else
      super operand
  
  __mod__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value % operand.value)
    else
      super operand
    
  __mul__: (operand) ->
    # String * Integer and Integer * String are interchangeable in Python and
    # represent a form of string concatenation
    if Sequence in operand.__class__().__bases__()
      operand.__mul__(@)
    # **To-do** Add another branch for lists.
    else if issubinstance(operand, @)
      new Int(@value * operand.value)
    else
      super operand
    
  __or__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value | operand.value)
    else
      super operand
  
  __rshift__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value >> operand.value)
    else
      super operand
    
  __xor__: (operand) ->
    if issubinstance(operand, @)
      new Int(@value ^ operand.value)
    else
      super operand

  __iand__: (operand) ->
    @value = @__and__(operand).value
    @
  
  __idiv__: (operand) ->
    @value = @__div__(operand).value
    @
      
  __ilshift__: (operand) ->
    @value = @__lshift__(operand).value
    @
      
  __imod__: (operand) ->
    @value = @__mod__(operand).value
    @
      
  __ior__: (operand) ->
    @value = @__or__(operand).value
    @
    
  __irshift__: (operand) ->
    @value = @__rshift__(operand).value
    @

  __ixor__: (operand) ->
    @value = @__xor__(operand).value
    @
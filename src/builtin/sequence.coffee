class Sequence extends Primitive
  __add__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value.concat(operand.value)
    else
      super operand
    
  # **To-do** Implement the Bool class
  __contains__: (operand)->
    new Bool operand.value in @value
    
  __len__: ->
    new Int @value.length
    
  __min__: ->
    @value.reduce (a, b) ->
      a if a <= b else b
      
  __max__: ->
    @value.reduce (a, b) ->
      a if a >= b else b
  
  __mul__: (operand) ->
    if Int in operand.__class__().__bases__()
      newValue = new (type(@))()
      for i in [0...operand.value]
        newValue.__iadd__ @value
      newValue
    else
      super operand

  __slice__: (start, end, step)->
    if not step?
      new (type(@)) @value.slice start, end
    else
      # **To-do**: implementation for `step > 1`
      # Push this up to named argument step=1
  
  count: (operand) ->
    total = 0
    for element in @value
      if element.__eq__(operand).value is true
        total += 1
        
    new Int total
  
  # **To-do**: The above `__contains__` uses a fallback definition of 
  # `Array.prototype.indexOf`.  Any way to trigger this?  
  index: (operand) ->
    new Int Array.prototype.indexOf @value, operand.value
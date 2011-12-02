# **To-do** Implement tuple support for classinfo.
issubclass = (classArg, classinfo) ->
  return classinfo in classArg.__bases__()

cmp = (operand1, operand2) ->
  return operand1.__cmp__(operand2)
  
pow = (operand1, operand2) ->
  return operand1.__pow__(operand2)

abs = (operand) ->
  return operand.__abs__()

float = (operand) ->
  return new Num(window.Number(operand))

str = (operand) ->
  if operand?
    return operand.__str__()
  else
    # [Relevant](http://docs.python.org/library/functions.html#str)
    return ''
    
repr = (operand) ->
  return operand.__repr__()

type = (object) ->
  return object.constructor
  
print = (object) ->
  console.log(object)

# **To-do** Implement tuple support for classinfo.
abs = (operand) ->
  operand.__abs__()

cmp = (operand1, operand2) ->
  operand1.__cmp__(operand2)
  
float = (operand) ->
  new Num(window.Number(operand.value))
  
issubclass = (classArg, classinfo) ->
  # [Relevant](http://docs.python.org/library/functions.html#issubclass)
  classArg is classinfo or classinfo in classArg.__bases__()

len = (operand) ->
  operand.__len__()

pow = (operand1, operand2) ->
  operand1.__pow__(operand2)

print = (object) ->
  console.log(object)

repr = (operand) ->
  operand.__repr__()
  
str = (operand) ->
  if operand?
    operand.__str__()
  else
    # [Relevant](http://docs.python.org/library/functions.html#str)
    ''

type = (object) ->
  object.constructor
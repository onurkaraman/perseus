# **To-do** Implement tuple support for classinfo.
abs = (operand) ->
  operand.__abs__()

cmp = (operand1, operand2) ->
  operand1.__cmp__(operand2)
  
float = (operand) ->
  new Num(window.Number(operand.value))
  
issubclass = (classArg, classinfo) ->
  # [Relevant](http://docs.python.org/library/functions.html#issubclass)
  # The classes are equal.
  if classArg is classinfo
    true
  # The call to bases will fail if we go any higher than `Obj`.
  else if classArg is Obj
    false
  else
  # Collect the results of each recursively calling `issubclass` on each parent
  # class.
    classArg
      .__bases__()
      .map (parentClass) ->
        issubclass(parentClass, classinfo)
      .reduce (a, b) ->
        a or b

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
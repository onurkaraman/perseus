# TODO: implement tuple support for classinfo
issubclass: (classArg, classinfo) ->
  currentClass = classArg
  desiredClass = classinfo
  
  # Traverse until we hit the end of the inheritance tree, i.e. the currentClass
  # is undefined.
  while currentClass?
    if currentClass is desiredClass
      return true
    currentClass = currentClass.__class__.prototype
  
  return false

cmp: (operand1, operand2) ->
  return operand1.__cmp__(operand2)

# [Python](http://docs.python.org/library/functions.html#abs)
abs = (operand) ->
  operand.__abs__()

# [Python](http://docs.python.org/library/functions.html#cmp)
cmp = (operand1, operand2) ->
  operand1.__cmp__(operand2)
  
# [Python](http://docs.python.org/library/functions.html#float)
float = (operand) ->
  new Num(window.Number(operand.value))
  
# [Python](http://docs.python.org/library/functions.html#hash)
hash = (operand) ->
  if operand.__hash__?
    operand.__hash__()
  else
    raise new TypeError("unhashable type: '#{operand.__class__().__name__()}'") #TODO: change __class__ and __name__ to be attributes, not functions
  ###
    TODO: Implement __hash__() for all hashable types
  ###

# [Python](http://docs.python.org/library/functions.html#issubclass)
#
# **To-do**
# 
# - Need to add tuple support for `classinfo`.
issubclass = (classArg, classinfo) ->
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

# [Python](http://docs.python.org/library/functions.html#len)
len = (operand) ->
  operand.__len__()

# [Python](http://docs.python.org/library/functions.html#ord)
# TODO: Handle unicode
ord = (operand) ->
  # if issubclass(operand, String)
  if type(operand) == type(new Str())
    if len(operand).value is 1
      new Int(operand.value.charCodeAt(0))
    else
      raise TypeError("ord() expected a character, but string of length #{len(operand).value} found")
  else
    raise TypeError("ord() expected string of length 1, but #{operand.__class__().__name__()} found")

# [Python](http://docs.python.org/library/functions.html#pow)
pow = (operand1, operand2) ->
  operand1.__pow__(operand2)

# [Python](http://docs.python.org/library/functions.html#print)
print = (object) ->
  console.log(object)

# [Python](http://docs.python.org/library/functions.html#repr)
repr = (operand) ->
  operand.__repr__()
  
# [Python](http://docs.python.org/library/functions.html#str)
str = (operand) ->
  if operand?
    operand.__str__()
  else
    ''
    
# [Python](http://docs.python.org/library/functions.html#type)
type = (object) ->
  object.constructor

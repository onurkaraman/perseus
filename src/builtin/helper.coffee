__isSubInstance__ = (obj1, obj2) ->
  obj2.__class__() in obj1.__class__().__bases__()

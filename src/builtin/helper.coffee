issubinstance = (obj1, obj2) ->
  issubclass(type(obj1), type(obj2))
    
raise = (exception) ->
  if issubclass(type(exception), BaseException)
    throw new Error("#{type(exception).__name__()}: #{exception.message}")
  else
    throw new Error("TypeError: exceptions must be old-style classes or derived from BaseException, not #{type(exception).__name__()}")
# Returns a string representation of the 'class' of an object.
# [Relevant](http://bonsaiden.github.com/JavaScript-Garden/#types.typeof)
getType: (object) ->
  return Object.prototype.toString.call(object).slice(8, -1)
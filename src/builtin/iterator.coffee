# http://docs.python.org/library/stdtypes.html#iterator-types
#
# Iterator class is base iterator class containing methods for Python's built-in iterator types
class Iterator extends Primitive
  
  # http://docs.python.org/library/stdtypes.html#iterator.__iter__
  __iter__: ->
    return @
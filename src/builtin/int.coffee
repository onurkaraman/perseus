class Int
  constructor: (@value) ->
    
  # http://bonsaiden.github.com/JavaScript-Garden/#types.typeof
  __checktype__: (other, operand) ->
    ownType = Object.prototype.toString.call(this).slice(8, -1)
    otherType = typeof other
    
    if otherType isnt ownType
      throw new TypeError "unsupported operand type(s) for #{operand}: '#{ownType}' and '#{otherType}'"
    
  __abs__: ->
    if (@value < 0)
      return -@value
    else
      return @value
  
  __add__: (other) ->
    @__checkType__(other, '+')
    return @value + other.value
  
  __and__: (other) ->
    return @value && other.value
  
  # TODO: python returns a 'classobj', e.g. <class __main__.Int at 0xdeadbeef>
  __class__: this
  
  __cmp__: (other) ->
    if self.value < other.value
      return -1
    if self.value is other.value
      return 0
    if self.value > other.value
      return 1
      
  # TODO: difference between __repr__ and __str__?
  # Need to consider how this will affect console.log / print / concatenation
  __str__: ->
    return @value

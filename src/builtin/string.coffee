# http://docs.python.org/library/stdtypes.html#string-methods
class String extends Sequence
  __contains__: (operand) ->
    if isSubInstance(operand, @)
      return @value.indexOf(operand) > -1
    else
      super operand

  __add__: (operand) ->
    if isSubInstance(operand, @)
      return @value + operand
    else
      super operand
  
  capitalize: ->
    if @__len__ is 0
      return @value
    else
      return @value[0].toUpperCase() + @.lower().slice(1)

  center: (width, fillchar = " ") ->
    if width <= @__len__()
      return @value
    delta = width - @__len__()
    pad = ''
    pad = for i in Math.floor(delta, 2)
            pad += fillchar
    if delta % 2 == 0
      return pad + @value + pad
    else
      return pad + @value + pad + fillchar

  count: (sub, start = 0, end = @__len__()) ->
    count = 0
    curIndex = start
    while curIndex < end
      substringIndex = @value.indexOf(sub, curIndex)
      if substringIndex < 0
        break
      else
        curIndex = substringIndex + sub.__len__()
        count++
    return count
  
  decode: -> return
  encode: -> return
  endswith: -> return
  expandtabs: -> return
  
  find: (sub, start = 0, end = @__len__()) ->
    substr = @value.slice(start, end)
    return substr.indexOf(sub)

  format: -> return
  
  index: (sub, start = 0, end = @__len__()) ->
    substr = @value.slice(start, end)
    index = substr.indexOf(sub)
    if index == -1
      (new ValueError "substring not found").raise()
    else
      return index

  isalnum: ->
    alnums = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in alnums
          return false
      return true

  isalpha: ->
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in alphas
          return false
      return true
  
  isdigit: ->
    digits = '0123456789'
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in digits
          return false
      return true

  islower: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in lowers
          return false
      return true
  
  isspace: ->
    spaces = '\t\n\x0b\x0c\r '
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in spaces
          return false
      return true

  istitle: ->
    words = @value.split ' '
    for word in words
      if not String(word[0]).isupper()
        return false
      if word.length == 1
        continue
      if not String(word[0]).islower()
        return false
    return true
  
  isupper: ->
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__() == 0
      return false
    else
      for char in @value
        if not char in uppers
          return false
      return true

  join: (iterable) -> return
  ljust: (width, fillchar = ' ') -> return
  
  lower: ->
    return @value.toLowerCase()

  lstrip: (chars) -> return

  partition: (sep) -> return #if using regex in split, need to be careful to escape chars

  upper: ->
    return @value.toUpperCase()
  
  zfill: (width) ->
    if width <= @__len__()
      return @value
    if @value.__len__() == 0
      return String('0').__mul__(width)
    zeroCount = width - @__len__()
    if @value[0] == '-'
      remaining = @value.slice(1)
      return '-' + String('0').__mul__(zeroCount) + remaining
    else
      return String('0').__mul__(zeroCount) + remaining

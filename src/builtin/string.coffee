# http://docs.python.org/library/stdtypes.html#string-methods
class Str extends Sequence
  constructor: (@value = '') ->
  
  # **Consideration** Overriding Sequence's inherited __add__ smells of bad
  # design.
  __add__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value + operand.value
    else
      super operand
  
  __contains__: (operand) ->
    if issubinstance operand, @
      new Bool @value.indexOf(operand) > -1
    else
      super operand
  
  capitalize: ->
    if @__len__().value is 0
      @
    else
      new (type(@)) @value[0].toUpperCase() + @value.slice(1)

  center: (width, fillchar = new Str ' ') ->
    if (type width) isnt Int
      raise new TypeError 'an integer is required'
    if (type fillchar) isnt Str
      raise new TypeError 'must be char, not #{type(fillchar).__name__()}'
    if width.value <= @__len__().value
      @
    delta = width.value - @__len__().value
    pad = 
      fillchar
      .__mul__(
        new Int Math.floor(delta, 2))
      .value
    if delta % 2 is 0
      new (type(@)) pad + @value + pad
    else
      new (type(@)) pad + @value + pad + fillchar.value

  count: (sub, start = 0, end = @__len__().value) ->
    count = 0
    curIndex = 0
    slicedStr = @value.slice(start, end)
    substringLen = (new Str sub).__len__().value
    while curIndex < slicedStr.length
      substringIndex = slicedStr.indexOf(sub, curIndex)
      if substringIndex < 0
        break
      else
        curIndex = substringIndex + substringLen
        count++
    new Int count
  
  decode: ->
    
  encode: ->
    
  endswith: (suffix, start = 0, end = @__len__().value) ->
    slicedStr = @value.slice(start, end)
    index = slicedStr.lastIndexOf(suffix)
    if index < 0
      return false 
    return new Bool (index + suffix.length) is end

  expandtabs: -> return
  
  find: (sub, start = 0, end = @__len__().value) ->
    index = @value.indexOf(sub)
    withinBounds = start <= index < end
    if withinBounds
      return new Int index
    else
      return new Int -1

  format: -> return
  
  index: (sub, start = 0, end = @__len__().value) ->
    substr = @value.slice(start, end)
    index = substr.indexOf(sub)
    if index is -1
      raise new ValueError "substring not found"
    else
      return new Int index

  isalnum: ->
    alnums = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    if @__len__().value is 0
      return new Bool false
    else
      for c in @value
        if not (c in alnums)
          return new Bool false
      return new Bool true

  isalpha: ->
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__().value is 0
      return new Bool false
    else
      for c in @value
        if not (c in alphas)
          return new Bool false
      return new Bool true
  
  isdigit: ->
    digits = '0123456789'
    if @__len__().value is 0
      return false
    else
      for c in @value
        if not (c in digits)
          return new Bool false
      return new Bool true

  # Returns true if all cased characters are lowercase and there exists a cased character.
  # Otherwise return false
  islower: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__().value is 0
      return new Bool false
    else
      containsLower = false
      for c in @value
        if c in lowers
          containsLower = true
        if c in uppers
          return new Bool false
      return new Bool containsLower
  
  isspace: ->
    spaces = '\t\n\x0b\x0c\r '
    if @__len__().value is 0
      return false
    else
      for c in @value
        if not (c in spaces)
          return new Bool false
      return new Bool true

  ###
  **Fix-me**: Account for punctuation as described in:
  http://docs.python.org/library/stdtypes.html#str.title
  ###
  istitle: ->
    words = @value.split ' '
    for word in words
      firstChar = new Str word[0]
      if not firstChar.isupper().value
        return new Bool false
      if word.length is 1
        continue
      remaining = new Str word.slice(1)
      if not remaining.islower().value
        return new Bool false
    return new Bool true
  
  # Returns true if all cased characters are lowercase and there exists a cased character.
  # Otherwise return false
  isupper: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__().value == 0
      return false
    else
      containsUpper = false
      for c in @value
        if c in uppers
          containsUpper = true
        if c in lowers
          return new Bool false
      return new Bool containsUpper

  join: (iterable) -> return

  ljust: (width, fillchar = ' ') ->
    if width <= @__len__().value
      return @
    delta = width - @__len__().value
    pad = (new Str('')).__mul__(delta).value
    return new Str(@value + pad)
  
  lower: ->
    return new Str(@value.toLowerCase())

  lstrip: (chars) -> return

  partition: (sep) ->
    splitValues = @split(sep, 1)
    containsSeparator = @__contains__(sep)
    if containsSeparator
      partitions = [splitValues[0], sep, splitValues[1]]
    else
      partitions = [splitValues[0], "", ""]
    return new Tuple(partitions)

  replace: (old, replacement, count) ->
    if count?
      return @split(old, count).join(replacement)
    else
      return @split(old).join(replacement)

  rfind: (sub, start = 0, end = @__len__().value) ->
    lastIndex = @__slice__(start, end).lastIndexOf(sub)
    return new Int lastIndex

  rindex: (sub, start = 0, end = @__len__().value) ->
    lastIndex = substr.lastIndexOf(sub)
    if lastIndex is -1
      raise new ValueError "substring not found"
    else
      return new Int lastIndex
      
  rjust: (width, fillchar = ' ') ->
    if width <= @__len__().value
      return @value
    delta = width - @__len__().value
    pad = (new Str('')).__mul__(delta).value
    return new Str(pad + @value)

  rpartition: (sep) ->
    splitValues = @rsplit(sep, 1)
    containsSeparator = @__contains__(sep)
    if containsSeparator
      partitions = [splitValues[0], sep, splitValues[1]]
    else
      partitions = ["", "", splitValues[0]]
    return new Tuple(partitions)

  rsplit: -> return
  rstrip: -> return
  split: -> return
  splitlines: -> return
  startswith: (prefix, start = 0, end = @__len__().value) ->
    return new Bool @value.slice(start, end).indexOf(prefix) == 0

  strip: -> return

  swapcase: ->
    result = ''
    for c in @value
      cStr = new Str(c)
      if cStr.islower()
        ascii = c.charCodeAt(0)
        upperCaseAscii = ascii - 32
        upperCaseChar = String.fromCharCode(upperCaseAscii)
        result += upperCaseChar
      else if cStr.isupper()
        ascii = c.charCodeAt(0)
        lowerCaseAscii = ascii + 32
        lowerCaseChar = String.fromCharCode(lowerCaseAscii)
        result += lowerCaseChar
      else
        result += c
    return new Str result

  title: -> return
  translate: -> return

  upper: ->
    return new Str @value.toUpperCase()
  
  zfill: (width) ->
    if width.value <= @__len__().value
      return @
    zeroStr = new Str('0')
    if @__len__().value is 0
      return zeroStr.__mul__(width)
    zeroCount = width.value - @__len__().value
    if @value[0] is '-'
      remaining = @value.slice(1)
      return new Str '-' + zeroStr.__mul__(zeroCount).value + remaining
    else
      return new Str zeroStr.__mul__(zeroCount).value + remaining

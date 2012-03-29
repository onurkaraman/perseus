# http://docs.python.org/library/stdtypes.html#string-methods
#
# Str class contains methods for Python's built-in str type
class Str extends Sequence
  constructor: (@value = '') ->
  
  # Returns the concatenation of `this` and `operand`
  # **Consideration** Overriding Sequence's inherited __add__ smells of bad design.
  __add__: (operand) ->
    if issubinstance operand, @
      new (type(@)) @value + operand.value
    else
      super operand
  
  # States whether `this` contains `operand` 
  __contains__: (operand) ->
    if issubinstance operand, @
      new Bool @value.indexOf(operand) > -1
    else
      super operand

  # Implementation found at http://effbot.org/zone/python-hash.htm
  # TODO: Hash value returned still differs from Python string's hash.
  __hash__: ->
    if len(@).value is 0
      return new Int(0)
    firstChar = new Str(@value[0])
    val = ord(firstChar).value << 7
    for char in @value
      val = ((1000003 * val) & 0xFFFFFFFF) ^ ord(new Str(char)).value
    val = val ^ len(@).value
    if val is -1
      return new Int(-2)
    return new Int(val)

  # http://docs.python.org/library/stdtypes.html#str.capitalize  
  capitalize: ->
    if @__len__().value is 0
      @
    else
      new (type(@)) @value[0].toUpperCase() + @value.slice(1)

  # http://docs.python.org/library/stdtypes.html#str.center
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

  # http://docs.python.org/library/stdtypes.html#str.count
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
  
  # http://docs.python.org/library/stdtypes.html#str.decode
  #
  # **Unimplemented**
  decode: ->
  
  # http://docs.python.org/library/stdtypes.html#str.encode
  #
  # **Unimplemented**
  encode: ->
  
  # http://docs.python.org/library/stdtypes.html#str.endswith
  endswith: (suffix, start = 0, end = @__len__().value) ->
    slicedStr = @value.slice(start, end)
    index = slicedStr.lastIndexOf(suffix)
    if index < 0
      return false 
    return new Bool (index + suffix.length) is end

  # http://docs.python.org/library/stdtypes.html#str.expandtabs
  expandtabs: -> return
  
  # http://docs.python.org/library/stdtypes.html#str.find
  find: (sub, start = 0, end = @__len__().value) ->
    index = @value.indexOf(sub)
    withinBounds = start <= index < end
    if withinBounds
      return new Int index
    else
      return new Int -1

  # http://docs.python.org/library/stdtypes.html#str.format
  #
  # **Unimplemented**
  format: ->
  
  # http://docs.python.org/library/stdtypes.html#str.index
  index: (sub, start = 0, end = @__len__().value) ->
    substr = @value.slice(start, end)
    index = substr.indexOf(sub)
    if index is -1
      raise new ValueError "substring not found"
    else
      return new Int index

  # http://docs.python.org/library/stdtypes.html#str.isalnum
  isalnum: ->
    alnums = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    if @__len__().value is 0
      return new Bool false
    else
      for c in @value
        if not (c in alnums)
          return new Bool false
      return new Bool true

  # http://docs.python.org/library/stdtypes.html#str.isalpha
  isalpha: ->
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__().value is 0
      return new Bool false
    else
      for c in @value
        if not (c in alphas)
          return new Bool false
      return new Bool true
  
  # http://docs.python.org/library/stdtypes.html#str.isdigit
  isdigit: ->
    digits = '0123456789'
    if @__len__().value is 0
      return false
    else
      for c in @value
        if not (c in digits)
          return new Bool false
      return new Bool true

  # http://docs.python.org/library/stdtypes.html#str.islower
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
  
  # http://docs.python.org/library/stdtypes.html#str.isspace
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
  
  # http://docs.python.org/library/stdtypes.html#str.isupper
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

  # http://docs.python.org/library/stdtypes.html#str.join
  #
  # **Unimplemented**
  join: (iterable) ->

  # http://docs.python.org/library/stdtypes.html#str.ljust
  ljust: (width, fillchar = ' ') ->
    if width <= @__len__().value
      return @
    delta = width - @__len__().value
    pad = (new Str('')).__mul__(delta).value
    return new Str(@value + pad)
  
  # http://docs.python.org/library/stdtypes.html#str.lower
  lower: ->
    return new Str(@value.toLowerCase())

  # http://docs.python.org/library/stdtypes.html#str.lstrip
  #
  # **Unimplemented**
  lstrip: (chars) ->

  # http://docs.python.org/library/stdtypes.html#str.partition
  partition: (sep) ->
    splitValues = @split(sep, 1)
    containsSeparator = @__contains__(sep)
    if containsSeparator
      partitions = [splitValues[0], sep, splitValues[1]]
    else
      partitions = [splitValues[0], "", ""]
    return new Tuple(partitions)

  # http://docs.python.org/library/stdtypes.html#str.replace
  replace: (old, replacement, count) ->
    if count?
      return @split(old, count).join(replacement)
    else
      return @split(old).join(replacement)

  # http://docs.python.org/library/stdtypes.html#str.rfind
  rfind: (sub, start = 0, end = @__len__().value) ->
    lastIndex = @__slice__(start, end).lastIndexOf(sub)
    return new Int lastIndex

  # http://docs.python.org/library/stdtypes.html#str.rindex
  rindex: (sub, start = 0, end = @__len__().value) ->
    lastIndex = substr.lastIndexOf(sub)
    if lastIndex is -1
      raise new ValueError "substring not found"
    else
      return new Int lastIndex
      
  # http://docs.python.org/library/stdtypes.html#str.rjust
  rjust: (width, fillchar = ' ') ->
    if width <= @__len__().value
      return @value
    delta = width - @__len__().value
    pad = (new Str('')).__mul__(delta).value
    return new Str(pad + @value)

  # http://docs.python.org/library/stdtypes.html#str.rpartition
  rpartition: (sep) ->
    splitValues = @rsplit(sep, 1)
    containsSeparator = @__contains__(sep)
    if containsSeparator
      partitions = [splitValues[0], sep, splitValues[1]]
    else
      partitions = ["", "", splitValues[0]]
    return new Tuple(partitions)

  # http://docs.python.org/library/stdtypes.html#str.rsplit
  #
  # **Unimplemented**
  rsplit: ->

  # http://docs.python.org/library/stdtypes.html#str.rstrip
  #
  # **Unimplemented**
  rstrip: ->

  # http://docs.python.org/library/stdtypes.html#str.split
  #
  # **Unimplemented**
  split: ->

  # http://docs.python.org/library/stdtypes.html#str.splitlines
  #
  # **Unimplemented**
  splitlines: ->

  # http://docs.python.org/library/stdtypes.html#str.startswith
  startswith: (prefix, start = 0, end = @__len__().value) ->
    return new Bool @value.slice(start, end).indexOf(prefix) == 0

  # http://docs.python.org/library/stdtypes.html#str.strip
  #
  # **Unimplemented**
  strip: ->

  # http://docs.python.org/library/stdtypes.html#str.swapcase
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

  ###
  **Fix-me**: Account for punctuation as described in:
  http://docs.python.org/library/stdtypes.html#str.title
  **Unimplemented**
  ###
  title: ->

  # http://docs.python.org/library/stdtypes.html#str.translate
  #
  # **Unimplemented**
  translate: ->

  # http://docs.python.org/library/stdtypes.html#str.upper
  upper: ->
    return new Str @value.toUpperCase()
  
  # http://docs.python.org/library/stdtypes.html#str.zfill
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

# http://docs.python.org/library/stdtypes.html#string-methods
class Str extends Sequence
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
    if delta % 2 == 0
      new (type(@)) pad + @value + pad
    else
      new (type(@)) pad + @value + pad + fillchar

  count: (sub, start = 0, end = @__len__()) ->
    count = 0
    curIndex = 0
    slicedStr = @value.slice(start, end)
    substringLen = (new Str(sub)).__len__()
    while curIndex < slicedStr.length
      substringIndex = slicedStr.indexOf(sub, curIndex)
      if substringIndex < 0
        break
      else
        curIndex = substringIndex + substringLen
        count++
    return count
  
  decode: -> return
  encode: -> return
  endswith: (suffix, start, end) ->
    slicedStr = @value.slice(start, end)
    index = slicedStr.lastIndexOf(suffix)
    if index < 0
      return false 
    return index + suffix.length == @value.length

  expandtabs: -> return
  
  find: (sub, start = 0, end = @__len__()) ->
    index = @value.indexOf(sub)
    withinBounds = start <= index < end
    if withinBounds
      return index
    else
      return -1

  format: -> return
  
  index: (sub, start = 0, end = @__len__()) ->
    substr = @value.slice(start, end)
    index = substr.indexOf(sub)
    if index == -1
      raise new ValueError "substring not found"
    else
      return index

  isalnum: ->
    alnums = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    if @__len__() == 0
      return false
    else
      for c in @value
        if not (c in alnums)
          return false
      return true

  isalpha: ->
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__() == 0
      return false
    else
      for c in @value
        if not (c in alphas)
          return false
      return true
  
  isdigit: ->
    digits = '0123456789'
    if @__len__() == 0
      return false
    else
      for c in @value
        if not (c in digits)
          return false
      return true

  # Returns true if all cased characters are lowercase and there exists a cased character.
  # Otherwise return false
  islower: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__() == 0
      return false
    else
      containsLower = false
      for c in @value
        if c in lowers
          containsLower = true
        if c in uppers
          return false
      return containsLower
  
  isspace: ->
    spaces = '\t\n\x0b\x0c\r '
    if @__len__() == 0
      return false
    else
      for c in @value
        if not (c in spaces)
          return false
      return true

  ###
  **Fix-me**: Account for punctuation as described in:
  http://docs.python.org/library/stdtypes.html#str.title
  ###
  istitle: ->
    words = @value.split ' '
    for word in words
      firstChar = new String(word[0])
      if not firstChar.isupper()
        return false
      if word.length == 1
        continue
      if not firstChar.islower()
        return false
    return true
  
  # Returns true if all cased characters are lowercase and there exists a cased character.
  # Otherwise return false
  isupper: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @__len__() == 0
      return false
    else
      containsUpper = false
      for c in @value
        if c in uppers
          containsUpper = true
        if c in lowers
          return false
      return containsUpper

  join: (iterable) -> return

  ljust: (width, fillchar = ' ') ->
    if width <= @__len__()
      return @value
    delta = width - @__len__()
    pad = (new Str('')).__mul__(delta)
    return @value + pad
  
  lower: ->
    return @value.toLowerCase()

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

  rfind: (sub, start = 0, end = @__len__()) ->
    lastIndex = @__slice__(start, end).lastIndexOf(sub)
    return lastIndex

  rindex: (sub, start = 0, end = @__len__()) ->
    lastIndex = substr.lastIndexOf(sub)
    if lastIndex == -1
      raise new ValueError "substring not found"
    else
      return lastIndex
      
  rjust: (width, fillchar = ' ') ->
    if width <= @__len__()
      return @value
    delta = width - @__len__()
    pad = (new Str('')).__mul__(delta)
    return pad + @value

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
  startswith: (prefix, start = 0, end = @__len__()) ->
    return @value.slice(start, end).indexOf(prefix) == 0

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
    return result

  title: -> return
  translate: -> return

  upper: ->
    return @value.toUpperCase()
  
  zfill: (width) ->
    if width <= @__len__()
      return @value
    zeroStr = new Str('0')
    if @value.length == 0
      return zeroStr.__mul__(width)
    zeroCount = width - @__len__()
    if @value[0] == '-'
      remaining = @value.slice(1)
      return '-' + zeroStr.__mul__(zeroCount) + remaining
    else
      return zeroStr.__mul__(zeroCount) + remaining

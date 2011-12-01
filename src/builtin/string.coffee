# http://docs.python.org/library/stdtypes.html#string-methods
class Str extends Sequence
  __contains__: (operand) ->
    if isSubInstance(operand, @)
      return @value.indexOf(operand) > -1
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
    pad = Str('').__mul__(Math.floor(delta, 2))
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
        curIndex = substringIndex + Str(sub).__len__()
        count++
    return count
  
  decode: -> return
  encode: -> return
  endswith: (suffix, start, end) ->
    return @value.slice(start, end).lastIndexOf(suffix) > -1

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

  ###
  **Fix-me**: Account for punctuation as described in:
  http://docs.python.org/library/stdtypes.html#str.title
  ###
  istitle: ->
    words = @value.split ' '
    for word in words
      if not Str(word[0]).isupper()
        return false
      if word.length == 1
        continue
      if not Str(word[0]).islower()
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

  ljust: (width, fillchar = ' ') ->
    if width <= @__len__()
      return @value
    delta = width - @__len__()
    pad = Str('').__mul__(delta)
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
      (new ValueError "substring not found").raise()
    else
      return lastIndex
      
  rjust: (width, fillchar = ' ') ->
    if width <= @__len__()
      return @value
    delta = width - @__len__()
    pad = Str('').__mul__(delta)
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
    return @value.slice(start, end).indexOf(suffix) == 0

  strip: -> return

  swapcase: ->
    result = ''
    for char in @value
      if Str(char).islower()
        ascii = char.charCodeAt(0)
        upperCaseAscii = ascii - 32
        upperCaseChar = String.fromCharCode(upperCaseAscii)
        result += upperCaseChar
      else if Str(char).isupper()
        ascii = char.charCodeAt(0)
        lowerCaseAscii = ascii + 32
        lowerCaseChar = String.fromCharCode(lowerCaseAscii)
        result += lowerCaseChar
      else
        result += char
    return result

  title: -> return
  translate: -> return

  upper: ->
    return @value.toUpperCase()
  
  zfill: (width) ->
    if width <= @__len__()
      return @value
    if @value.__len__() == 0
      return Str('0').__mul__(width)
    zeroCount = width - @__len__()
    if @value[0] == '-'
      remaining = @value.slice(1)
      return '-' + Str('0').__mul__(zeroCount) + remaining
    else
      return Str('0').__mul__(zeroCount) + remaining

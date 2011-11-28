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
    if @value.__len__ is 0
      return @value
    else
      return @value[0].toUpperCase() + @value.slice(1).toLowerCase()

  center: (width, fillchar = " ") ->
    if width <= @value.__len__
      return @value
    delta = width - @value.__len__
    pad = ''
    pad = for i in Math.floor(delta, 2)
            pad += fillchar
    if delta % 2 == 0
      return pad + @value + pad
    else
      return pad + @value + pad + fillchar

  isalpha: ->
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    if @value.__len__ == 0
      return false
    else
      for char in @value
        if not char in alphas
          return false
      return true
  
  isdigit: ->
    digits = '0123456789'
    if @value.__len__ == 0
      return false
    else
      for char in @value
        if not char in digits
          return false
      return true

  islower: ->
    lowers = 'abcdefghijklmnopqrstuvwxyz'
    if @value.__len__ == 0
      return false
    else
      for char in @value
        if not char in lowers
          return false
      return true
  
  isspace: ->
    spaces = '\t\n\x0b\x0c\r '
    if @value.__len__ == 0
      return false
    else
      for char in @value
        if not char in spaces
          return false
      return true
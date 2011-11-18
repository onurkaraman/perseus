INDENTWIDTH = 2

def closure(code):
    return '(function(){\r\n%s\r\n})();' % code

def indent(code, level):
    return ' ' * INDENTWIDTH * level + code

# Flattens an array of statements which may be multi-line into an array of
# single lines
def flattenLines(array):
    return flatten(map(lambda(element): element.split('\r\n'), array))

# Flattens an array of array into a single uniform array containing all elements
def flatten(array):
    return [list for sublist in array for list in sublist]
    
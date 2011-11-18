INDENTWIDTH = 2
NEWLINE = '\r\n'

def closure(code):
    return (
             '(function(){' +
             NEWLINE +
             '%s' +
             NEWLINE +
             '})();'
           ) % code

def indent(code, level):
    return NEWLINE.join(map(lambda(line): ' ' * INDENTWIDTH * level + line, code.split(NEWLINE)))

# Flattens an array of array into a single uniform array containing all elements
def flatten(array):
    return [list for sublist in array for list in sublist]
    
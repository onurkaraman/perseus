import typing

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

# Recursively expands lists within a list, e.g.
# [1, [2, 3], 4] => [1, 2, 3, 4]
def expand(array):
    expanded = []
    for element in array:
        if typing.isList(element):
            recursiveExpand = expand(element)
            for element in array:
                expanded.append(element)
        else:
            expanded.append(element)
    return expanded
            
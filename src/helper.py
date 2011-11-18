import typing

INDENTWIDTH = 2
NEWLINE = '\r\n'

# Wraps a chunk of code in a closure.
def closure(code):
    return (
             '(function(){' + NEWLINE +
             '%s' + NEWLINE +
             '})();'
           ) % indent(code, 1)

# Indents a string.  If it is multi-line, each line will be indented.
def indent(code, level):
    return NEWLINE.join(map(lambda(line): ' ' * INDENTWIDTH * level + line, code.split(NEWLINE)))

# Recursively expands lists within a list, e.g.
# [1, [2, 3], 4] => [1, 2, 3, 4]
def expand(array):
    expanded = []
    for element in array:
        if typing.isList(element):
            recursiveExpand = expand(element)
            for subelement in recursiveExpand:
                expanded.append(subelement)
        else:
            expanded.append(element)
    return expanded

# Turns a list of statements into a *block* in the traditional sense, i.e.
# appends a semicolon to the end of each statement, and concatenates the
# statements with newlines
def formatGroup(statementList):
    return NEWLINE.join(map(lambda(line): line + ';', statementList))
            
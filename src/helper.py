import typing

INDENT = ' '
INDENTWIDTH = 2

# Wraps a chunk of code in a closure.
def closure(code):
    return multiline([
             '(function(){',
             '  %s',
             '})();'
           ]) % code

# Indents a string.  If it is multi-line, each line will be indented.
def indent(code, level):
    return os.linesep.join(map(lambda(line): INDENT * INDENTWIDTH * level + line, code.split(os.linesep)))

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
    return os.linesep.join(map(lambda(line): line + ';', statementList))

# Removing prefixed newlines, trailing whitespace
def multiline(multiLineString):
    newLineChars = '\r\n\f\t'
    strippedLeadingEnding = multiLineString.lstrip(newLineChars).rstrip(string.whitespace)
    
    lines = strippedLeadingEnding.split(os.linesep)
    
    leadingIndent = len(lines[0]) - len(lines[0].lstrip(string.whitespace))
    
    return [line.rstrip(string.whitespace)[leadingIndent:] for line in lines].join(os.linesep)

# Indents a method using INDENTWIDTH per every 2 spaces in a string.
def reindent(statement):
    originalLength = len(statement)
    statement.lstrip()
    
    # should be an even number!    
    assert (len(statement) - originalLength) % 2 == 0
    
    numIndents = (len(statement) - originalLength)/2
    return indent(statement, numIndents)
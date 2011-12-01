import string
import typing

INDENT = ' '
INDENTWIDTH = 4
NEWLINE = '\n'

# Wraps a chunk of code in a closure.
def closure(code):
    return multiline(
        '''
        (function(){
        %s
        }).call(this);
        '''
    ) % code

# Indents a string.  If it is multi-line, each line will be indented.
def indent(code, level):
    return NEWLINE.join(map(lambda(line): INDENT * INDENTWIDTH * level + line, code.split(NEWLINE)))

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
# appends a semicolon to the end of each statement, concatenates the
# statements with newlines, indents everything by one.
def formatGroup(statementList):
    return indent(NEWLINE.join(map(lambda(line): line + ';', statementList)), 1)

# Removing prefixed newlines, trailing whitespace
def multiline(multiLineString):
    newLineChars = '\r\n\f\t'
    strippedLeadingEnding = multiLineString.lstrip(newLineChars).rstrip(string.whitespace)
    
    lines = strippedLeadingEnding.split(NEWLINE)
    
    leadingIndent = len(lines[0]) - len(lines[0].lstrip(string.whitespace))
    
    return NEWLINE.join([line.rstrip(string.whitespace)[leadingIndent:] for line in lines])

# Indents a method using INDENTWIDTH per every 2 spaces in a string.
def reindent(statement):
    originalLength = len(statement)
    statement.lstrip()
    
    # should be an even number!    
    assert (len(statement) - originalLength) % INDENTWIDTH == 0
    
    numIndents = (len(statement) - originalLength)/INDENTWIDTH
    return indent(statement, numIndents)
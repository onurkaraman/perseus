import re
import string
import typing

INDENT = ' '
INDENTWIDTH = 4
NEWLINE = '\n'

# Wraps a chunk of code in a closure.
def closure(code):
    return cleanBlockString(
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

def format(string, obj):
    codeMap = {}
    
    string = cleanBlockString(string)
    re_replacement = re.compile(r'%\(([a-zA-Z_0-9]+)\)s')
    lines = string.split(NEWLINE)
    mappedLines = []
    
    for attr in re_replacement.findall(string):
        code = getattr(obj, attr)
        
        # Automatically create block strings out of lists of statements
        if typing.isList(code):
            code = block(code)
            
        codeMap[attr] = code
    
    for line in lines:
        newLine = line
        if (line.lstrip().startswith('%')):
            indents = (len(line) - len(line.lstrip()))/INDENTWIDTH
            
            if (re_replacement.search(line) != None):
                match = re_replacement.search(line).group(1)
                newLine = re.sub(match, match + str(indents), line)
                codeMap[match + str(indents)] = indent_alt(codeMap[match], indents)
                
        mappedLines.append(newLine)
        
    string = NEWLINE.join(mappedLines)
    return string % codeMap

def indent_alt(code, level):
    return code.replace(NEWLINE, (NEWLINE + '%s') % (INDENT * INDENTWIDTH * level))

def block(statementList):
    return NEWLINE.join(map(lambda(line): line + ';', expand(statementList)))

# Turns a list of statements into a *block* in the traditional sense, i.e.
# appends a semicolon to the end of each statement, concatenates the
# statements with newlines, indents everything by one.
def formatGroup(statementList):
    return indent(NEWLINE.join(map(lambda(line): line + ';', statementList)), 1)

# Removing prefixed newlines, trailing whitespace
def cleanBlockString(block):
    newLineChars = '\r\n\f\t'
    strippedLeadingEnding = block.lstrip(newLineChars).rstrip(string.whitespace)
    
    lines = strippedLeadingEnding.split(NEWLINE)
    
    leadingIndent = len(lines[0]) - len(lines[0].lstrip(string.whitespace))
    
    return NEWLINE.join([line.rstrip(string.whitespace)[leadingIndent:] for line in lines])
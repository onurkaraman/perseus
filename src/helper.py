INDENTWIDTH = 2

def closure(code):
    return '(function(){\r\n%s\r\n})();' % code

def indent(code, level):
    return ' ' * INDENTWIDTH * level + code
    
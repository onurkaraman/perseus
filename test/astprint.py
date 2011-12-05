# -*- coding: utf-8 -*-
import ast

print(ast.dump(ast.parse(open('input.py').read())))

#import re
#
#OPENING_DELIMITERS = list('([')
#CLOSING_DELIMITERS = list(')]')
#DELIMITERS = [',']
#DELIMITERS.extend(OPENING_DELIMITERS)
#DELIMITERS.extend(CLOSING_DELIMITERS)
#
## Prints indented form of ast dump. Still not correct.
#def indentPrint(dump):
#    level = 0
#    for delimiter in DELIMITERS:
#        dump = dump.replace(delimiter, delimiter + '\r\n')
#    dump = re.sub(r"\(\s+\)", "()", dump)
#    dump = re.sub(r"\[\s+\]", "[]", dump)
#    lines = dump.split('\r\n')
#    i = 0
#    for line in lines:
#        if len(line) is 0:
#            continue
#        if '()' not in line and '[]' not in line:
#            if line[-1] in OPENING_DELIMITERS:
#                level += 1
#            elif line[-1] in CLOSING_DELIMITERS:
#                level -= 1
#        lines[i] = "\t" * level + line
#        i += 1
#    print '\r\n'.join(lines)
#
#dump = ast.dump(ast.parse(open('test.py').read()))
#indentPrint(dump)

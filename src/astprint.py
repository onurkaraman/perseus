# -*- coding: utf-8 -*-
import ast 

print(ast.dump(ast.parse(open('test.py').read())))

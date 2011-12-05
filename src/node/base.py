# http://docs.python.org/library/ast.html#abstract-grammar

import typing


# rootNode = ModuleNode(ast.parse(...), None)
class Base:
    def __init__(self, astNode, parent):
        self.ast = astNode
        self.parent = parent

        # Auto-build nodes out of children fields.
        for fieldName in self.ast._fields:
            child = getattr(self.ast, fieldName)
            setattr(self, fieldName, self.resolve(child))
    def resolve(self, element):
        '''
        Returns an string representation of an element if it is primitive, 
        or casts an ast.AST object into its abstraction.  Resolves recursively
        for lists.
        '''
        # Handling primitive children
        if typing.isNone(element):
            return 'null'
        elif typing.isBoolean(element):
            return str(element).lower()
        elif typing.isPrimitive(element):
            return str(element)
        # Expression contexts appear to be an argument-less instance of a class
        # e.g. Load(), Store()
        elif typing.isExpressionContext(element):
            return typing.getClassName(element)
        elif typing.isList(element):
            return [self.resolve(member).compile() for member in element]
        else:
            from alias import *
            from arguments import *
            from boolop import *
            from cmpop import *
            from comprehension import *
            from excepthandler import *
            from expr_context import *
            from expr import *
            from keyword import *
            from mod import *
            from operator import *
            from slice import *
            from stmt import *
            className = typing.getClassName(element)
            return locals()[className](element, self)
        
    def getChildren(self):
        [getattr(self, fieldName) for fieldName in self.ast._fields]
    def compile(self):
        pass
    def __str__(self):
        return self.compile()
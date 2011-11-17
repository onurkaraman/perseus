import ast

globals = {}

def getClassName(object):
    return type(object).__name__

# rootNode = ModuleNode(ast.parse(...), None)
class Base:
    def __init__(self, astNode, parent):
        self = astNode
        self.parent = parent
        
        # Auto-build nodes out of children fields.
        for fieldName in self._fields:
            child = self.getattr(field)
            child = self.resolve(child)
    
    def resolve(element):
        '''
        Returns an element if it is primitive or casts an ast.AST object into
        its abstraction.
        '''
        # Handling primitive children
        if type(element) in __builtins__:
            return element 
        else:
            className = getClassName(element)
            nodeClass = globals()[className]
            return nodeClass(element, self)    
    def compile(self):
        pass
    def __str__(self):
        return self.compile()

class FloorDiv(Base):
    def compile(self):
        return 'Math.floor(%s, %s)' % (self.parent.left, self.parent.right)

class BinOp(Base):
    def compile(self):
        return self.op.compile()

class Num(Base):
    def compile(self):
        return '%s' % self.n

class Block:
    def __init__(self, astNodeList, parent):
        self.children = astNodeList
        self.parent = parent
        self.indent = self.calcIndent()
        self.locals = {}
        # To keep track of global declarations in python.  This causes different
        # assignement statements in JS.
        self.globalRefs = set()
    
    # Traverse up parents until the nearest Block node, return that indent value
    # plus 1
    def calcIndent(self):
        pass
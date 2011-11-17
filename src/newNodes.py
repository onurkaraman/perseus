import ast

globals = {}

def getClassName(object):
    return type(object).__name__

# rootNode = ModuleNode(ast.parse(...), None)
class Node:
    def __init__(self, astNode, parent):
        self = astNode
        self.parent = parent
        
        # Auto-build nodes out of children fields.
        for child in self._fields:
            self.setattr(child, self.buildChildNode(child))
            
    def buildChildNode(astNode):
        nodeType = getClassName(astNode)
        nodeClass = globals()[nodeType]
        return nodeClass(astNode, self)    
    def compile(self):
        pass
    def __str__(self):
        return self.compile()

class FloorDivNode(Node):
    def compile(self):
        return 'Math.floor(%s, %s)' % (self.parent.left, self.parent.right)

class BinOpNode(Node):
    def compile(self):
#        leftOperand = self.left
#        operator = self.op
#        rightOperand = self.right
#        if(getClassName(operator) in ['Pow', 'FloorDiv']):
#            return '%s(%s, %s)' % (operator, leftOperand, rightOperand)
#        else:
#            return '%s %s %s' % (leftOperand, operator, rightOperand)
        return self.op.compile()

class Num(Node):
    def compile(self):
        return '%s' % self.node.n

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
    
    
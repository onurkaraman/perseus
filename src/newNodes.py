import ast

INDENTWIDTH = 2

globalVars = {}

IGNORE_FIELDS = {'ctx'}

def getClassName(object):
    return type(object).__name__

# rootNode = ModuleNode(ast.parse(...), None)
class Base:
    def __init__(self, astNode, parent):
        self.ast = astNode
        self.parent = parent

        # Auto-build nodes out of children fields.
        for fieldName in self.ast._fields:
            if fieldName in IGNORE_FIELDS:
                continue
            child = getattr(self.ast, fieldName)
            setattr(self, fieldName, self.resolve(child))
    def resolve(self, element):
        '''
        Returns an element if it is primitive, a new Block object for closures,
        or casts an ast.AST object into its abstraction.
        '''
        # Handling closures
        if getClassName(element) == 'list':
            return Block(element, self)
        # Handling primitive children
        elif getClassName(element) in ['int', 'float', 'str']:
            return str(element)
        else:
            className = getClassName(element)
            nodeClass = globals()[className]
            return nodeClass(element, self)
    def compile(self):
        pass
    def __str__(self):
        return self.compile()
    def getChildren(self):
        [getattr(self, fieldName) for fieldName in self.ast._fields]

class Module(Base):
    def compile(self):
        return '%s' % self.body
#        return  '(function(){\r\n%s\r\n})();' % helper.indentCode(ChunkNode(self.node.body).compile())

class Name(Base):
    def compile(self):
        return '%s' % self.id
    
class Expr(Base):
    def compile(self):
        return '%s' % self.value

class Num(Base):
    def compile(self):
        return '%s' % self.n

class Break(Base):
    def compile(self):
        return 'break;'

class Continue(Base):
    def compile(self):
        return 'continue;'

class Pass(Base):
    def compile(self):
        return 'return void(0);'

class Add(Base):
    def compile(self):
        return '%s + %s' % (self.parent.left, self.parent.right)

class Sub(Base):
    def compile(self):
        return '%s - %s' % (self.parent.left, self.parent.right)

class Mult(Base):
    def compile(self):
        return '%s * %s' % (self.parent.left, self.parent.right)

class Div(Base):
    def compile(self):
        return '%s / %s' % (self.parent.left, self.parent.right)

class Mod(Base):
    def compile(self):
        return "%s %s %s" % (self.parent.left, '%', self.parent.right)

class LShift(Base):
    def compile(self):
        return '%s << %s' % (self.parent.left, self.parent.right)

class RShift(Base):
    def compile(self):
        return '%s >> %s' % (self.parent.left, self.parent.right)

class BitOr(Base):
    def compile(self):
        return '%s | %s' % (self.parent.left, self.parent.right)

class BitXor(Base):
    def compile(self):
        return '%s ^ %s' % (self.parent.left, self.parent.right)

class BitAnd(Base):
    def compile(self):
        return '%s & %s' % (self.parent.left, self.parent.right)

class Pow(Base):
    def compile(self):
        return 'Math.pow(%s, %s)' % (self.parent.left, self.parent.right)

class FloorDiv(Base):
    def compile(self):
        return 'Math.floor(%s, %s)' % (self.parent.left, self.parent.right)

class Invert(Base):
    def compile(self):
        return '~%s' % self.parent.operand

class Not(Base):
    def compile(self):
        return '!%s' % self.parent.operand

class UAdd(Base):
    def compile(self):
        return '+%s' % self.parent.operand

class USub(Base):
    def compile(self):
        return '-%s' % self.parent.operand

class BinOp(Base):
    def compile(self):
        return self.op.compile()

class UnaryOp(Base):
    def compile(self):
        return self.op.compile()

class Block(Base):
    '''
    An abstraction of a closure.  This occurs in Python whenever we have:
    * module
    * class definition
    * function body
    '''
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
        def finishedTraversal(pointer):
            return pointer != None
        indent = 1
        pointer = self.parent
        while(not finishedTraversal(pointer)):
            if getClassName(pointer) == 'Block':
                indent = pointer.indent + 1
                break
        return indent
    def compile(self):
        compiledChildren = [self.resolve(child).compile() + ';' for child in self.children]
        indentString = self.indent * INDENTWIDTH * ' '
        statementDelimiter = '\r\n' + indentString
        return '(function(){%s\r\n})();' % (statementDelimiter + statementDelimiter.join(compiledChildren))

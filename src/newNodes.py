import ast
import helper
import typing

globalVars = {}

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
        if typing.isPrimitive(element) or typing.isExpressionContext(element):
			return str(element)
        elif typing.isList(element):
            return [self.resolve(member).compile() for member in element]
        else:
            className = typing.getClassName(element)
            nodeClass = globals()[className]
            return nodeClass(element, self)
    def getChildren(self):
        [getattr(self, fieldName) for fieldName in self.ast._fields]
    def compile(self):
        pass
    def __str__(self):
        return self.compile()

class Module(Base):
    def compile(self):
        return '%s' % Block(self.body, self)

class FunctionDef(Base):
    def compile(self):
        compiledArgs = self.args.compile()
        return 'this.%s = function(%s){%s%s}' % (self.name, compiledArgs[0], compiledArgs[1], self.body)

class Name(Base):
    def compile(self):
        if self.ctx == 'Store':
            return 'var %s' % self.id
        else:
            return '%s' % self.id

class Expr(Base):
    def compile(self):
        return '%s' % self.value

class Compare(Base):
	def compile(self):
		print self.left, self.ops, self.comparators
		trailingComparison = ' '.join('%s %s' % (op, comparator) for (op, comparator) in zip(self.ops, self.comparators))
		return ("%s " + trailingComparison) % self.left

class Num(Base):
    def compile(self):
        return '%s' % self.n

class Str(Base):
    def compile(self):
        stringValue = self.s
        if (stringValue.startswith('"')):
            stringValue = "'%s'" % stringValue
        else:
            stringValue = '"%s"' % stringValue
        return '%s' % stringValue

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

class IfExp(Base):
    def compile(self):
        condition = self.test.compile()
        ifBody = self.body.compile()
        elseBody = self.orelse.compile()
        return '%s ? %s : %s' % (condition, ifBody, elseBody)

class Return(Base):
    def compile(self):
        return 'return %s' % self.value

class BoolOp(Base):
    def compile(self):
        return  (' %s ' % self.op).join(self.values)

class And(Base):
    def compile(self):
        return '&&'

class Or(Base):
    def compile(self):
        return '||'

class Eq(Base):
	def compile(self):
		return '=='

class NotEq(Base):
	def compile(self):
		return '!='

class Lt(Base):
	def compile(self):
		return '<'

class LtE(Base):
	def compile(self):
		return '<='

class Gt(Base):
	def compile(self):
		return '>'

class GtE(Base):
	def compile(self):
		return '>='

class Is(Base):
	def compile(self):
		return '==='

class IsNot(Base):
	def compile(self):
		return '!=='

class Dict(Base):
	def compile(self):
	        return '{%s}' % (', '.join('%s: %s' % (key, value) for (key, value) in zip(self.keys, self.values)))

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
            if typing.getClassName(pointer) == 'Block':
                indent = pointer.indent + 1
                break
        return indent

    def compile(self):
        # Append `;` to statements in the body
        compiledChildren = [ child + ';' for child in self.children]
        indentedCode = '\r\n'.join([helper.indent(compiledChild, 1) for compiledChild in compiledChildren])
        return helper.closure(indentedCode)

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
        if typing.isNone(element) or typing.isBoolean(element):
            return element
        elif typing.isPrimitive(element):
            return str(element)
        elif typing.isExpressionContext(element):
            return typing.getClassName(element)
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
        try:
            conversion = {
                'None': 'null',
                'True': 'true',
                'False': 'false'
            }
            self.id = conversion[self.id]
        except KeyError:
            pass

        return '%s' % self.id

class Expr(Base):
    def compile(self):
        return '%s' % self.value

class Compare(Base):
    def compile(self):
        allComparators = [self.left.compile()]
        allComparators.extend(self.comparators[:])
        leftComparators = allComparators[:-1]
        rightComparators = allComparators[1:]
        return ' && '.join('(%s %s %s)' % (left, op, right) for (left, op, right) in zip(leftComparators, self.ops, rightComparators))

class Num(Base):
    def compile(self):
        return self.n

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
        return 'break'

class Continue(Base):
    def compile(self):
        return 'continue'

class Pass(Base):
    def compile(self):
        return 'return void(0)'

class Add(Base):
    def compile(self):
        return '+'

class Sub(Base):
    def compile(self):
        return '-'

class Mult(Base):
    def compile(self):
        return '*'

class Div(Base):
    def compile(self):
        return '/'

class Mod(Base):
    def compile(self):
        return '%'

class LShift(Base):
    def compile(self):
        return '<<'

class RShift(Base):
    def compile(self):
        return '>>'

class BitOr(Base):
    def compile(self):
        return '|'

class BitXor(Base):
    def compile(self):
        return '^'

class BitAnd(Base):
    def compile(self):
        return '&'

class Pow(Base):
    def compile(self):
        return 'Math.pow(%s, %s)' % (self.parent.left, self.parent.right)

class FloorDiv(Base):
    def compile(self):
        return 'Math.floor(%s, %s)' % (self.parent.left, self.parent.right)

class Invert(Base):
    def compile(self):
        return '~'

class Not(Base):
    def compile(self):
        return '!'

class UAdd(Base):
    def compile(self):
        return '+'

class USub(Base):
    def compile(self):
        return '-'

class BinOp(Base):
    def compile(self):
        if typing.getClassName(self.op) in ['Pow', 'FloorDiv']:
            return MathOp(self.ast, self.parent).compile()
        else:
            return '%s %s %s' % (self.left, self.op, self.right)

class MathOp(Base):
    def compile(self):
        return '%s' % self.op

class UnaryOp(Base):
    def compile(self):
        return '%s%s' % (self.op, self.operand)

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

# **Consider:** need to handle global var assignments eventually.
class Assign(Base):
    def compile(self):
        return ['var %s = %s' % (target, self.value) for target in self.targets]

class Delete(Base):
    def compile(self):
        return 'delete ' + ', '.join(target for target in self.targets)

class AugAssign(Base):
    def compile(self):
        return '%s %s= %s' % (self.target, self.op, self.value)

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

# **Consider:** ctx, Ellipsis, ExtSlice form of slice
class Subscript(Base):
    def compile(self):
        return '%s' % self.slice

class Slice(Base):
    def compile(self):
        hasLower = self.lower is not None
        hasUpper = self.upper is not None
        hasStep = self.step is not None and self.step.compile() != 'null'
        slicedArray = None

        if hasLower and hasUpper:
            slicedArray = "%s.slice(%s, %s)" % (self.parent.value, self.lower, self.upper)
        elif hasLower:
            slicedArray = "%s.slice(%s)" % (self.parent.value, self.lower)
        elif hasUpper:
            slicedArray = "%s.slice(0, %s)" % (self.parent.value, self.upper)
        else: #has neither
            slicedArray = "%s.slice(0, %s)" % (self.parent.value, "%s.length" % self.parent.value)
        if hasStep:
            step = int(self.step.compile())
            if step > 0:
                slicedArray += (".filter(" +
                                    "function(element, index, array){" +
                                        "return index %s %s == 0;" +
                                    "}" +
                                ")") % ('%', self.step)
            elif step < 0:
                slicedArray += (".filter(" +
                                    "function(element, index, array){" +
                                        "return (array.length - index - 1) %s %s == 0;" +
                                    "}" +
                                ").reverse()") % ('%', self.step)
            elif step == 0:
                return "ValueError: slice step cannot be zero"
        return slicedArray

class Index(Base):
    def compile(self):
        return '%s[%s]' % (self.parent.value, self.value)

class Dict(Base):
    def compile(self):
            return '{%s}' % (', '.join('%s: %s' % (key, value) for (key, value) in zip(self.keys, self.values)))

# **Consider:** What is nl - newline?
class Print(Base):
    def compile(self):
        return 'console.log(%s)' % ', '.join(value for value in self.values)

class List(Base):
    def compile(self):
        return '[%s]' % ', '.join(value for value in self.elts)

class If(Base):
    def compile(self):
        compiled = helper.multiline([
                     'if(%s){',
                     '  %s',
                     '}'
                   ]) % (self.test, helper.formatGroup(self.body))
        # **Consider:** abstract list.isEmpty() ?
        if len(self.orelse) != 0:
            compiled = helper.multiline([
                         compiled,
                         'else{',
                         '  %s',
                         '}'
                       ]) % (helper.formatGroup(self.orelse))
        return compiled

class While(Base):
    def compile(self):
        return helper.multiline([
                   'if(%s){',
                   '  while(true){',
                   '    %s',
                   '    if(!%s){',
                   '      %s',
                   '      break;',
                   '    }',
                   '  }'
                   '}',
                   'else{',
                   '  %s',
                   '}'
                ]) % (self.test, helper.formatGroup(self.body), self.test, helper.formatGroup(self.orelse), helper.formatGroup(self.orelse))

#### Functions

# Currently cannot handle variable or keyword arguments.

class arguments(Base):
    def compile(self):
        return ', '.join(self.args)

class Lambda(Base):
    def compile(self):
        return helper.multiline([
            'function(%s){',
            '  return %s;',
            '}'
        ]) % (self.args, self.body)

class FunctionDef(Base):
    def compile(self):
        return helper.multiline([
            'this.%s = function(%s){',
            '  %s',
            '}'
        ]) % (self.name, self.args, helper.formatGroup(self.body))

class Call(Base):
    def compile(self):
        argument = ', '.join(arg for arg in self.args)
        return 'this.%s(%s)' % (self.func, argument)

##################################

#### Error Handling

class ExceptHandler(Base):
    def compile(self):
        return self

# TODO: Incorporate self.inst, trace
class Raise(Base):
    def compile(self):
        exceptionType = self.type
        return 'throw Error("%s")' % exceptionType

class TryExcept(Base):
    def compileCatchStatements(self):
        catchStatements = []
        for handler in self.handlers:
            body = Block(handler.body, self.parent)
            exceptionType = handler.type
            if exceptionType is not None:
                catch = helper.multiline([
                    "if(e.message === '%s'){",
                    "    %s",
                    "}"
                ]) % (exceptionType, body)
            else:
                catch = '%s' % body
            catchStatements.append(catch)
        return '\r\n'.join(catchStatements)

    def compile(self):
        tryBody = Block(self.body, self.parent)
        catchBody = self.compileCatchStatements()
        elseBody = Block(self.orelse, self.parent)
        return helper.multiline([
            'try{',
            '  %s',
            '}',
            'catch(e){',
            '  var caughtException = true;',
            '  %s',
            '}',
            'if(!caughtException){',
            '  %s',
            '}'
        ]) % (tryBody, catchBody, elseBody)

class TryFinally(Base):
    def compile(self):
        tryBody = Block(self.body, self.parent)
        finallyBody = Block(self.finalbody, self.parent)
        return helper.multiline([
            'try{',
            '  %s',
            '}',
            'finally{',
            '  %s',
            '}',
        ]) % (tryBody, finallyBody)
##################################

class Block(Base):
    '''
    An abstraction of a closure.  This occurs in Python whenever we have:
    * module
    * class definition
    * function body
    '''
    def __init__(self, children, parent):
        self.children = children
        self.parent = parent
        self.indent = self.calcIndent()
        self.locals = {}
        # To keep track of global declarations in python.  This causes different
        # assignment statements in JS.
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
        # Appends `;` to statements in the body - those passed back in an array
        # each have a `;` attached to their ends.  To avoid this (e.g. in if/
        # else blocks), simply concatenate the code before passing it back
        group = helper.formatGroup(helper.expand(self.children))
        enclosed = helper.closure(group)

        # need to indent the entire block now
        return helper.indent(enclosed, self.indent)

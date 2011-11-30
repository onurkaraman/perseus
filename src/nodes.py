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
        # Expression contexts appear to be an argument-less instance of a class
        # e.g. Load(), Store()
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
        return '__add__'

class Sub(Base):
    def compile(self):
        return '__sub__'

class Mult(Base):
    def compile(self):
        return '__mul__'

class Div(Base):
    def compile(self):
        return '__div__'

class Mod(Base):
    def compile(self):
        return '__mod__'

class LShift(Base):
    def compile(self):
        return '__lshift__'

class RShift(Base):
    def compile(self):
        return '__rshift__'

class BitOr(Base):
    def compile(self):
        return '__or__'

class BitXor(Base):
    def compile(self):
        return '__xor__'

class BitAnd(Base):
    def compile(self):
        return '__and__'

class Pow(Base):
    def compile(self):
        return '__pow__'

class FloorDiv(Base):
    def compile(self):
        return '__floordiv__'

class Invert(Base):
    def compile(self):
        return '__invert__'

class Not(Base):
    def compile(self):
        return '__not__'

class UAdd(Base):
    def compile(self):
        return '__pos__'

class USub(Base):
    def compile(self):
        return '__neg__'

class BinOp(Base):
    def compile(self):
        return '%s.%s(%s)' % (self.left, self.op, self.right)

class UnaryOp(Base):
    def compile(self):
        return '%s.%s()' % (self.operand, self.op)

class IfExp(Base):
    def compile(self):
        condition = self.test.compile()
        ifBody = self.body.compile()
        elseBody = self.orelse.compile()
        return '%s ? %s : %s' % (condition, ifBody, elseBody)

class ListComp(Base):
    def compile(self):
        '''
        TODO: Handle multi-comprehensions:
            seq1 = ['a', 'b', 'c']
            seq2 = [1, 2, 3]
            [(x, y) for x in seq1 for y in seq2]
        '''
        element = str(self.elt)
        iter = self.generators[0].iter
        isMultiTargeted = hasattr(self.generators[0].target, 'elts') is True
        if isMultiTargeted:
            targets = self.generators[0].target.elts
            numTargets = len(targets)
            for i in range(numTargets):
                mappedTarget = "x[%d]" % i
                element = element.replace(targets[i], mappedTarget)
            return "%s.map(function(x){return %s;})" % (iter, element)
        else:
            target = self.generators[0].target
            return "%s.map(function(%s){return %s;})" % (iter, target, element)

class DictComp(Base):
    def compile(self):
        keyElement = str(self.key)
        valueElement = str(self.value.compile())
        iter = self.generators[0].iter
        isMultiTargeted = hasattr(self.generators[0].target, 'elts') is True
        if isMultiTargeted:
            '''
            Multi-target for cases such as:
                print {x: y + x for x, y in [('hello', 5), ('world', 2)]}
                    x, y are the targets
                print {x: y + z for x, y, z in [(5, 2, 7), (8, 9, 4)]}
                    x, y, z are targets
            '''
            targets = self.generators[0].target.elts
            numTargets = len(targets)
            for i in range(numTargets):
                mappedTarget = "x[%d]" % i
                keyElement = keyElement.replace(targets[i], mappedTarget)
                valueElement = valueElement.replace(targets[i], mappedTarget)
            return helper.multiline([
                "(function(){",
                "  var obj = {};",
                "  var translated = %s.map(function(x){",
                "    return [%s,%s];",
                "  });",
                "  for(var i = 0; i < translated.length; i++){",
                "    var key = translated[i][0];",
                "    obj[key] = translated[i][1];",
                "  }",
                "  return obj;",
                "})()"]) % (iter, keyElement, valueElement)
        else:
            '''
            Single target for cases such as:
                k = 4
                print {x: x + k for x in [5, 67, 2]}
                x is the single target
            '''
            target = self.generators[0].target
            return helper.multiline([
                "(function(){",
                "  var obj = {};",
                "  var translated = %s.map(function(%s){",
                "    return [%s,%s];",
                "  });",
                "  for(var i = 0; i < translated.length; i++){",
                "    var key = translated[i][0];",
                "    obj[key] = translated[i][1];",
                "  }",
                "  return obj;",
                "})()"]) % (iter, target, keyElement, valueElement)

# Placeholder so I can start DictComp
class Tuple(Base):
    def compile(self):
        return List(self.ast, self.parent).compile()

class comprehension(Base):
    def compile(self):
        return self

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

# TODO: Append 'i' to ops, e.g. __add__ => __iadd__
class AugAssign(Base):
    def compile(self):
        return '%s %s= %s' % (self.target, self.op, self.value)

class Eq(Base):
    def compile(self):
        return '__eq__'

class NotEq(Base):
    def compile(self):
        return '__nq__'

class Lt(Base):
    def compile(self):
        return '__lt__'

class LtE(Base):
    def compile(self):
        return '__lte__'

class Gt(Base):
    def compile(self):
        return '__gt__'

class GtE(Base):
    def compile(self):
        return '__gte__'

class Is(Base):
    def compile(self):
        return '__is__'

class IsNot(Base):
    def compile(self):
        return '__is_not__'

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
                                        "return index %% %s == 0;" + 
                                    "}" + 
                                ")") % (self.step)
            elif step < 0:
                slicedArray += (".filter(" + 
                                    "function(element, index, array){" + 
                                        "return (array.length - index - 1) %% %s == 0;" + 
                                    "}" + 
                                ").reverse()") % (self.step)
            elif step == 0:
                return "ValueError: slice step cannot be zero"
        return slicedArray

class Attribute(Base):
    def compile(self):
        return "%s.%s" % (self.value, self.attr)

class Index(Base):
    def compile(self):
        sequence = self.parent.value
        index = int(self.value.compile())
        if index < 0:
            negativeIndex = "%s.length + %s" % (sequence, index)
            return '%s[%s]' % (sequence, negativeIndex)
        else:
            return '%s[%s]' % (sequence, index)

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

#### Control Flow

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

#TODO: Stabilize. Obviously having inlined variable names could result in variable name conflicts
class For(Base):
    def compile(self):
        target = self.target.compile()
        iterable = self.iter.compile()
        return helper.multiline([
                   'var uniqueObj = Object(%s);', # Doing this because strings in python are iterable, but not in javascript
                   'if(Object.keys(uniqueObj).length > 0){',
                   '  var %s;',
                   '  var uniqueCounter = 0;',
                   '  for(uniqueVar in uniqueObj){',
                   '    uniqueCounter++;',
                   '    %s = uniqueObj[uniqueVar];',
                   '    %s',
                   '    if(uniqueCounter >= Object.keys(uniqueObj).length){',
                   '      %s',
                   '      break;',
                   '    }',
                   '  }',
                   '}',
                   'else{',
                   '  %s',
                   '}'
                ]) % (iterable, target, target, helper.formatGroup(self.body), helper.formatGroup(self.orelse), helper.formatGroup(self.orelse))

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
##################################

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
            #'this.%s = function(%s){',
            'var %s = function(%s){',
            '  %s',
            '}'
        ]) % (self.name, self.args, helper.formatGroup(self.body))

class Call(Base):
    def compile(self):
        argument = ', '.join(arg for arg in self.args)
        return '%s(%s)' % (self.func, argument)

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

class Node:
    def __init__(self, node):
        self.node = node
    
    def compile(self):
        return globals()[self.getType() + 'Node'](self.node).compile()
    
    def getType(self):
        return type(self.node).__name__

class NumNode(Node):
    def compile(self):
        return '%s' % self.node.n

class StrNode(Node):
    def compile(self):
        stringValue = self.node.s
        if (stringValue.startswith('"')):
            stringValue = "'%s'" % stringValue
        else:
            stringValue = '"%s"' % stringValue
        return '%s' % stringValue
    
class ExprNode(Node):
    def compile(self):
        return Node(self.node.value).compile()
    
class ModuleNode(Node):
    def compile(self):
        return '(function(){%s})();' % '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)

class BreakNode(Node):
    def compile(self):
        return 'break;'

class ContinueNode(Node):
    def compile(self):
        return 'continue;'

class PassNode(Node):
    def compile(self):
        return 'return void(0);'
    
class AddNode(Node):
    def compile(self):
        return '+'

class SubNode(Node):
    def compile(self):
        return '-'

class MultNode(Node):
    def compile(self):
        return '*'

class DivNode(Node):
    def compile(self):
        return '/'

class ModNode(Node):
    def compile(self):
        return '%'

class LShiftNode(Node):
    def compile(self):
        return '<<'

class RShiftNode(Node):
    def compile(self):
        return '>>'
    
class BitOrNode(Node):
    def compile(self):
        return '|'

class BitXorNode(Node):
    def compile(self):
        return '^'

class BitAndNode(Node):
    def compile(self):
        return '&'
    
class PowNode(Node):
    def compile(self):
        return 'Math.pow'
    
class FloorDivNode(Node):
    def compile(self):
        return 'Math.floor'

class BinOpNode(Node):
    def compile(self):
        leftOperand = Node(self.node.left).compile()
        operator = Node(self.node.op).compile()
        rightOperand = Node(self.node.right).compile()
        if(Node(self.node.op).getType() == ('Pow' or 'FloorDiv')):
            return '%s(%s, %s)' % (operator, leftOperand, rightOperand)
        else:
            return '%s %s %s' % (leftOperand, operator, rightOperand)

class WhileNode(Node):
    def compile(self):
        condition = Node(self.node.test).compile()
        whileBlock = '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)
        elseBlock = '\r\n'.join(Node(stmt).compile() for stmt in self.node.orelse)
        return 'while(%s){%s}%s' % (condition, whileBlock, elseBlock)

class IfNode(Node):
    def compile(self):
        hasElse = bool(self.node.orelse)
        condition = Node(self.node.test).compile()
        ifBlock = '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)
        if hasElse:
            elseBlock = '\r\n'.join(Node(stmt).compile() for stmt in self.node.orelse)
            return 'if(%s){%s}else{%s}' % (condition, ifBlock, elseBlock)
        else:
            return 'if(%s){%s}' % (condition, ifBlock)

#untested
class RaiseNode(Node):
    def compile(self):
        exceptionType = Node(self.node.type).compile()
        return 'throw %s + ":" + %s;' % ( exceptionType, Node(self.node.inst).compile() )

#untested
class TryExceptNode(Node):
    def compile(self):
        tryBody = '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)
        handlers = Node(self.node.handlers.body).compile()
        catchBody = '\r\n'.join(Node(stmt).compile() for stmt in self.node.orelse)
        return 'try{%s}catch(e){var caughtException = true;%s}if(!caughtException){%s}' % (tryBody, handlers, catchBody)

#untested
class TryFinallyNode(Node):
    def compile(self):
        tryBody = '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)
        finallyBody = '\r\n'.join(Node(stmt).compile() for stmt in self.node.finalbody)
        return 'try{%s}finally{%s}' % (tryBody, finallyBody)

#untested
class FunctionDefNode(Node):
    def compile(self):
        functionName = self.node.name
        body = '\r\n'.join(Node(stmt).compile() for stmt in self.node.body)
        return 'this.%s = function(args){%s}' % (functionName, body)

class ReturnNode(Node):
    def compile(self):
        return 'return %s;' % ('' if self.node.value is None else Node(self.node.value).compile())

import helper

class Node:
    def __init__(self, node):
        self.node = node
    
    def compile(self):
        return globals()[self.getType() + 'Node'](self.node).compile()
    
    def getType(self):
        return type(self.node).__name__
    
class ChunkNode(Node):
    def __init__(self, nodeList):
        self.nodeList = nodeList
    
    def compile(self):
        return '\r\n'.join(Node(node).compile() for node in self.nodeList)

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
        return  '''(function(){\r\n%s\r\n})();
                ''' % helper.indentCode(ChunkNode(self.node.body).compile())

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
    
class InvertNode(Node):
    def compile(self):
        return '~'

class NotNode(Node):
    def compile(self):
        return '!'

class UAddNode(Node):
    def compile(self):
        return '+'

class USubNode(Node):
    def compile(self):
        return '-'

class BinOpNode(Node):
    def compile(self):
        leftOperand = Node(self.node.left).compile()
        operator = Node(self.node.op).compile()
        rightOperand = Node(self.node.right).compile()
        if(Node(self.node.op).getType() == ('Pow' or 'FloorDiv')):
            return '%s(%s, %s)' % (operator, leftOperand, rightOperand)
        else:
            return '%s %s %s' % (leftOperand, operator, rightOperand)

class UnaryOpNode(Node):
    def compile(self):
        operand = Node(self.node.operand).compile()
        operator = Node(self.node.op).compile()
        return '%s%s' % (operator, operand)

class IfExpNode(Node):
    def compile(self):
        condition = Node(self.node.test).compile()
        ifBody = ChunkNode(self.node.body).compile()
        elseBody = ChunkNode(self.node.body).compile() # unsure if this should be ChunkNode or Node
        return '%s ? %s : %s' % (condition, ifBody, elseBody)

class WhileNode(Node):
    def compile(self):
        condition = Node(self.node.test).compile()
        whileBlock = ChunkNode(self.node.body).compile()
        elseBlock = ChunkNode(self.node.orelse).compile()
        return 'while(%s){\r\n%s\r\n}\r\n%s' % (condition, helper.indentCode(whileBlock), elseBlock)

class IfNode(Node):
    def compile(self):
        hasElse = bool(self.node.orelse)
        condition = Node(self.node.test).compile()
        ifBlock = ChunkNode(self.node.body).compile()
        if hasElse:
            elseBlock = ChunkNode(self.node.orelse).compile()
            return 'if(%s){\r\n%s\r\n}\r\nelse{\r\n%s\r\n}' % (condition, helper.indentCode(ifBlock), helper.indentCode(elseBlock))
        else:
            return 'if(%s){\r\n%s\r\n}' % (condition, helper.indentCode(ifBlock))

#untested
class RaiseNode(Node):
    def compile(self):
        exceptionType = Node(self.node.type).compile()
        return 'throw %s + ":" + %s;' % ( exceptionType, Node(self.node.inst).compile() )

#untested
class TryExceptNode(Node):
    def compile(self):
        tryBody = ChunkNode(self.node.body).compile()
        handlers = Node(self.node.handlers.body).compile()
        catchBody = ChunkNode(self.node.orelse).compile()
        return 'try{%s}catch(e){var caughtException = true;%s}if(!caughtException){%s}' % (tryBody, handlers, catchBody)

#untested
class TryFinallyNode(Node):
    def compile(self):
        tryBody = ChunkNode(self.node.body).compile()
        finallyBody = ChunkNode(self.node.finalbody).compile()
        return 'try{%s}finally{%s}' % (tryBody, finallyBody)

#untested
class FunctionDefNode(Node):
    def compile(self):
        functionName = self.node.name
        body = ChunkNode(self.node.body).compile()
        return 'this.%s = function(args){%s}' % (functionName, body)

class BoolOpNode(Node):
    def compile(self):
        return  (' %s ' % 
                    Node(self.node.op).compile()
                ).join(
                    Node(value).compile() for value in self.node.values
                )

class AndNode(Node):
    def compile(self):
        return '&&'
    
class OrNode(Node):
    def compile(self):
        return '||'

class ReturnNode(Node):
    def compile(self):
        return 'return %s;' % ('' if self.node.value is None else Node(self.node.value).compile())

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
        pass

class BinOpNode(Node):
    def compile(self):
        leftOperand = Node(self.node.left)
        operator = Node(self.node.op)
        rightOperand = Node(self.node.right)
        if(Node(self.node.op).getType() == ('Pow' or 'FloorDiv')):
            return '%s(%s, %s)' % (operator.compile(), leftOperand.compile(), rightOperand.compile())
        else:
            return '%s %s %s' % (leftOperand.compile(), operator.compile(), rightOperand.compile())


class ReturnNode(Node):
    def compile(self):
        return 'return %s;' % ('' if self.node.value is None else Node(self.node.value).compile())
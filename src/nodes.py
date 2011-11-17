import helper

class Node:
    def __init__(self, node):
        self.node = node
    
    def compile(self):
        return globals()[self.getType() + 'Node'](self.node).compile()
    
    def getType(self):
        return type(self.node).__name__
    
class BodyNode(Node):
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
                ''' % helper.indentCode(BodyNode(self.node.body).compile())

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

class ReturnNode(Node):
    def compile(self):
        return 'return %s;' % ('' if self.node.value is None else Node(self.node.value).compile())
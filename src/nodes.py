class Node:
    def __init__(self, node):
        self.node = node
    
    def compile(self):
        ASTNodeType = type(self.node).__name__
        return globals()[ASTNodeType + 'Node'](self.node).compile()

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
    


class ReturnNode(Node):
    def compile(self):
        return 'return %s;' % ('' if self.node.value is None else Node(self.node.value).compile())
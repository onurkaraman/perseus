import ast

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return PythonScript.compileNode(ASTRootNode)
        
    @staticmethod
    def compileNode(node):
        ASTNodeType = type(node).__name__
        
        translation = {
            'Num': 'Number(%s)' % node.n,
            'Str': 'String(%s)' % node.s,
            'Expr': PythonScript.compileNode(node.value),
            'Module': '(function(){%s})' % '\r\n'.join(PythonScript.compileNode(stmt) for stmt in body) 
        }
        
        return translation[ASTNodeType]
        
print(PythonScript.compile(open('test.py').read()))
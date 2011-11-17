import ast
import nodes

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return nodes.Node(ASTRootNode).compile()
      
print(PythonScript.compile(open('test.py').read()))
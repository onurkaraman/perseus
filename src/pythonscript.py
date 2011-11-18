import ast
import newNodes

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return newNodes.Module(ASTRootNode, None).compile()
      
print(PythonScript.compile(open('test.py').read()))

import ast
import nodes

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return nodes.Module(ASTRootNode, None).compile()

print(PythonScript.compile(open('test.py').read()))

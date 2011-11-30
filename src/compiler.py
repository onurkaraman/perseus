import ast
import node

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return node.mod.Module(ASTRootNode, None).compile()

print(PythonScript.compile(open('test.py').read()))

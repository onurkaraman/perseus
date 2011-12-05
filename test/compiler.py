import ast
import sys

sys.path.append('../src/')
import node.mod

class PythonScript:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return node.mod.Module(ASTRootNode, None).compile()

print(PythonScript.compile(open('input.py').read()))

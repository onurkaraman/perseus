import ast
import sys

sys.path.append('../src/')
import node.mod

class Perseus:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return node.mod.Module(ASTRootNode, None).compile()

print(Perseus.compile(open('input.py').read()))

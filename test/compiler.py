import ast
import sys

sys.path.append('../src/')
import node.mod

class Perseus:
    @staticmethod
    def compile(code):
        ASTRootNode = ast.parse(code)
        return node.mod.Module(ASTRootNode, None).compile()

if len(sys.argv) < 2:
	inputFile = 'input.py'
else:
	inputFile = sys.argv[1]

print(Perseus.compile(open(inputFile).read()))

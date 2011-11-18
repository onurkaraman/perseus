class TryFinallyNode(Node):
    def compile(self):
        tryBody = ChunkNode(self.node.body).compile()
        finallyBody = ChunkNode(self.node.finalbody).compile()
        return 'try{%s}finally{%s}' % (tryBody, finallyBody)

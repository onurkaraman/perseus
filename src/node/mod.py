from base import Base
from block import Block

class Module(Base):
    def compile(self):
        return '%s' % Block(self.body, self)
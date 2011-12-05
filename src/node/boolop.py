from base import Base

class And(Base):
    def compile(self):
        return '&&'

class Or(Base):
    def compile(self):
        return '||'
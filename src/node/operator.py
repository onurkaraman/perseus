from base import Base

class Add(Base):
    def compile(self):
        return '__add__'

class Sub(Base):
    def compile(self):
        return '__sub__'

class Mult(Base):
    def compile(self):
        return '__mul__'

class Div(Base):
    def compile(self):
        return '__div__'

class Mod(Base):
    def compile(self):
        return '__mod__'
    
class Pow(Base):
    def compile(self):
        return '__pow__'

class LShift(Base):
    def compile(self):
        return '__lshift__'

class RShift(Base):
    def compile(self):
        return '__rshift__'

class BitOr(Base):
    def compile(self):
        return '__or__'

class BitXor(Base):
    def compile(self):
        return '__xor__'

class BitAnd(Base):
    def compile(self):
        return '__and__'

class FloorDiv(Base):
    def compile(self):
        return '__floordiv__'


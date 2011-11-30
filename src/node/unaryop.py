from base import Base

class Invert(Base):
    def compile(self):
        return '__invert__'

class Not(Base):
    def compile(self):
        return '__not__'

class UAdd(Base):
    def compile(self):
        return '__pos__'

class USub(Base):
    def compile(self):
        return '__neg__'
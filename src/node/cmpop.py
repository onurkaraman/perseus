from base import Base
    
class Eq(Base):
    def compile(self):
        return '__eq__'

class NotEq(Base):
    def compile(self):
        return '__nq__'

class Lt(Base):
    def compile(self):
        return '__lt__'

class LtE(Base):
    def compile(self):
        return '__lte__'

class Gt(Base):
    def compile(self):
        return '__gt__'

class GtE(Base):
    def compile(self):
        return '__gte__'

class Is(Base):
    def compile(self):
        return '__is__'

class IsNot(Base):
    def compile(self):
        return '__is_not__'
    
# **Unimplemented**
class In(Base):
    def compile(self):
        pass

# **Unimplemented**
class NotIn(Base):
    def compile(self):
        pass
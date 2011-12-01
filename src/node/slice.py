from base import Base

# **Unimplemented**
class Ellipsis(Base):
    def compile(self):
        pass

class Slice(Base):
    def compile(self):
        return '__slice__(%s, %s, %s)' % (self.lower, self.upper, self.step)
    
# **Unimplemented**
class ExtSlice(Base):
    def compile(self):
        pass
    
class Index(Base):
    def compile(self):
        sequence = self.parent.value
        index = int(self.value.compile())
        if index < 0:
            negativeIndex = "%s.length + %s" % (sequence, index)
            return '%s[%s]' % (sequence, negativeIndex)
        else:
            return '%s[%s]' % (sequence, index)
from base import Base

# **Unimplemented**
class Ellipsis(Base):
    def compile(self):
        pass

class Slice(Base):
    def compile(self):
        hasLower = self.lower is not None
        hasUpper = self.upper is not None
        hasStep = self.step is not None and self.step.compile() != 'null'
        slicedArray = None

        if hasLower and hasUpper:
            slicedArray = "%s.slice(%s, %s)" % (self.parent.value, self.lower, self.upper)
        elif hasLower:
            slicedArray = "%s.slice(%s)" % (self.parent.value, self.lower)
        elif hasUpper:
            slicedArray = "%s.slice(0, %s)" % (self.parent.value, self.upper)
        else: #has neither
            slicedArray = "%s.slice(0, %s)" % (self.parent.value, "%s.length" % self.parent.value)
        if hasStep:
            step = int(self.step.compile())
            if step > 0:
                slicedArray += (".filter(" + 
                                    "function(element, index, array){" + 
                                        "return index %% %s == 0;" + 
                                    "}" + 
                                ")") % (self.step)
            elif step < 0:
                slicedArray += (".filter(" + 
                                    "function(element, index, array){" + 
                                        "return (array.length - index - 1) %% %s == 0;" + 
                                    "}" + 
                                ").reverse()") % (self.step)
            elif step == 0:
                return "ValueError: slice step cannot be zero"
        return slicedArray
    
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
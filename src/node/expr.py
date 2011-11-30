from base import Base
import helper

class BoolOp(Base):
    def compile(self):
        return  (' %s ' % self.op).join(self.values)
    
class BinOp(Base):
    def compile(self):
        return '%s.%s(%s)' % (self.left, self.op, self.right)
    
class UnaryOp(Base):
    def compile(self):
        return '%s.%s()' % (self.operand, self.op)
    
class Lambda(Base):
    def compile(self):
        return helper.multiline(
            '''
            function(%s) {
                return %s;
            }
            '''                    
        ) % (self.args, self.body)
        
class IfExp(Base):
    def compile(self):
        condition = self.test.compile()
        ifBody = self.body.compile()
        elseBody = self.orelse.compile()
        return '%s ? %s : %s' % (condition, ifBody, elseBody)
    
class Dict(Base):
    def compile(self):
        return '{%s}' % (', '.join('%s: %s' % (key, value) for (key, value) in zip(self.keys, self.values)))

class Set(Base):
    def compile(self):
        return 'new Set(%s)' % self.elts

# **To-do** Handle multi-comprehensions:
# * seq1 = ['a', 'b', 'c']
# * seq2 = [1, 2, 3]
# * [(x, y) for x in seq1 for y in seq2]
class ListComp(Base):
    def compile(self):
        element = str(self.elt)
        iter = self.generators[0].iter
        isMultiTargeted = hasattr(self.generators[0].target, 'elts') is True
        if isMultiTargeted:
            targets = self.generators[0].target.elts
            numTargets = len(targets)
            for i in range(numTargets):
                mappedTarget = "x[%d]" % i
                element = element.replace(targets[i], mappedTarget)
            return "%s.map(function(x){return %s;})" % (iter, element)
        else:
            target = self.generators[0].target
            return "%s.map(function(%s){return %s;})" % (iter, target, element)

# **Unimplemented**
class SetComp(Base):
    def compile(self):
        pass
    
class DictComp(Base):
    def compile(self):
        keyElement = str(self.key)
        valueElement = str(self.value.compile())
        iter = self.generators[0].iter
        isMultiTargeted = hasattr(self.generators[0].target, 'elts') is True
        if isMultiTargeted:
            '''
            Multi-target for cases such as:
                print {x: y + x for x, y in [('hello', 5), ('world', 2)]}
                    x, y are the targets
                print {x: y + z for x, y, z in [(5, 2, 7), (8, 9, 4)]}
                    x, y, z are targets
            '''
            targets = self.generators[0].target.elts
            numTargets = len(targets)
            for i in range(numTargets):
                mappedTarget = "x[%d]" % i
                keyElement = keyElement.replace(targets[i], mappedTarget)
                valueElement = valueElement.replace(targets[i], mappedTarget)
            return helper.multiline(
                '''
                (function(){
                    var obj = {};
                    var translated = %s.map(function(x){
                        return [%s,%s];
                    });
                    for(var i = 0; i < translated.length; i++){
                        var key = translated[i][0];
                        obj[key] = translated[i][1];
                    }
                    return obj;
                })()
                '''                     
            ) % (iter, keyElement, valueElement)
        else:
            '''
            Single target for cases such as:
                k = 4
                print {x: x + k for x in [5, 67, 2]}
                x is the single target
            '''
            target = self.generators[0].target
            return helper.multiline(
                '''                    
                (function(){
                    var obj = {};
                    var translated = %s.map(function(%s){
                        return [%s,%s];
                    });
                    for(var i = 0; i < translated.length; i++){
                        var key = translated[i][0];
                        obj[key] = translated[i][1];
                    }
                    return obj;
                })()
                '''
            ) % (iter, target, keyElement, valueElement)
        
# **Unimplemented**
class GeneratorExpr(Base):
    def compile(self):
        pass

# **Unimplemented**
class Yield(Base):
    def compile(self):
        pass
    
class Compare(Base):
    def compile(self):
        allComparators = [self.left.compile()]
        allComparators.extend(self.comparators[:])
        leftComparators = allComparators[:-1]
        rightComparators = allComparators[1:]
        return ' && '.join('(%s %s %s)' % (left, op, right) for (left, op, right) in zip(leftComparators, self.ops, rightComparators))

class Call(Base):
    def compile(self):
        argument = ', '.join(arg for arg in self.args)
        return '%s(%s)' % (self.func, argument)
    
# **Unimplemented**
class Repr(Base):
    def compile(self):
        pass
    
class Num(Base):
    def compile(self):
        value = self.n
        # Floats and integers have different meanings for division!
        if ('.' in str(value)):
            return 'new Number(%s)' % value
        else:
            return 'new Integer(%s)' % value

class Str(Base):
    def compile(self):
        stringValue = self.s
        if (stringValue.startswith('"')):
            stringValue = "'%s'" % stringValue
        else:
            stringValue = '"%s"' % stringValue
        return 'new String(%s)' % stringValue
    
class Attribute(Base):
    def compile(self):
        return "%s.%s" % (self.value, self.attr)
    
# **Consideration** ctx, Ellipsis, ExtSlice form of slice
class Subscript(Base):
    def compile(self):
        return '%s' % self.slice
    
class Name(Base):
    def compile(self):
        try:
            conversion = {
                'None': 'null',
                'True': 'true',
                'False': 'false'
            }
            self.id = conversion[self.id]
        except KeyError:
            pass

        return '%s' % self.id
    
class List(Base):
    def compile(self):
        return 'new List(%s)' % self.elts

# **Fix-me** Placeholder so I can start DictComp
class Tuple(Base):
    def compile(self):
        return List(self.ast, self.parent).compile()
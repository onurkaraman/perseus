from base import Base
from block import Block
import helper

class FunctionDef(Base):
    def compile(self):
        return helper.multiline(
            '''
            var %s = function(%s) {
            %s
            }
            '''                     
        ) % (self.name, self.args, helper.formatGroup(helper.expand(self.body)))
        
# **Unimplemented**
class ClassDef(Base):
    def compile(self):
        pass

class Return(Base):
    def compile(self):
        return 'return %s' % self.value
    
class Delete(Base):
    def compile(self):
        return 'delete ' + ', '.join(target for target in self.targets)

# **To-do** need to handle global var assignments eventually.
class Assign(Base):
    def compile(self):
        return ['var %s = %s' % (target, self.value) for target in self.targets]

# **To-do** Append 'i' to ops, e.g. __add__ => __iadd__
class AugAssign(Base):
    def compile(self):
        return '%s %s= %s' % (self.target, self.op, self.value)
    
# **Consideration** What is nl - newline?
class Print(Base):
    def compile(self):
        return 'console.log(%s)' % ', '.join(value for value in self.values)

# **To-do** Stabilize. Obviously having inlined variable names could result in variable name conflicts
class For(Base):
    def compile(self):
        if (self.orelse == []):
            return helper.multiline(
                '''
                var _i, _len, _ref, %(target)s;
                _ref = %(iter)s
                
                for (_i = 0; _len = _ref.length; _i < _len; _i++) {
                    %(target)s = _ref[_i];
                    %(body)s
                }
                '''
            ) % {
                    'target': self.target, 
                    'iter': self.iter, 
                    'body': helper.formatGroup(self.body)
                }
        else:
            return helper.multiline(
             
                '''
                var _ref = %s;
                if(_ref.__len__() > 0){
                    var %s;
                    var _i = 0;
                    for(uniqueVar in _ref){
                        _i++;
                        %s = _ref[uniqueVar];
                        %s
                        if(_i >= _ref.__len__()){
                            %s
                            break;
                        }
                    }
                }
                else{
                    %s
                }
                '''
            ) % (self.iter, self.target, self.target, helper.formatGroup(self.body), helper.formatGroup(self.orelse), helper.formatGroup(self.orelse))
        
        
        
class While(Base):
    def compile(self):
        return helper.multiline(
            '''
            if(%s){',
                while(true){',
                    %s',
                    if(!%s){',
                        %s',
                        break;',
                    }',
                }'
            }',
            else{',
                %s',
            }'
            '''
        ) % (self.test, helper.formatGroup(self.body), self.test, helper.formatGroup(self.orelse), helper.formatGroup(self.orelse))

class If(Base):
    def compile(self):
        compiled = helper.multiline(
            '''
            if (%s) {
                %s
            }
            '''
        ) % (self.test, helper.formatGroup(self.body))
        # **Consideration** abstract list.isEmpty() ?
        if len(self.orelse) != 0:
            compiled = compiled + '\n' + helper.multiline(
                '''
                else {
                    %s
                }
                '''
            ) % (helper.formatGroup(self.orelse))
        return compiled

# **Unimplemented**
class With(Base):
    def compile(self):
        pass
    
# **To-do** Incorporate self.inst, trace.  Throw PS version of exceptions
class Raise(Base):
    def compile(self):
        exceptionType = self.type
        return 'throw Error("%s")' % exceptionType
    
# **To-do**: Use Block abstraction and compile recursively.  We can then
# eliminate the compileCatchStatements() inner method.
class TryExcept(Base):
    def compileCatchStatements(self):
        catchStatements = []
        for handler in self.handlers:
            body = Block(handler.body, self.parent)
            exceptionType = handler.type
            if exceptionType is not None:
                catch = helper.multiline(
                    '''
                    if (e.message === '%s') {
                        %s
                    }
                    '''                     
                ) % (exceptionType, body)
            else:
                catch = '%s' % body
            catchStatements.append(catch)
        return '\n'.join(catchStatements)

    def compile(self):
        tryBody = Block(self.body, self.parent)
        catchBody = self.compileCatchStatements()
        elseBody = Block(self.orelse, self.parent)
        return helper.multiline(
            '''
            try {
                %s
            }
            catch(e) {
                var caughtException = true;
            }
            if (!caughtException) {
                %s
            }
            '''                     
        ) % (tryBody, catchBody, elseBody)
        
class TryFinally(Base):
    def compile(self):
        tryBody = Block(self.body, self.parent)
        finallyBody = Block(self.finalbody, self.parent)
        return helper.multiline(
            '''
            try {
                %s
            }
            finally {
                %s
            }
            '''                    
        ) % (tryBody, finallyBody)
        
# **Unimplemented**
class Assert(Base):
    def compile(self):
        pass
    
# **Unimplemented**
class Import(Base):
    def compile(self):
        pass
    
# **Unimplemented**
class ImportFrom(Base):
    def compile(self):
        pass
    
# **Unimplemented**
class Exec(Base):
    def compile(self):
        pass

# **Unimplemented**
class Global(Base):
    def compile(self):
        pass
    
class Expr(Base):
    def compile(self):
        return '(%s).value' % self.value
    
class Pass(Base):
    def compile(self):
        return 'return void(0)'
    
class Break(Base):
    def compile(self):
        return 'break'

class Continue(Base):
    def compile(self):
        return 'continue'

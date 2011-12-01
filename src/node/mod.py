from base import Base
import helper

class Module(Base):
    def compile(self):
        return helper.format(
            '''
            (function(){
                %(body)s
            }).call(this)
            ''', self
        )

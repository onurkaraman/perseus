from base import Base
from block import Block
import helper

class Module(Base):
    def compile(self):
        return helper.format(
            '''
            (function(){
                %(body)s
            }).call(this)
            ''',
            {
                'body': self.body
            }
        )

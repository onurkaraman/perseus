from base import Base
import helper
import typing

class Block(Base):
    '''
    An abstraction of a closure.  This occurs in Python whenever we have:
    * module
    * class definition
    * function body
    '''
    def __init__(self, children, parent):
        self.children = children
        self.parent = parent
        self.indent = self.calcIndent()
        self.locals = {}
        # To keep track of global declarations in python.  This causes different
        # assignment statements in JS.
        self.globalRefs = set()

    # Traverse up parents until the nearest Block node, return that indent value
    # plus 1
    def calcIndent(self):
        def finishedTraversal(pointer):
            return pointer != None
        indent = 1
        pointer = self.parent
        while(not finishedTraversal(pointer)):
            if typing.getClassName(pointer) == 'Block':
                indent = pointer.indent + 1
                break
        return indent

    def compile(self):
        # Appends `;` to statements in the body - those passed back in an array
        # each have a `;` attached to their ends.  To avoid this (e.g. in if/
        # else blocks), simply concatenate the code before passing it back
        group = helper.formatGroup(helper.expand(self.children))
        enclosed = helper.closure(group)

        # need to indent the entire block now
        return helper.indent(enclosed, self.indent)
'''
The Lexer class is used to parse input Python code into Jison-format tokens.
This overrides the default lexer implementation within Jison.  Hence, this must
be called before passing it to the Parser class.
'''
import StringIO
import tokenize

class Lexer:
    def __init__(self):
        self.tokens = []
    
    def tokenize(self, code):
        '''
        Given a string of code, outputs tokens in the Jison format:
        `[tag, value, lineNumber]`
        '''
        # The python tokenizer only accepts objects with a readline() method, so
        # we need to wrap it in a StringIO object
        stringWrappedAsFile = StringIO.StringIO(code)
        for (type, text, startPosition, endPosition, lineText) in tokenize.generate_tokens(stringWrappedAsFile.readline):
            # The position variables are of the form `(row, column)`.  The value
            # of `lineNumber` needed in the Jison format is equivalent to
            # the starting row.
            #
            # **Consider**: Is it possible for tokens to be multi-line?
            startRow = startPosition[0]
            self.tokens.append([tokenize.tok_name[type], text, startRow])
        return self.tokens

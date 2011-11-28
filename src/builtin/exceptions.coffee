# [Relevant](http://docs.python.org/library/exceptions.html#exception-hierarchy)

class BaseException
  constructor: (@message) ->
    
  raise: -> throw new Error("#{getClass(@)}: #{@message}")
  
class SystemExit extends BaseException
  
class KeyboardInterrupt extends BaseException
  
class GeneratorExit extends BaseException
  
class Exception extends BaseException
  
class StopIteration extends Exception

class StandardError extends Exception
  
class BufferError extends StandardError
  
class ArithmeticError extends StandardError
  
class FloatingPointError extends ArithmeticError
  
class OverflowError extends ArithmeticError
  
class ZeroDivisionError extends ArithmeticError
  
class AssertionError extends StandardError
  
class AttributeError extends StandardError
  
class EnvironmentError extends StandardError
  
class IOError extends EnvironmentError
  
class OSError extends EnvironmentError

class WindowsError extends OSError
  
class VMSError extends OSError
  
class EOFError extends StandardError
  
class ImportError extends StandardError
  
class LookupError extends StandardError
  
class IndexError extends LookupError
  
class KeyError extends LookupError
  
class MemoryError extends StandardError
  
class NameError extends StandardError
  
class UnboundLocalError extends StandardError
  
class ReferenceError extends StandardError
  
class RuntimeError extends StandardError
  
class NotImplementedError extends RuntimeError
  
class SyntaxError extends StandardError
  
class IndentationError extends SyntaxError
  
class TabError extends IndentationError
  
class SystemError extends StandardError

class TypeError extends StandardError
  
class ValueError extends StandardError
  
class UnicodeError extends ValueError
  
class UnicodeDecodeError extends UnicodeError
  
class UnicodeEncodeError extends UnicodeError
  
class UnicodeTranslateError extends UnicodeError
  
class Warning extends Exception
  
class DeprecationWarning extends Warning
  
class PendingDeprecationWarning extends Warning
  
class RuntimeWarning extends Warning
  
class SyntaxWarning extends Warning
  
class UserWarning extends Warning
  
class FutureWarning extends Warning
  
class ImportWarning extends Warning
  
class UnicodeWarning extends Warning
  
class BytesWarning extends Warning
var ArithmeticError, AssertionError, AttributeError, BaseException, Bool, BufferError, BytesWarning, DeprecationWarning, Dict, DictionaryKeyIterator, DictionaryValueIterator, EOFError, EnvironmentError, Exception, Float, FloatingPointError, FutureWarning, GeneratorExit, IOError, ImportError, ImportWarning, IndentationError, IndexError, Int, Iterable, Iterator, KeyError, KeyboardInterrupt, List, LookupError, Mapping, MemoryError, NameError, NotImplementedError, Num, OSError, Obj, OverflowError, PendingDeprecationWarning, Primitive, ReferenceError, RuntimeError, RuntimeWarning, Sequence, Set, StandardError, StopIteration, Str, SyntaxError, SyntaxWarning, SystemError, SystemExit, TabError, TypeError, UnboundLocalError, UnicodeDecodeError, UnicodeEncodeError, UnicodeError, UnicodeTranslateError, UnicodeWarning, UserWarning, VMSError, ValueError, Warning, WindowsError, ZeroDivisionError, abs, cmp, float, issubclass, issubinstance, len, pow, print, raise, repr, str, type;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __indexOf = Array.prototype.indexOf || function(item) {
  for (var i = 0, l = this.length; i < l; i++) {
    if (this[i] === item) return i;
  }
  return -1;
}, __slice = Array.prototype.slice;
issubinstance = function(obj1, obj2) {
  return issubclass(type(obj1), type(obj2));
};
raise = function(exception) {
  if (issubclass(type(exception), BaseException)) {
    throw new Error("" + (type(exception).__name__()) + ": " + exception.message);
  } else {
    throw new Error("TypeError: exceptions must be old-style classes or derived from BaseException, not " + (type(exception).__name__()));
  }
};
Obj = (function() {
  var raiseBinaryException, raiseNotIterableException, raiseNotSubscriptableException, raiseUnaryException;
  function Obj() {}
  raiseUnaryException = function(operator, operand) {
    var operandType;
    operandType = type(operand).__name__();
    return raise(new TypeError("bad operand type for " + operator + ": '" + operandType + "'"));
  };
  raiseBinaryException = function(operator, operand1, operand2) {
    var operand1Type, operand2Type;
    operand1Type = type(operand1).__name__();
    operand2Type = type(operand2).__name__();
    return raise(new TypeError("unsupported operand type(s) for " + operator + ": '" + operand1Type + "' and '" + operand2Type + "'"));
  };
  raiseNotIterableException = function(operand) {
    var operandType;
    operandType = type(operand).__name__();
    return raise(new TypeError("argument of type '" + type + "' is not iterable"));
  };
  raiseNotSubscriptableException = function(operand) {
    var operandType;
    operandType = type(operand).__name__();
    return raise(new TypeError("argument of type '" + type + "' is not subscriptable"));
  };
  Obj.__bases__ = function() {
    return [this.__super__.constructor];
  };
  Obj.__name__ = function() {
    return this.name;
  };
  Obj.prototype.__class__ = function() {
    return type(this);
  };
  Obj.prototype.__cmp__ = function(operand) {
    if (this.__lt__(operand)) {
      return -1;
    }
    if (this.__eq__(operand)) {
      return 0;
    }
    if (this.__gt__(operand)) {
      return 1;
    }
  };
  Obj.prototype.__lt__ = function(operand) {
    return true;
  };
  Obj.prototype.__le__ = function(operand) {
    return true;
  };
  Obj.prototype.__eq__ = function(operand) {
    return false;
  };
  Obj.prototype.__ne__ = function(operand) {
    return true;
  };
  Obj.prototype.__ge__ = function(operand) {
    return true;
  };
  Obj.prototype.__gt__ = function(operand) {
    return true;
  };
  Obj.prototype.__not__ = function() {
    return !this.value;
  };
  Obj.prototype.__is__ = function() {};
  Obj.prototype.__is_not__ = function() {};
  Obj.prototype.__contains__ = function() {
    return raise(new TypeError("argument of type '" + (type(this).__name__()) + "' is not iterable"));
  };
  Obj.prototype.__abs__ = function() {
    return raiseUnaryException('abs()', this);
  };
  Obj.prototype.__add__ = function(operand) {
    return raiseBinaryException('+', this, operand);
  };
  Obj.prototype.__and__ = function(operand) {
    return raiseBinaryException('&', this, operand);
  };
  Obj.prototype.__div__ = function(operand) {
    return raiseBinaryException('/', this, operand);
  };
  Obj.prototype.__floordiv__ = function(operand) {
    return raiseBinaryException('//', this, operand);
  };
  Obj.prototype.__invert__ = function() {
    return raiseUnaryException('unary ~', this);
  };
  Obj.prototype.__lshift__ = function(operand) {
    return raiseBinaryException('<<', this, operand);
  };
  Obj.prototype.__mod__ = function(operand) {
    return raiseBinaryException('%', this, operand);
  };
  Obj.prototype.__mul__ = function(operand) {
    return raiseBinaryException('*', this, operand);
  };
  Obj.prototype.__neg__ = function() {
    return raiseUnaryException('unary -', this);
  };
  Obj.prototype.__or__ = function(operand) {
    return raiseBinaryException('|', this, operand);
  };
  Obj.prototype.__pos__ = function() {
    return raiseUnaryException('unary +', this);
  };
  Obj.prototype.__pow__ = function(operand) {
    return raiseBinaryException('**', this, operand);
  };
  Obj.prototype.__rshift__ = function(operand) {
    return raiseBinaryException('>>', this, operand);
  };
  Obj.prototype.__sub__ = function(operand) {
    return raiseBinaryException('-', this, operand);
  };
  Obj.prototype.__xor__ = function(operand) {
    return raiseBinaryException('^', this, operand);
  };
  Obj.prototype.__iadd__ = function(operand) {
    return raiseBinaryException('+=', this, operand);
  };
  Obj.prototype.__iand__ = function(operand) {
    return raiseBinaryException('&=', this, operand);
  };
  Obj.prototype.__idiv__ = function(operand) {
    return raiseBinaryException('/=', this, operand);
  };
  Obj.prototype.__ifloordiv__ = function(operand) {
    return raiseBinaryException('//=', this, operand);
  };
  Obj.prototype.__ilshift__ = function(operand) {
    return raiseBinaryException('<<=', this, operand);
  };
  Obj.prototype.__imod__ = function(operand) {
    return raiseBinaryException('%=', this, operand);
  };
  Obj.prototype.__imul__ = function(operand) {
    return raiseBinaryException('*=', this, operand);
  };
  Obj.prototype.__ior__ = function(operand) {
    return raiseBinaryException('|=', this, operand);
  };
  Obj.prototype.__ipow__ = function(operand) {
    return raiseBinaryException('**=', this, operand);
  };
  Obj.prototype.__irshift__ = function(operand) {
    return raiseBinaryException('>>=', this, operand);
  };
  Obj.prototype.__isub__ = function(operand) {
    return raiseBinaryException('-=', this, operand);
  };
  Obj.prototype.__ixor__ = function(operand) {
    return raiseBinaryException('^=', this, operand);
  };
  Obj.prototype.__contains__ = function(operand) {
    return raiseNotIterableException(this);
  };
  Obj.prototype.__len__ = function() {
    return raise(new TypeError("object of type '" + (type(this).__name__()) + "' has no len()"));
  };
  Obj.prototype.__min__ = function() {
    return raiseNotIterableException(this);
  };
  Obj.prototype.__max__ = function() {
    return raiseNotIterableException(this);
  };
  Obj.prototype.__slice__ = function() {
    return raiseNotSubscriptableException(this);
  };
  return Obj;
})();
Primitive = (function() {
  __extends(Primitive, Obj);
  function Primitive(value) {
    this.value = value;
  }
  Primitive.prototype.__lt__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value < operand.value);
    } else {
      return Primitive.__super__.__lt__.call(this, operand);
    }
  };
  Primitive.prototype.__le__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool <= operand.value;
    } else {
      return Primitive.__super__.__le__.call(this, operand);
    }
  };
  Primitive.prototype.__eq__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value === operand.value);
    } else {
      return Primitive.__super__.__eq__.call(this, operand);
    }
  };
  Primitive.prototype.__ne__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value !== operand.value);
    } else {
      return Primitive.__super__.__ne__.call(this, operand);
    }
  };
  Primitive.prototype.__ge__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value >= operand.value);
    } else {
      return Primitive.__super__.__ge__.call(this, operand);
    }
  };
  Primitive.prototype.__gt__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value > operand.value);
    } else {
      return Primitive.__super__.__gt__.call(this, operand);
    }
  };
  Primitive.prototype.__iadd__ = function(operand) {
    this.value = this.__add__(operand).value;
    return this;
  };
  Primitive.prototype.__iand__ = function(operand) {
    this.value = this.__and__(operand).value;
    return this;
  };
  Primitive.prototype.__idiv__ = function(operand) {
    this.value = this.__div__(operand).value;
    return this;
  };
  Primitive.prototype.__ifloordiv__ = function(operand) {
    this.value = this.__floordiv__(operand).value;
    return this;
  };
  Primitive.prototype.__ilshift__ = function(operand) {
    this.value = this.__lshift__(operand).value;
    return this;
  };
  Primitive.prototype.__imod__ = function(operand) {
    this.value = this.__mod__(operand).value;
    return this;
  };
  Primitive.prototype.__imul__ = function(operand) {
    this.value = this.__mul__(operand).value;
    return this;
  };
  Primitive.prototype.__ior__ = function(operand) {
    this.value = this.__or__(operand).value;
    return this;
  };
  Primitive.prototype.__ipow__ = function(operand) {
    this.value = this.__or__(operand).value;
    return this;
  };
  Primitive.prototype.__irshift__ = function(operand) {
    this.value = this.__rshift__(operand).value;
    return this;
  };
  Primitive.prototype.__isub__ = function(operand) {
    this.value = this.__sub__(operand).value;
    return this;
  };
  Primitive.prototype.__ixor__ = function(operand) {
    this.value = this.__xor__(operand).value;
    return this;
  };
  Primitive.prototype.__str__ = function() {
    return new Str(this.value.toString());
  };
  return Primitive;
})();
BaseException = (function() {
  __extends(BaseException, Primitive);
  function BaseException(message) {
    this.message = message;
  }
  return BaseException;
})();
SystemExit = (function() {
  __extends(SystemExit, BaseException);
  function SystemExit() {
    SystemExit.__super__.constructor.apply(this, arguments);
  }
  return SystemExit;
})();
KeyboardInterrupt = (function() {
  __extends(KeyboardInterrupt, BaseException);
  function KeyboardInterrupt() {
    KeyboardInterrupt.__super__.constructor.apply(this, arguments);
  }
  return KeyboardInterrupt;
})();
GeneratorExit = (function() {
  __extends(GeneratorExit, BaseException);
  function GeneratorExit() {
    GeneratorExit.__super__.constructor.apply(this, arguments);
  }
  return GeneratorExit;
})();
Exception = (function() {
  __extends(Exception, BaseException);
  function Exception() {
    Exception.__super__.constructor.apply(this, arguments);
  }
  return Exception;
})();
StopIteration = (function() {
  __extends(StopIteration, Exception);
  function StopIteration() {
    StopIteration.__super__.constructor.apply(this, arguments);
  }
  return StopIteration;
})();
StandardError = (function() {
  __extends(StandardError, Exception);
  function StandardError() {
    StandardError.__super__.constructor.apply(this, arguments);
  }
  return StandardError;
})();
BufferError = (function() {
  __extends(BufferError, StandardError);
  function BufferError() {
    BufferError.__super__.constructor.apply(this, arguments);
  }
  return BufferError;
})();
ArithmeticError = (function() {
  __extends(ArithmeticError, StandardError);
  function ArithmeticError() {
    ArithmeticError.__super__.constructor.apply(this, arguments);
  }
  return ArithmeticError;
})();
FloatingPointError = (function() {
  __extends(FloatingPointError, ArithmeticError);
  function FloatingPointError() {
    FloatingPointError.__super__.constructor.apply(this, arguments);
  }
  return FloatingPointError;
})();
OverflowError = (function() {
  __extends(OverflowError, ArithmeticError);
  function OverflowError() {
    OverflowError.__super__.constructor.apply(this, arguments);
  }
  return OverflowError;
})();
ZeroDivisionError = (function() {
  __extends(ZeroDivisionError, ArithmeticError);
  function ZeroDivisionError() {
    ZeroDivisionError.__super__.constructor.apply(this, arguments);
  }
  return ZeroDivisionError;
})();
AssertionError = (function() {
  __extends(AssertionError, StandardError);
  function AssertionError() {
    AssertionError.__super__.constructor.apply(this, arguments);
  }
  return AssertionError;
})();
AttributeError = (function() {
  __extends(AttributeError, StandardError);
  function AttributeError() {
    AttributeError.__super__.constructor.apply(this, arguments);
  }
  return AttributeError;
})();
EnvironmentError = (function() {
  __extends(EnvironmentError, StandardError);
  function EnvironmentError() {
    EnvironmentError.__super__.constructor.apply(this, arguments);
  }
  return EnvironmentError;
})();
IOError = (function() {
  __extends(IOError, EnvironmentError);
  function IOError() {
    IOError.__super__.constructor.apply(this, arguments);
  }
  return IOError;
})();
OSError = (function() {
  __extends(OSError, EnvironmentError);
  function OSError() {
    OSError.__super__.constructor.apply(this, arguments);
  }
  return OSError;
})();
WindowsError = (function() {
  __extends(WindowsError, OSError);
  function WindowsError() {
    WindowsError.__super__.constructor.apply(this, arguments);
  }
  return WindowsError;
})();
VMSError = (function() {
  __extends(VMSError, OSError);
  function VMSError() {
    VMSError.__super__.constructor.apply(this, arguments);
  }
  return VMSError;
})();
EOFError = (function() {
  __extends(EOFError, StandardError);
  function EOFError() {
    EOFError.__super__.constructor.apply(this, arguments);
  }
  return EOFError;
})();
ImportError = (function() {
  __extends(ImportError, StandardError);
  function ImportError() {
    ImportError.__super__.constructor.apply(this, arguments);
  }
  return ImportError;
})();
LookupError = (function() {
  __extends(LookupError, StandardError);
  function LookupError() {
    LookupError.__super__.constructor.apply(this, arguments);
  }
  return LookupError;
})();
IndexError = (function() {
  __extends(IndexError, LookupError);
  function IndexError() {
    IndexError.__super__.constructor.apply(this, arguments);
  }
  return IndexError;
})();
KeyError = (function() {
  __extends(KeyError, LookupError);
  function KeyError() {
    KeyError.__super__.constructor.apply(this, arguments);
  }
  return KeyError;
})();
MemoryError = (function() {
  __extends(MemoryError, StandardError);
  function MemoryError() {
    MemoryError.__super__.constructor.apply(this, arguments);
  }
  return MemoryError;
})();
NameError = (function() {
  __extends(NameError, StandardError);
  function NameError() {
    NameError.__super__.constructor.apply(this, arguments);
  }
  return NameError;
})();
UnboundLocalError = (function() {
  __extends(UnboundLocalError, StandardError);
  function UnboundLocalError() {
    UnboundLocalError.__super__.constructor.apply(this, arguments);
  }
  return UnboundLocalError;
})();
ReferenceError = (function() {
  __extends(ReferenceError, StandardError);
  function ReferenceError() {
    ReferenceError.__super__.constructor.apply(this, arguments);
  }
  return ReferenceError;
})();
RuntimeError = (function() {
  __extends(RuntimeError, StandardError);
  function RuntimeError() {
    RuntimeError.__super__.constructor.apply(this, arguments);
  }
  return RuntimeError;
})();
NotImplementedError = (function() {
  __extends(NotImplementedError, RuntimeError);
  function NotImplementedError() {
    NotImplementedError.__super__.constructor.apply(this, arguments);
  }
  return NotImplementedError;
})();
SyntaxError = (function() {
  __extends(SyntaxError, StandardError);
  function SyntaxError() {
    SyntaxError.__super__.constructor.apply(this, arguments);
  }
  return SyntaxError;
})();
IndentationError = (function() {
  __extends(IndentationError, SyntaxError);
  function IndentationError() {
    IndentationError.__super__.constructor.apply(this, arguments);
  }
  return IndentationError;
})();
TabError = (function() {
  __extends(TabError, IndentationError);
  function TabError() {
    TabError.__super__.constructor.apply(this, arguments);
  }
  return TabError;
})();
SystemError = (function() {
  __extends(SystemError, StandardError);
  function SystemError() {
    SystemError.__super__.constructor.apply(this, arguments);
  }
  return SystemError;
})();
TypeError = (function() {
  __extends(TypeError, StandardError);
  function TypeError() {
    TypeError.__super__.constructor.apply(this, arguments);
  }
  return TypeError;
})();
ValueError = (function() {
  __extends(ValueError, StandardError);
  function ValueError() {
    ValueError.__super__.constructor.apply(this, arguments);
  }
  return ValueError;
})();
UnicodeError = (function() {
  __extends(UnicodeError, ValueError);
  function UnicodeError() {
    UnicodeError.__super__.constructor.apply(this, arguments);
  }
  return UnicodeError;
})();
UnicodeDecodeError = (function() {
  __extends(UnicodeDecodeError, UnicodeError);
  function UnicodeDecodeError() {
    UnicodeDecodeError.__super__.constructor.apply(this, arguments);
  }
  return UnicodeDecodeError;
})();
UnicodeEncodeError = (function() {
  __extends(UnicodeEncodeError, UnicodeError);
  function UnicodeEncodeError() {
    UnicodeEncodeError.__super__.constructor.apply(this, arguments);
  }
  return UnicodeEncodeError;
})();
UnicodeTranslateError = (function() {
  __extends(UnicodeTranslateError, UnicodeError);
  function UnicodeTranslateError() {
    UnicodeTranslateError.__super__.constructor.apply(this, arguments);
  }
  return UnicodeTranslateError;
})();
Warning = (function() {
  __extends(Warning, Exception);
  function Warning() {
    Warning.__super__.constructor.apply(this, arguments);
  }
  return Warning;
})();
DeprecationWarning = (function() {
  __extends(DeprecationWarning, Warning);
  function DeprecationWarning() {
    DeprecationWarning.__super__.constructor.apply(this, arguments);
  }
  return DeprecationWarning;
})();
PendingDeprecationWarning = (function() {
  __extends(PendingDeprecationWarning, Warning);
  function PendingDeprecationWarning() {
    PendingDeprecationWarning.__super__.constructor.apply(this, arguments);
  }
  return PendingDeprecationWarning;
})();
RuntimeWarning = (function() {
  __extends(RuntimeWarning, Warning);
  function RuntimeWarning() {
    RuntimeWarning.__super__.constructor.apply(this, arguments);
  }
  return RuntimeWarning;
})();
SyntaxWarning = (function() {
  __extends(SyntaxWarning, Warning);
  function SyntaxWarning() {
    SyntaxWarning.__super__.constructor.apply(this, arguments);
  }
  return SyntaxWarning;
})();
UserWarning = (function() {
  __extends(UserWarning, Warning);
  function UserWarning() {
    UserWarning.__super__.constructor.apply(this, arguments);
  }
  return UserWarning;
})();
FutureWarning = (function() {
  __extends(FutureWarning, Warning);
  function FutureWarning() {
    FutureWarning.__super__.constructor.apply(this, arguments);
  }
  return FutureWarning;
})();
ImportWarning = (function() {
  __extends(ImportWarning, Warning);
  function ImportWarning() {
    ImportWarning.__super__.constructor.apply(this, arguments);
  }
  return ImportWarning;
})();
UnicodeWarning = (function() {
  __extends(UnicodeWarning, Warning);
  function UnicodeWarning() {
    UnicodeWarning.__super__.constructor.apply(this, arguments);
  }
  return UnicodeWarning;
})();
BytesWarning = (function() {
  __extends(BytesWarning, Warning);
  function BytesWarning() {
    BytesWarning.__super__.constructor.apply(this, arguments);
  }
  return BytesWarning;
})();
abs = function(operand) {
  return operand.__abs__();
};
cmp = function(operand1, operand2) {
  return operand1.__cmp__(operand2);
};
float = function(operand) {
  return new Num(window.Number(operand.value));
};
issubclass = function(classArg, classinfo) {
  if (classArg === classinfo) {
    return true;
  } else if (classArg === Obj) {
    return false;
  } else {
    return classArg.__bases__().map(function(parentClass) {
      return issubclass(parentClass, classinfo);
    }).reduce(function(a, b) {
      return a || b;
    });
  }
};
len = function(operand) {
  return operand.__len__();
};
pow = function(operand1, operand2) {
  return operand1.__pow__(operand2);
};
print = function(object) {
  return console.log(object);
};
repr = function(operand) {
  return operand.__repr__();
};
str = function(operand) {
  if (operand != null) {
    return operand.__str__();
  } else {
    return '';
  }
};
type = function(object) {
  return object.constructor;
};
Num = (function() {
  __extends(Num, Primitive);
  function Num() {
    Num.__super__.constructor.apply(this, arguments);
  }
  Num.prototype.__abs__ = function() {
    if (this.value < 0) {
      return this.__neg__();
    } else {
      return this;
    }
  };
  Num.prototype.__add__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value + operand.value);
    } else {
      return Num.__super__.__add__.call(this, operand);
    }
  };
  Num.prototype.__div__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value / operand.value);
    } else {
      return Num.__super__.__div__.call(this, operand);
    }
  };
  Num.prototype.__floordiv__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(Math.floor(this.value / operand.value));
    } else {
      return Num.__super__.__floordiv__.call(this, operand);
    }
  };
  Num.prototype.__mul__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value * operand.value);
    } else {
      return Num.__super__.__mul__.call(this, operand);
    }
  };
  Num.prototype.__neg__ = function() {
    return new (type(this))(-this.value);
  };
  Num.prototype.__pos__ = function() {
    return new (type(this))(+this.value);
  };
  Num.prototype.__pow__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(Math.pow(this.value, operand.value));
    } else {
      return Num.__super__.__pow__.call(this, operand);
    }
  };
  Num.prototype.__sub__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value - operand.value);
    } else {
      return Num.__super__.__sub__.call(this, operand);
    }
  };
  return Num;
})();
Float = (function() {
  __extends(Float, Num);
  function Float() {
    Float.__super__.constructor.apply(this, arguments);
  }
  return Float;
})();
Int = (function() {
  __extends(Int, Num);
  function Int() {
    Int.__super__.constructor.apply(this, arguments);
  }
  Int.prototype.__and__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value & operand.value);
    } else {
      return Int.__super__.__and__.call(this, operand);
    }
  };
  Int.prototype.__div__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.__floordiv__(operand));
    } else {
      return Int.__super__.__div__.call(this, operand);
    }
  };
  Int.prototype.__invert__ = function() {
    return new Int(~this.value);
  };
  Int.prototype.__lshift__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value << operand.value);
    } else {
      return Int.__super__.__lshift__.call(this, operand);
    }
  };
  Int.prototype.__mod__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value % operand.value);
    } else {
      return Int.__super__.__mod__.call(this, operand);
    }
  };
  Int.prototype.__mul__ = function(operand) {
    if (issubclass(type(operand), Sequence)) {
      return operand.__mul__(this);
    } else if (issubinstance(operand, this)) {
      return new Int(this.value * operand.value);
    } else {
      return Int.__super__.__mul__.call(this, operand);
    }
  };
  Int.prototype.__or__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value | operand.value);
    } else {
      return Int.__super__.__or__.call(this, operand);
    }
  };
  Int.prototype.__rshift__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value >> operand.value);
    } else {
      return Int.__super__.__rshift__.call(this, operand);
    }
  };
  Int.prototype.__xor__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Int(this.value ^ operand.value);
    } else {
      return Int.__super__.__xor__.call(this, operand);
    }
  };
  return Int;
})();
Bool = (function() {
  __extends(Bool, Int);
  function Bool(value) {
    this.value = value;
  }
  return Bool;
})();
Iterable = (function() {
  __extends(Iterable, Primitive);
  function Iterable() {
    Iterable.__super__.constructor.apply(this, arguments);
  }
  return Iterable;
})();
Sequence = (function() {
  __extends(Sequence, Primitive);
  function Sequence() {
    Sequence.__super__.constructor.apply(this, arguments);
  }
  Sequence.prototype.__add__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value.concat(operand.value));
    } else {
      return Sequence.__super__.__add__.call(this, operand);
    }
  };
  Sequence.prototype.__contains__ = function(operand) {
    var _ref;
    return new Bool((_ref = operand.value, __indexOf.call(this.value, _ref) >= 0));
  };
  Sequence.prototype.__len__ = function() {
    return new Int(this.value.length);
  };
  Sequence.prototype.__min__ = function() {
    return this.value.reduce(function(a, b) {
      return a(a.__le__(b).value === true ? void 0 : b);
    });
  };
  Sequence.prototype.__max__ = function() {
    return this.value.reduce(function(a, b) {
      return a(a.__ge__(b).value === true ? void 0 : b);
    });
  };
  Sequence.prototype.__mul__ = function(operand) {
    var i, newValue, _ref;
    if (issubclass(type(operand), Int)) {
      newValue = new (type(this))();
      for (i = 0, _ref = operand.value; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        newValue.__iadd__(this);
      }
      return newValue;
    } else {
      return Sequence.__super__.__mul__.call(this, operand);
    }
  };
  Sequence.prototype.__slice__ = function(start, end, step) {
    if (!(step != null)) {
      return new (type(this))(this.value.slice(start, end));
    } else {

    }
  };
  Sequence.prototype.count = function(operand) {
    var element, total, _i, _len, _ref;
    total = 0;
    _ref = this.value;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      element = _ref[_i];
      if (element.__eq__(operand).value === true) {
        total += 1;
      }
    }
    return new Int(total);
  };
  Sequence.prototype.index = function(operand) {
    return new Int(Array.prototype.indexOf(this.value, operand.value));
  };
  return Sequence;
})();
Str = (function() {
  __extends(Str, Sequence);
  function Str(value) {
    this.value = value != null ? value : '';
  }
  Str.prototype.__add__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new (type(this))(this.value + operand.value);
    } else {
      return Str.__super__.__add__.call(this, operand);
    }
  };
  Str.prototype.__contains__ = function(operand) {
    if (issubinstance(operand, this)) {
      return new Bool(this.value.indexOf(operand) > -1);
    } else {
      return Str.__super__.__contains__.call(this, operand);
    }
  };
  Str.prototype.capitalize = function() {
    if (this.__len__().value === 0) {
      return this;
    } else {
      return new (type(this))(this.value[0].toUpperCase() + this.value.slice(1));
    }
  };
  Str.prototype.center = function(width, fillchar) {
    var delta, pad;
    if (fillchar == null) {
      fillchar = new Str(' ');
    }
    if ((type(width)) !== Int) {
      raise(new TypeError('an integer is required'));
    }
    if ((type(fillchar)) !== Str) {
      raise(new TypeError('must be char, not #{type(fillchar).__name__()}'));
    }
    if (width.value <= this.__len__().value) {
      this;
    }
    delta = width.value - this.__len__().value;
    pad = fillchar.__mul__(new Int(Math.floor(delta, 2))).value;
    if (delta % 2 === 0) {
      return new (type(this))(pad + this.value + pad);
    } else {
      return new (type(this))(pad + this.value + pad + fillchar.value);
    }
  };
  Str.prototype.count = function(sub, start, end) {
    var count, curIndex, slicedStr, substringIndex, substringLen;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    count = 0;
    curIndex = 0;
    slicedStr = this.value.slice(start, end);
    substringLen = (new Str(sub)).__len__().value;
    while (curIndex < slicedStr.length) {
      substringIndex = slicedStr.indexOf(sub, curIndex);
      if (substringIndex < 0) {
        break;
      } else {
        curIndex = substringIndex + substringLen;
        count++;
      }
    }
    return new Int(count);
  };
  Str.prototype.decode = function() {};
  Str.prototype.encode = function() {};
  Str.prototype.endswith = function(suffix, start, end) {
    var index, slicedStr;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    slicedStr = this.value.slice(start, end);
    index = slicedStr.lastIndexOf(suffix);
    if (index < 0) {
      return false;
    }
    return new Bool((index + suffix.length) === end);
  };
  Str.prototype.expandtabs = function() {};
  Str.prototype.find = function(sub, start, end) {
    var index, withinBounds;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    index = this.value.indexOf(sub);
    withinBounds = (start <= index && index < end);
    if (withinBounds) {
      return new Int(index);
    } else {
      return new Int(-1);
    }
  };
  Str.prototype.format = function() {};
  Str.prototype.index = function(sub, start, end) {
    var index, substr;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    substr = this.value.slice(start, end);
    index = substr.indexOf(sub);
    if (index === -1) {
      return raise(new ValueError("substring not found"));
    } else {
      return new Int(index);
    }
  };
  Str.prototype.isalnum = function() {
    var alnums, c, _i, _len, _ref;
    alnums = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    if (this.__len__().value === 0) {
      return new Bool(false);
    } else {
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (!(__indexOf.call(alnums, c) >= 0)) {
          return new Bool(false);
        }
      }
      return new Bool(true);
    }
  };
  Str.prototype.isalpha = function() {
    var alphas, c, _i, _len, _ref;
    alphas = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (this.__len__().value === 0) {
      return new Bool(false);
    } else {
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (!(__indexOf.call(alphas, c) >= 0)) {
          return new Bool(false);
        }
      }
      return new Bool(true);
    }
  };
  Str.prototype.isdigit = function() {
    var c, digits, _i, _len, _ref;
    digits = '0123456789';
    if (this.__len__().value === 0) {
      return false;
    } else {
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (!(__indexOf.call(digits, c) >= 0)) {
          return new Bool(false);
        }
      }
      return new Bool(true);
    }
  };
  Str.prototype.islower = function() {
    var c, containsLower, lowers, uppers, _i, _len, _ref;
    lowers = 'abcdefghijklmnopqrstuvwxyz';
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (this.__len__().value === 0) {
      return new Bool(false);
    } else {
      containsLower = false;
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (__indexOf.call(lowers, c) >= 0) {
          containsLower = true;
        }
        if (__indexOf.call(uppers, c) >= 0) {
          return new Bool(false);
        }
      }
      return new Bool(containsLower);
    }
  };
  Str.prototype.isspace = function() {
    var c, spaces, _i, _len, _ref;
    spaces = '\t\n\x0b\x0c\r ';
    if (this.__len__().value === 0) {
      return false;
    } else {
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (!(__indexOf.call(spaces, c) >= 0)) {
          return new Bool(false);
        }
      }
      return new Bool(true);
    }
  };
  /*
    **Fix-me**: Account for punctuation as described in:
    http://docs.python.org/library/stdtypes.html#str.title
    */
  Str.prototype.istitle = function() {
    var firstChar, remaining, word, words, _i, _len;
    words = this.value.split(' ');
    for (_i = 0, _len = words.length; _i < _len; _i++) {
      word = words[_i];
      firstChar = new Str(word[0]);
      if (!firstChar.isupper().value) {
        return new Bool(false);
      }
      if (word.length === 1) {
        continue;
      }
      remaining = new Str(word.slice(1));
      if (!remaining.islower().value) {
        return new Bool(false);
      }
    }
    return new Bool(true);
  };
  Str.prototype.isupper = function() {
    var c, containsUpper, lowers, uppers, _i, _len, _ref;
    lowers = 'abcdefghijklmnopqrstuvwxyz';
    uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (this.__len__().value === 0) {
      return false;
    } else {
      containsUpper = false;
      _ref = this.value;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (__indexOf.call(uppers, c) >= 0) {
          containsUpper = true;
        }
        if (__indexOf.call(lowers, c) >= 0) {
          return new Bool(false);
        }
      }
      return new Bool(containsUpper);
    }
  };
  Str.prototype.join = function(iterable) {};
  Str.prototype.ljust = function(width, fillchar) {
    var delta, pad;
    if (fillchar == null) {
      fillchar = ' ';
    }
    if (width <= this.__len__().value) {
      return this;
    }
    delta = width - this.__len__().value;
    pad = (new Str('')).__mul__(delta).value;
    return new Str(this.value + pad);
  };
  Str.prototype.lower = function() {
    return new Str(this.value.toLowerCase());
  };
  Str.prototype.lstrip = function(chars) {};
  Str.prototype.partition = function(sep) {
    var containsSeparator, partitions, splitValues;
    splitValues = this.split(sep, 1);
    containsSeparator = this.__contains__(sep);
    if (containsSeparator) {
      partitions = [splitValues[0], sep, splitValues[1]];
    } else {
      partitions = [splitValues[0], "", ""];
    }
    return new Tuple(partitions);
  };
  Str.prototype.replace = function(old, replacement, count) {
    if (count != null) {
      return this.split(old, count).join(replacement);
    } else {
      return this.split(old).join(replacement);
    }
  };
  Str.prototype.rfind = function(sub, start, end) {
    var lastIndex;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    lastIndex = this.__slice__(start, end).lastIndexOf(sub);
    return new Int(lastIndex);
  };
  Str.prototype.rindex = function(sub, start, end) {
    var lastIndex;
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    lastIndex = substr.lastIndexOf(sub);
    if (lastIndex === -1) {
      return raise(new ValueError("substring not found"));
    } else {
      return new Int(lastIndex);
    }
  };
  Str.prototype.rjust = function(width, fillchar) {
    var delta, pad;
    if (fillchar == null) {
      fillchar = ' ';
    }
    if (width <= this.__len__().value) {
      return this.value;
    }
    delta = width - this.__len__().value;
    pad = (new Str('')).__mul__(delta).value;
    return new Str(pad + this.value);
  };
  Str.prototype.rpartition = function(sep) {
    var containsSeparator, partitions, splitValues;
    splitValues = this.rsplit(sep, 1);
    containsSeparator = this.__contains__(sep);
    if (containsSeparator) {
      partitions = [splitValues[0], sep, splitValues[1]];
    } else {
      partitions = ["", "", splitValues[0]];
    }
    return new Tuple(partitions);
  };
  Str.prototype.rsplit = function() {};
  Str.prototype.rstrip = function() {};
  Str.prototype.split = function() {};
  Str.prototype.splitlines = function() {};
  Str.prototype.startswith = function(prefix, start, end) {
    if (start == null) {
      start = 0;
    }
    if (end == null) {
      end = this.__len__().value;
    }
    return new Bool(this.value.slice(start, end).indexOf(prefix) === 0);
  };
  Str.prototype.strip = function() {};
  Str.prototype.swapcase = function() {
    var ascii, c, cStr, lowerCaseAscii, lowerCaseChar, result, upperCaseAscii, upperCaseChar, _i, _len, _ref;
    result = '';
    _ref = this.value;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      c = _ref[_i];
      cStr = new Str(c);
      if (cStr.islower()) {
        ascii = c.charCodeAt(0);
        upperCaseAscii = ascii - 32;
        upperCaseChar = String.fromCharCode(upperCaseAscii);
        result += upperCaseChar;
      } else if (cStr.isupper()) {
        ascii = c.charCodeAt(0);
        lowerCaseAscii = ascii + 32;
        lowerCaseChar = String.fromCharCode(lowerCaseAscii);
        result += lowerCaseChar;
      } else {
        result += c;
      }
    }
    return new Str(result);
  };
  /*
    **Fix-me**: Account for punctuation as described in:
    http://docs.python.org/library/stdtypes.html#str.title
    **Unimplemented**
    */
  Str.prototype.title = function() {};
  Str.prototype.translate = function() {};
  Str.prototype.upper = function() {
    return new Str(this.value.toUpperCase());
  };
  Str.prototype.zfill = function(width) {
    var remaining, zeroCount, zeroStr;
    if (width.value <= this.__len__().value) {
      return this;
    }
    zeroStr = new Str('0');
    if (this.__len__().value === 0) {
      return zeroStr.__mul__(width);
    }
    zeroCount = width.value - this.__len__().value;
    if (this.value[0] === '-') {
      remaining = this.value.slice(1);
      return new Str('-' + zeroStr.__mul__(zeroCount).value + remaining);
    } else {
      return new Str(zeroStr.__mul__(zeroCount).value + remaining);
    }
  };
  return Str;
})();
List = (function() {
  __extends(List, Sequence);
  function List(elements) {
    if (elements != null) {
      this.value = elements;
    } else {
      this.value = [];
    }
  }
  List.prototype.append = function(element) {
    this.value.push(element);
  };
  List.prototype.extend = function(list) {
    this.__iadd__(list);
  };
  List.prototype.insert = function(index, element) {
    this.value.splice(index, 0, element);
  };
  List.prototype.remove = function(element) {
    this.value = this.pop(this.index(element));
  };
  List.prototype.pop = function(index) {
    var removed;
    if (index == null) {
      index = new Int(this.__len__().value - 1);
    }
    if (this.__len__().value === 0) {
      return raise(new IndexError("pop from empty list"));
    } else if (index.value < 0 || index.value >= this.__len__().value) {
      return raise(new IndexError("pop index out of range"));
    } else {
      removed = this.value.splice(index.value, 1)[0];
      return removed;
    }
  };
  List.prototype.sort = function() {
    this.value = this.value.sort(function(a, b) {
      if (a.__lt__(b)) {
        return -1;
      } else if (a.__eq__(b)) {
        return 0;
      } else if (a.__gt__(b)) {
        return 1;
      }
    });
  };
  List.prototype.reverse = function(operand) {
    this.value = this.value.reverse();
  };
  return List;
})();
Mapping = (function() {
  __extends(Mapping, Iterable);
  function Mapping() {
    Mapping.__super__.constructor.apply(this, arguments);
  }
  return Mapping;
})();
Set = (function() {
  __extends(Set, Iterable);
  function Set(iterable) {
    var item, _i, _len;
    this.value = new Dict();
    if (iterable != null) {
      for (_i = 0, _len = iterable.length; _i < _len; _i++) {
        item = iterable[_i];
        this.value.__setitem__(item, true);
      }
    }
  }
  Set.prototype.__and__ = function(other) {
    var intersect, item, _i, _len, _ref;
    intersect = [];
    _ref = this.value.value;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (other.__contains__(item)) {
        intersect.push(item);
      }
    }
    return new Set(intersect);
  };
  Set.prototype.__cmp__ = function(set) {
    return (new TypeError("cannot compare sets using cmp()")).raise();
  };
  Set.prototype.__contains__ = function(other) {
    return this.value.__contains__(other);
  };
  Set.prototype.__eq__ = function(set) {
    var item, _i, _j, _len, _len2, _ref, _ref2;
    _ref = set.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (!this.__contains__(item)) {
        return false;
      }
    }
    _ref2 = this.value.keys();
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      item = _ref2[_j];
      if (!set.__contains__(item)) {
        return false;
      }
    }
    return true;
  };
  Set.prototype.__ge__ = function(set) {
    var item, _i, _len, _ref;
    _ref = set.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (!this.__contains__(item)) {
        return false;
      }
    }
    return true;
  };
  Set.prototype.__getattribute__ = function() {};
  Set.prototype.__gt__ = function(set) {
    var item, _i, _len, _ref;
    if (this.__eq__(set)) {
      return false;
    }
    _ref = set.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (!this.__contains__(item)) {
        return false;
      }
    }
    return true;
  };
  Set.prototype.__init__ = function() {};
  Set.prototype.__iter__ = function() {
    return new SetIterator(this);
  };
  Set.prototype.__le__ = function(set) {
    var item, _i, _len, _ref;
    _ref = this.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (!set.__contains__(item)) {
        return false;
      }
    }
    return true;
  };
  Set.prototype.__len__ = function() {
    return this.value.__len__();
  };
  Set.prototype.__lt__ = function(set) {
    var item, _i, _len, _ref;
    if (this.__eq__(set)) {
      return false;
    }
    _ref = this.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (!set.__contains__(item)) {
        return false;
      }
    }
    return true;
  };
  Set.prototype.__ne__ = function(set) {
    return !this.__eq__(set);
  };
  Set.prototype.__or__ = function(set) {
    var item, union, _i, _j, _len, _len2, _ref, _ref2;
    union = [];
    _ref = this.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      union.push(item);
    }
    _ref2 = set.value.keys();
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      item = _ref2[_j];
      union.push(item);
    }
    return new Set(union);
  };
  Set.prototype.__rand__ = function(set) {
    return this.__and__(set);
  };
  Set.prototype.__reduce__ = function() {};
  Set.prototype.__repr__ = function() {};
  Set.prototype.__ror__ = function(set) {
    return this.__or__(set);
  };
  Set.prototype.__rsub__ = function(set) {
    return set.__sub__(this);
  };
  Set.prototype.__rxor__ = function(set) {
    return this.__xor__(set);
  };
  Set.prototype.__sizeof__ = function() {};
  Set.prototype.__sub__ = function(set) {
    var difference, item, _i, _len, _ref;
    difference = this.copy();
    _ref = set.value.keys();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (this.__contains__(item)) {
        difference.value.pop(item);
      }
    }
    return difference;
  };
  Set.prototype.__xor__ = function(set) {
    var diff1, diff2, xor;
    diff1 = this.__sub__(set);
    diff2 = set.__sub__(this);
    xor = diff1.__or__(diff2);
    return xor;
  };
  Set.prototype.add = function(element) {
    this.value.__setitem__(element, true);
  };
  Set.prototype.clear = function() {
    return this.value.clear();
  };
  Set.prototype.copy = function() {
    var keys;
    keys = this.keys();
    return new Set(keys);
  };
  Set.prototype.difference = function() {
    var difference, other, others, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    difference = this.copy();
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      difference.__isub__(other);
    }
    return difference;
  };
  Set.prototype.difference_update = function() {
    var other, others, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      this.__isub__(other);
    }
  };
  Set.prototype.discard = function(elem) {
    if (this.value.__contains__(elem)) {
      this.value.pop(elem);
    }
  };
  Set.prototype.intersection = function() {
    var intersect, other, others, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    intersect = this.copy();
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      intersect.__iand__(other);
    }
    return intersect;
  };
  Set.prototype.intersection_update = function() {
    var other, others, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      this.__iand__(other);
    }
  };
  Set.prototype.isdisjoint = function(set) {
    return this.__and__(set).__len__() === 0;
  };
  Set.prototype.issubset = function(set) {
    return this.__le__(set);
  };
  Set.prototype.issuperset = function(set) {
    return this.__ge__(set);
  };
  Set.prototype.pop = function() {
    var randomItem, randomKey;
    if (this.value.__len__ === 0) {
      return (new KeyError("pop from an empty set")).raise();
    } else {
      randomItem = this.value.popitem();
      randomKey = randomItem.__getitem__(0);
      return randomKey;
    }
  };
  Set.prototype.remove = function(elem) {
    if (__indexOf.call(this.value.value, elem) < 0) {
      (new KeyError("" + elem)).raise();
    } else {
      this.value.pop(elem);
    }
  };
  Set.prototype.symmetric_difference = function(other) {
    return this.__xor__(other);
  };
  Set.prototype.symmetric_difference_update = function(other) {
    this.__ixor__(other);
  };
  Set.prototype.union = function() {
    var other, others, union, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    union = this.copy();
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      union.__ior__(other);
    }
    return union;
  };
  Set.prototype.update = function() {
    var other, others, _i, _len;
    others = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    for (_i = 0, _len = others.length; _i < _len; _i++) {
      other = others[_i];
      this.__ior__(other);
    }
  };
  return Set;
})();
Iterator = (function() {
  __extends(Iterator, Primitive);
  function Iterator() {
    Iterator.__super__.constructor.apply(this, arguments);
  }
  Iterator.prototype.__iter__ = function() {
    return this;
  };
  return Iterator;
})();
DictionaryKeyIterator = (function() {
  __extends(DictionaryKeyIterator, Iterator);
  function DictionaryKeyIterator(dictionary) {
    this.iterable = dictionary.keys();
    this.index = 0;
  }
  DictionaryKeyIterator.prototype.next = function() {
    if (this.index >= len(this.iterable).value) {
      return raise(new StopIteration("StopIteration"));
    } else {
      return this.iterable.__getitem__(this.index++);
    }
  };
  return DictionaryKeyIterator;
})();
DictionaryValueIterator = (function() {
  __extends(DictionaryValueIterator, Iterator);
  function DictionaryValueIterator(dictionary) {
    this.iterable = dictionary.values();
    this.index = 0;
  }
  DictionaryValueIterator.prototype.next = function() {
    if (this.index >= len(this.iterable).value) {
      return raise(new StopIteration("StopIteration"));
    } else {
      return this.iterable.__getitem__(this.index++);
    }
  };
  return DictionaryValueIterator;
})();
Dict = (function() {
  __extends(Dict, Mapping);
  function Dict(iterable) {
    var key, value;
    this.value = {};
    if (iterable != null) {
      for (key in iterable) {
        value = iterable[key];
        this.value[key] = value;
      }
    }
  }
  Dict.prototype.__contains__ = function(key) {
    return new Bool(key in this.value);
  };
  Dict.prototype.__delitem__ = function(key) {
    delete this.value[key];
  };
  Dict.prototype.__eq__ = function(dict) {
    var key, keys, otherKeys, otherSet, otherVal, set, val, _i, _len;
    keys = Object.keys(this.value);
    otherKeys = Object.keys(dict.value);
    set = new Set(keys);
    otherSet = new Set(otherKeys);
    if (set.__ne__(otherSet)) {
      return new Bool(false);
    }
    for (_i = 0, _len = keys.length; _i < _len; _i++) {
      key = keys[_i];
      val = this.__getitem__(key);
      otherVal = dict.__getitem__(key);
      if (val !== otherVal) {
        return new Bool(false);
      }
    }
    return new Bool(true);
  };
  Dict.prototype.__ge__ = function(dict) {
    return new Bool(this.__gt__(dict) || this.__eq__(dict));
  };
  Dict.prototype.__getattribute__ = function(attr) {};
  Dict.prototype.__getitem__ = function(key) {
    return this.value[key];
  };
  Dict.prototype.__gt__ = function(dict) {
    return new Bool(!this.__le__(dict));
  };
  Dict.prototype.__init__ = function() {};
  Dict.prototype.__iter__ = function() {
    return new DictionaryKeyIterator(this);
  };
  Dict.prototype.__le__ = function(dict) {
    return new Bool(this.__lt__(dict) || this.__eq__(dict));
  };
  Dict.prototype.__len__ = function() {
    return new Int(Object.keys(Object(this.value)).length);
  };
  Dict.prototype.__lt__ = function(dict) {
    var i, key, keys, otherKeys, otherVal, val, _len;
    if (this.__len__().value < dict.__len__().value) {
      return new Bool(true);
    } else if (this.__len__().value > dict.__len__().value) {
      return new Bool(false);
    } else {
      keys = Object.keys(this.value).sort();
      otherKeys = Object.keys(dict.value).sort();
      for (i = 0, _len = keys.length; i < _len; i++) {
        key = keys[i];
        if (key >= otherKeys[i]) {
          return new Bool(false);
        }
        val = this.__getitem__(key);
        otherVal = this.__getitem__(otherKeys[i]);
        if (val >= otherVal) {
          return new Bool(false);
        }
      }
      return new Bool(true);
    }
  };
  Dict.prototype.__ne__ = function(dict) {
    return new Bool(!this.__eq__(dict));
  };
  Dict.prototype.__repr__ = function() {};
  Dict.prototype.__setitem__ = function(key, value) {
    this.value[key] = value;
  };
  Dict.prototype.__sizeof__ = function() {};
  Dict.prototype.clear = function() {
    this.value = {};
  };
  Dict.prototype.copy = function() {
    var copy;
    copy = new Dict(this);
    return copy;
  };
  Dict.fromkeys = function() {};
  Dict.prototype.get = function(key, d) {
    if (key in this.value) {
      return this.__getitem__(key);
    } else {
      return d;
    }
  };
  Dict.prototype.has_key = function(key) {
    return new Bool(key in this.value);
  };
  Dict.prototype.items = function() {
    var items, key, tuple, val;
    items = new List();
    for (key in this.value) {
      val = this.__getitem__(key);
      tuple = new Tuple([key, val]);
      items.append(tuple);
    }
    return items;
  };
  Dict.prototype.iteritems = function() {
    return new DictionaryItemIterator(this);
  };
  Dict.prototype.iterkeys = function() {
    return new DictionaryKeyIterator(this);
  };
  Dict.prototype.itervalues = function() {
    return new DictionaryValueIterator(this);
  };
  Dict.prototype.keys = function() {
    var keys;
    keys = new List(Object.keys(this.value));
    return keys;
  };
  Dict.prototype.pop = function(key, d) {
    var keys, val;
    keys = this.keys();
    if (keys.__contains__(key)) {
      val = this.value[key];
      delete this.value[key];
      return val;
    } else if (d != null) {
      return d;
    } else {
      return raise(new KeyError("" + key));
    }
  };
  Dict.prototype.popitem = function() {
    var keys, randomKey, randomValue;
    if (this.__len__().value === 0) {
      raise(new KeyError("popitem(): dictionary is empty"));
    }
    keys = this.keys();
    randomKey = keys.__getitem__(0);
    randomValue = this.__getitem__(randomKey);
    return new Tuple([randomKey, randomValue]);
  };
  Dict.prototype.setdefault = function(key, d) {
    if (__indexOf.call(this.keys().value, key) < 0) {
      this.__setitem__(key, d);
    }
    return this.value[key];
  };
  Dict.prototype.update = function() {};
  Dict.prototype.values = function() {
    var key, keys, val, values, _i, _len, _ref;
    keys = this.keys();
    values = new List();
    _ref = keys.value;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      key = _ref[_i];
      val = this.__getitem__(key);
      values.append(val);
    }
    return values;
  };
  Dict.prototype.viewitems = function() {};
  Dict.prototype.viewkeys = function() {};
  Dict.prototype.viewvalues = function() {};
  return Dict;
})();

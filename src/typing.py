import types

def getClassName(object):
    return object.__class__.__name__

def isList(object):
    return type(object) == types.ListType

def isPrimitive(object):
    return type(object) in {types.IntType, types.StringType, types.FloatType}

def isExpressionContext(object):
    return getClassName(object) in {'Load', 'Store', 'Del', 'AugLoad', 'AugStore', 'Param'}

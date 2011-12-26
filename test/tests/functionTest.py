def regularFunc(x, y): ## WORKS IN FIREFOX. NOT CHROME
    print x
    return x ** y

print regularFunc(4, 5)

def outerFunc(x): ## WORKS IN FIREFOX. NOT CHROME
    def innerFunc():
        return 5 * x
    return innerFunc

outer = outerFunc(3)
print outer()

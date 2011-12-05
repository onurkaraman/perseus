//
//		def addDisbelief(originalQuote):
//		    return originalQuote + '! Great Scott!'
//
//		def miltonFunction():
//		    def miltonClosure():
//			return "excuse me, I believe you have my stapler...".capitalize()
//		    return miltonClosure
//
//		print addDisbelief('1.21 Gigawatts')
//		martyQuote = 'Wait a minute, Doc. Ah... Are you telling me that you built a time machine... out of a DeLorean?'
//		print martyQuote.upper()
//
//		miltonConcern = miltonFunction()
//		print miltonConcern()
//
//		print 5 < 7 < 2 # Chained comparisons!
//
//		print "Woop " * 2
//
//		print 5 // 2
//		print 5 ** 2
//
//		numbers = [8, -0.1, 101]
//		print len(numbers)
//
//		emptylist = []
//		emptylist.pop() # Pythonic exceptions
//
var addDisbelief = function(originalQuote) {
    return originalQuote.__add__(new Str("! Great Scott!"));
};
var miltonFunction = function() {
    var miltonClosure = function() {
        return new Str("excuse me, I believe you have my stapler...").capitalize();
    };
    return miltonClosure;
};
console.log((addDisbelief(new Str("1.21 Gigawatts"))).value);
var martyQuote = new Str("Wait a minute, Doc. Ah... Are you telling me that you built a time machine... out of a DeLorean?");
console.log((martyQuote.upper()).value);
var miltonConcern = miltonFunction();
console.log((miltonConcern()).value);
console.log((new Int(5).__lt__(new Int(7)) && new Int(7).__lt__(new Int(2))).value);
console.log((new Str("Woop ").__mul__(new Int(2))).value);
console.log((new Int(5).__floordiv__(new Int(2))).value);
console.log((new Int(5).__pow__(new Int(2))).value);
var numbers = new List([new Int(8), new Num(-0.1), new Int(101)]);
console.log((len(numbers)).value);
var emptylist = new List([]);
emptylist.pop();

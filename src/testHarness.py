import os

def normalize(string):
	return ''.join(string.split()).strip()

tests = [
	'"hello, world!"',
	'''[[1,2,    3],
			[3,4], [5]]''',
	'3 ** 4',
	'"tastychicken"[4]',
]

i = 1
for test in tests:
	test = test.strip()
	pythonCode = open('test.py', 'w')
	pythonCode.write('print ' + test)
	pythonCode.close()
	pythonValue = str(eval(test))
	
	os.system('python pythonscript.py > test.js')
	os.system('node test.js > result.txt')

	jsValue = open('result.txt', 'r').read()

	print("Test %i: '%s'") % (i, test)
	print normalize(pythonValue)
	print normalize(jsValue)
	if (normalize(pythonValue) == normalize(jsValue)):
		print 'Pass'
	else:
		print 'Fail'
	print('')

	i += 1

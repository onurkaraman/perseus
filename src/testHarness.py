import os
import tempfile

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
	pythonCodeFile = tempfile.NamedTemporaryFile()
	pythonCodeFile.write('print ' + test)
	pythonValue = str(eval(test))
	pythonCodePath = pythonCodeFile.name

	tempResultFile = tempfile.NamedTemporaryFile()
	os.system('python ../test/compiler.py %s > %s' % (pythonCodePath, tempResultFile))
	os.system('node %s > %s' % (tempResultFile, tempResultFile))

	pythonCodeFile.close()
	jsValue = tempResultFile.read()
	tempResultFile.close()

	print("Test %i: '%s'") % (i, test)
	print normalize(pythonValue)
	print normalize(jsValue)
	if (normalize(pythonValue) == normalize(jsValue)):
		print 'Pass'
	else:
		print 'Fail'
	print('')

	i += 1

#!/bin/usr/python

# TODO: Look into https://github.com/davisp/python-spidermonkey for potentially 
# testing without having to check print statement results
import os
import subprocess

TEST_PATH = './tests/'

def outputResults(testFileName, pythonOutput, jsOutput):
	if pythonOutput == jsOutput:
		print 'PASS: %s' % testFileName
	else:
		formattedPyOutput = '\n\t\t'.join(pythonOutput.splitlines())
		formattedJsOutput = '\n\t\t'.join(jsOutput.splitlines())
		print 'FAIL: %s\n\tExpected:\n\t\t%s\n\tActual:\n\t\t%s' % (testFileName, formattedPyOutput, formattedJsOutput)

def runTest(pyTestFileName):
	pyTestFilePath = TEST_PATH + pyTestFileName
	pythonOutput = subprocess.check_output(['python', pyTestFilePath])
	perseus = open('../perseus.js','r').read()
	jsTestFileName = 'tmpTest.js'
	try:
		jsTest = subprocess.check_output(['python', 'compiler.py', pyTestFilePath])

		jsTestFile = open(jsTestFileName, 'w+')
		jsTestFile.write(perseus + jsTest)
		jsTestFile.close()

		jsOutput = subprocess.check_output(['node', jsTestFileName])
		outputResults(pyTestFileName, pythonOutput, jsOutput)
	except Exception as exception:
		outputResults(pyTestFileName, pythonOutput, str(exception))
	finally:
		if os.path.exists(jsTestFileName):
			os.remove(jsTestFileName)

if __name__ == '__main__':
	pyTestFileNames = os.listdir(TEST_PATH)
	for pyTestFileName in pyTestFileNames:
		runTest(pyTestFileName)

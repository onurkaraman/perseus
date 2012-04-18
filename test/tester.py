#!/bin/usr/python

# TODO: Look into https://github.com/davisp/python-spidermonkey for potentially 
# testing without having to check print statement results
import os
import subprocess

TEST_PATH = './tests/'

def formatText(text, indentLevel):
    delimiter = '\n' + '\t' * indentLevel
    return delimiter.join(text.splitlines())

def outputResults(testFileName, pythonOutput, jsInput, jsOutput):
    if pythonOutput == jsOutput:
        print 'PASS: %s' % testFileName
    else:
        formattedPyOutput = formatText(pythonOutput, 2)
        formattedJsOutput = formatText(jsOutput, 2)
        formattedJsInput = formatText(jsInput, 2)
        print 'FAIL: %s\n\tExpected:\n\t\t%s\n\tActual:\n\t\t%s\n\tSource:%s\n\t\t' % (testFileName, formattedPyOutput, formattedJsOutput, formattedJsInput)

def runTest(pyTestFileName):
    pyTestFilePath = TEST_PATH + pyTestFileName
    pythonOutput = subprocess.check_output(['python', pyTestFilePath])
    perseus = open('../perseus.js','r').read()
    jsTestFileName = 'tmpTest.js'
    try:
        jsTest = subprocess.check_output(['python', 'compiler.py', pyTestFilePath])
    except Exception as exception:
        outputResults(pyTestFileName, pythonOutput, '[Compilation Error]', str(exception))
        return
    with open(jsTestFileName, 'w+') as jsTestFile:
        jsTestFile.write(perseus + jsTest)
    try:
        jsOutput = subprocess.check_output(['node', jsTestFileName])
        outputResults(pyTestFileName, pythonOutput, jsTest, jsOutput)
    except Exception as exception:
        outputResults(pyTestFileName, pythonOutput, jsTest, str(exception))
    finally:
        if os.path.exists(jsTestFileName):
            os.remove(jsTestFileName)

if __name__ == '__main__':
    pyTestFileNames = os.listdir(TEST_PATH)
    for pyTestFileName in pyTestFileNames:
        runTest(pyTestFileName)

#!/usr/bin/env python
import re

# TOKEN LABELS
INDENT = 'INDENT'
DEDENT = 'DEDENT'

def getLineTokens(lines):
	'''
	Gets the tokens for a group of lines
	@reference: http://docs.python.org/reference/lexical_analysis.html#indentation
	@param lines - the list of lines whose tokens we wish to get
	@return tokens - a list of tokens, where returned tokens are either:
		INDENT
		DEDENT
		raw line of code
	TODO:
		How to handle comment lines (first nonwhitespace char is #) if at all?
			Do comment lines get thrown out before I even receive lines?
		How to handle multiline strings if at all?
	'''
	indentStack = [0]
	tokens = []
	indentPattern = re.compile(r"(\s*)")
	for line in lines:
		print indentPattern.match(line).groups()
		startingWhitespace = indentPattern.match(line).group(1)
		cleanedStartingWhitespace = startingWhitespace.expandtabs()
		level = len(cleanedStartingWhitespace)
		previousLevel = indentStack[-1]
		while level < previousLevel:
			indentStack.pop()
			previousLevel = indentStack[-1]
			tokens.append(DEDENT)
		if level > previousLevel:
			indentStack.append(level)
			tokens.append(INDENT)
		tokens.append(line.strip())
	return tokens

if __name__ == '__main__':
	fp = open('testIndent.py')
	lines = fp.readlines()
	fp.close()
	print getLineTokens(lines)

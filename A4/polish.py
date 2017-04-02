#!/usr/bin/python
#A4: Reverse polish form: Python
#Written by Christopher Katsaras
#April 7th/2017
#
#***********
#Compile/run
#***********
#Type "make python"
#
#*****************
#Known limitations
#*****************
#
#

originalString = []
polishString = []
stack = []

#Function definitions
def push(symbol, stack, top):
	top += 1
	stack.insert(top,symbol)
	return top;

def pop(polishString, stack, top, polishLength):
	polishLength += 1
	polishString.insert(polishLength,stack[top])
	top -= 1
	return top;	

def priority(sym):

	if sym == '%' or sym == ')':
		return -1;
	elif sym == '(':
		return 0;
	elif sym == '+' or sym == '-':
		return 1;
	elif sym == '*' or sym == '/':
		return 2;
	elif sym == '^':
		return 3;		
	else:
		return -2;


print "Please input an algebraic expression to convert"

originalString = raw_input()
length = len(originalString)
polishLength = 0
top = 0

stack.insert(top,'%')

for char in originalString:
	if char.isalnum():
		polishLength += 1
		polishString.insert(polishLength,char)
	elif char == '%' or char == '+' or char == '-' or char == '*' or char == '/' or char == '^':
		while (priority(char) <= priority(stack[top])):
			top = pop(polishString,stack,top,polishLength)
		top = push(char,stack,top)
	elif char == '(':
		top = push(char,stack,top)
	elif char == ')':
		while (priority(stack[top]) != priority('(')):	
			top = pop(polishString,stack,top,polishLength)
		top -= 1	
	else :
		print "Invalid operator"	

while (top > 0):
	if(stack[top] == '('):
		print "Unmatched brackets"
	else :
		polishLength += 1
		polishString.insert(polishLength,stack[top])
	top -= 1

print "".join(polishString)


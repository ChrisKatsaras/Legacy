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
#1.Spaces in inputted equation may cause incorrect output
#e.g 1   + 2 * (3-  2) = NOT SUPPORTED :(
#e.g 1+2*(3-2) = SUPPORTED :)
#!2.Equations should be inputted with NO spaces for best results 

originalString = []
polishString = []
stack = []
playAgain = 'Y'

#Function definitions
#
#Pushes item to the stack
def push(symbol, stack, top):
	top += 1
	try:
		stack[top] = symbol
	except IndexError:
		stack.insert(top,symbol)	
	return top;

#Pops item off stack and put inserts it into the output string
def pop(polishString, stack, top):
	polishString.insert(polishLength,stack[top])
	top -= 1
	return top;	

#Returns the priority of a specific symbol
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

#Loops until user chooses to quit
while (playAgain == 'Y'):
	print "Please input an algebraic expression to convert (No spaces, please)"

	originalString = raw_input()
	length = len(originalString)
	polishLength = 0
	top = 0

	stack.insert(top,'%')

	#Uses a state based parsing method where each character is examined individually 
	for char in originalString:
		if char.isalnum():
			polishLength += 1
			polishString.insert(polishLength,char)
		elif char == '%' or char == '+' or char == '-' or char == '*' or char == '/' or char == '^':
			while (priority(char) <= priority(stack[top])):
				polishLength += 1
				top = pop(polishString,stack,top)
			top = push(char,stack,top)
		elif char == '(':
			top = push(char,stack,top)
		elif char == ')':
			while (priority(stack[top]) != priority('(')):
				polishLength += 1	
				top = pop(polishString,stack,top)
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
	
	print "".join(polishString) #Formats output for the user
	playAgain = raw_input("Would you like to convert another expression? (Type Y to play again or any other key to exit)")
	stack[:] = [] #clears the stack and polishString lists
	polishString[:] = []

print "Goodbye"	

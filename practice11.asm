#CS 2640.02

#Author: Laila Tatum
#Date: 11/7/2025
#Description:
	#1.) define macro to pass a programmer defined string
	#2.) use the macro to print the string 3 times, each on a new line
	#3.) save the macro to a seperate file and include it here

#include defined macros from the macros.asm file
.include "macros.asm"

.data

.text
main:
	#call the printString macro to print a string a number of times
	printString("string\n", 20)

exit:
	#exit the program
	li $v0, 10
	syscall

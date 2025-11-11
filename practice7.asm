#CS 2640.02

#Author: Laila Tatum
#Date: 11/3/2025
#Description: define a macro that will print an int the programmer passes to the ints macro


#define macro to print a given integer
.macro ints(%x)
	li $v0, 1	#print an integer
	la $a0, %x	#integer specified as '%x' parameter
	syscall
.end_macro

.text
main:
	#call ints macro to print 12
	ints(12)
	
	#exit program
	li $v0, 10
	syscall

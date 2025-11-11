#CS 2640.02

#Author: Laila Tatum
#Date: 10/31/2025
#Description:
	#1.) use a macro to print a string
	#2.) print the string 5 times with a loop
	#3.) use a macro to exit the program

#macro to print a string on different lines
.macro printing
	li $v0, 4		#print a string
	la $a0, aString		#string specified as 'aString'
	syscall
.end_macro

#macro to exit the program
.macro exit
	li $v0, 10
	syscall
.end_macro

.data
aString: .asciiz "hello\n"

.text
main:
	li $t0, 0		#loop counter
	j loop

loop:
	printing
	
	addi $t0, $t0, 1	#increment loop counter by 1
	beq $t0, 5, exit	#if the counter equals 5, exit
	
	j loop			#if $t2 < 5, keep looping

exit:
	exit

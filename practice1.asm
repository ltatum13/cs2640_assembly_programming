#CS 2640.02

#Author: Laila Tatum
#Date: 10/20/25
#Description: basic message program

.data
message: .asciiz "hello"

.text
main:
	#print a string
	li $v0, 4 	#priming our program to print
	la $a0, message #load message address into $a0
	syscall
	
	#exit program
	li $v0, 10
	syscall
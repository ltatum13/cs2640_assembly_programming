#assignment prompt, the goals of the program

#Author: Laila Tatum
#Date: 11/7/2025
#Description: define a macro that gets a string from user input

#macro that asks user for string
.macro getString
	li $v0, 8	#read a string
	la $a0, buffer	#set the buffer
	li $a1, 10	#set number of characters to read
	syscall
.end_macro

.data
prompt: .asciiz "Enter a word or phrase: "
userString: .asciiz "\nYour string is: "
buffer: .space 10

.text
main:
	#ask the user for a string
	li $v0, 4	#print a string
	la $a0, prompt	#specify string as 'prompt'
	syscall
	
	#call the getString macro to get user string
	getString
	
	#print the format for the result
	li $v0, 4		#print a string
	la $a0, userString	#specify the string as 'userString'
	syscall
	
	#return the string back to the user
	li $v0, 4	#print a string
	la $a0, buffer	#specify the string as 'buffer'
	syscall
	
	#exit program
	li $v0, 10
	syscall

#CS 2640.02

#Author: Laila Tatum
#Date: 11/10/2025
#Description: write a function to prompt for and get a string

.macro printStr(%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro

.data
prompt: .asciiz "\nEnter a string: "
buffer: .space 30
mainStr: .asciiz "In Main label . . ."
backInMain: .asciiz "\nBack in the Main label . . ."
exitProgram: .asciiz "\nExitng the program . . ."
userCheck: .asciiz "\nString Received!"

.text
main:
	#print "In Main label . . ."
	printStr(mainStr)
	
	#function call
	jal getString
	
	#back in the main label
	printStr(backInMain)
	
	#exit the program
	printStr(exitProgram)
	li $v0, 10
	syscall

getString: #external function
	#prompt the user for a string
	printStr(prompt)
	
	#get string from user
	li $v0, 8	#read a string
	la $a0, buffer	#load the buffer
	li $a1, 11	#maximum characters to read
	syscall
	
	#jump into interal function
	la $t0, stringCheck	#load the address to stringCheck to $t0
	jalr $t1, $t0		#set the return address and jump to stringCheck
	
	#return to the main label
	jr $ra
	
	stringCheck: #internal function: print "String Received!"
		printStr(userCheck)
		
		#return to the getString label
		jr $t1
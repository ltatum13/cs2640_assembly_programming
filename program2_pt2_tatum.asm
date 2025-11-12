#CS 2640.02
#task 2: write a program in Assembly that takes two intergers from a user, x and y, ensure the user knows which
#  integer is x and which is y, and calculate and output x to the power of y to the user
#include a main, looping, and exit label along with a loop counter

#Author: Laila Tatum
#Date: 11/10/2025
#Description: create a program that:
	#1.) asks the user for integers x and y
	#2.) calculates x to the power of y
	#3.) outputs the result to the user

.data
#instructions for the user
instructions: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power of 3 is 8.\n"

#prompts for x and y
xPrompt: .asciiz "\nEnter a number for 'x': "
yPrompt: .asciiz "\nEnter a number for 'y': "

#formatting for the result
result: .asciiz "\n'x' to the power of 'y' is: "

.text
main:
	#print the instructions to the user
	li $v0, 4				#print a string
	la $a0, instructions	#specify the string as 'instructions'
	syscall
	
	#ask the user for integer x
	li $v0, 4			#print a string
	la $a0, xPrompt		#specify the string as 'xPrompt'
	syscall
	
	#get integer x from the user
	li $v0, 5		#read an integer
	syscall
	move $t0, $v0	#save the given integer to $t0
	move $t3, $v0	#save the given integer to $t3
	
	#ask the user for integer y
	li $v0, 4			#print a string
	la $a0, yPrompt		#specify the string as 'yPrompt'
	syscall
	
	#get integer y from the user
	li $v0, 5		#read an integer
	syscall
	move $t1, $v0	#save the given integer to $t1
	
	li $t2, 1		#loop counter
	j looping		#jump to the looping label
	
looping:
	#check that the loop counter is less than y
	#  jump to exit label when loop counter meets y
	beq $t1, $t2, exit
	
	#multiply x to itself and save the product to $t0
	mul $t0, $t0, $t3
	
	#increment the loop counter by 1
	addi $t2, $t2, 1
	
	#go through the looping label again
	j looping
	
exit:
	#print the result to the user
	li $v0, 4		#print a string
	la $a0, result	#specify the string as 'result'
	syscall
	
	li $v0, 1		#print an integer
	move $a0, $t0	#specify the integer as the result ($t0)
	syscall

	#exit the program
	li $v0, 10
	syscall
#CS 2640.02

#Author: Laila Tatum
#Date: 10/20/25
#Description:
	#1.) get two numbers from the user
	#2.) evaluate which number is greater
	#3.) output the greater number

.data
prompt: .asciiz "Enter an integer: "
isGreater: .asciiz "The greater value is "

.text
main:
	#prompt the user for the first integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the first integer from the user
	li $v0, 5
	syscall
	move $t0, $v0  #store first integer from user input in $t0 for later
	
	#prompt the user for the second integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the second integer from the user
	li $v0, 5
	syscall
	move $t1, $v0	#store second integer from user input in $t1 for later
	
	#evaluate which user number is greater
	bgt $t0, $t1, firstValGreater  #first input is greater
	bgt $t1, $t0, secondValGreater #second input is greater

firstValGreater:
	#print the isGreater string
	li $v0, 4
	la $a0, isGreater
	syscall
	
	#print the greater value ($t0)
	li $v0, 1
	move $a0, $t0
	syscall
	
secondValGreater:
	#print the isGreater string
	li $v0, 4
	la $a0, isGreater
	syscall
	
	#print the greater value ($t1)
	li $v0, 1
	move $a0, $t1
	syscall
	
	#exit program
	li $v0, 10
	syscall

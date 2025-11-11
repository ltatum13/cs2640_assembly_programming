#CS 2640.02

#Author: Laila Tatum
#Date: 10/22/25
#Description:
	#1.) takes two numbers from the user
	#2.) have the user select an output menu of the 4 arithmetic options
	#3.) display the result in the output to the user

.data
menu: .asciiz "1.) addition\n2.) subtraction\n3.) multiplication\n4.) division\nPlease enter the number of your desired operation: "
prompt: .asciiz "Enter an integer: "
result: .asciiz "The result is "

.text
main:
	#prompt the user for first integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the first integer from user input
	li $v0, 5
	syscall
	move $t0, $v0	#store first integer from user input in $t0 for later
	
	#prompt the user for second integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the second integer from user input
	li $v0, 5
	syscall
	move $t1, $v0	#store first integer from user input in $t1 for later
	
	#prompt the user to choose from the menu
	li $v0, 4	#print a string
	la $a0, menu 	#string specified as 'menu'
	syscall
	
	#get the user operation number
	li $v0, 5
	syscall
	move $t2, $v0
	
	#if $t2 is 1, addition
	beq $t2, 1, addition
	
	#if $t2 is 2, subtraction
	beq $t2, 2, subtraction
	
	#if $t2 is 3, multiplication
	beq $t2, 3, multiplication
	
	#if $t2 is 4, division
	beq $t2, 4, division
	
addition:
	#add $t0 and $t1
	add $t0, $t0, $t1
	
	#print the sum
	j printResult

subtraction:
	#add $t0 and $t1
	sub $t0, $t0, $t1
	
	#print the difference
	j printResult

multiplication:
	#add $t0 and $t1
	mul $t0, $t0, $t1
	
	#print the product
	j printResult

division:
	#add $t0 and $t1
	div $t0, $t0, $t1
	
	#print the quotient
	j printResult
	
printResult:
	#string for format
	li $v0, 4
	la $a0, result
	syscall
	
	#print the result
	li $v0, 1
	move $a0, $t0
	syscall
	
	#exit program
	li $v0, 10
	syscall

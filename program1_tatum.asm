#CS 2640.02

#Author: Laila Tatum
#Date: 10/31/25
#Description:
	#Task 1.) ask the user for two integer values, save them into $s0 and $s1, print the values to the user
	#Task 2.) perform the add, sub, mul, and div arithmetic operation instructions on the values in $s0 and $s1, then print the results
	#Task 3.)
		#if the user inputs are the same value, print "User inputs are the same"
		#if the inputs aren't equal, print "User inputs are different"

.data
prompt: .asciiz "Enter an integer: "
result: .asciiz "The result is "
diffVal: .asciiz "User inputs are different"
sameVal: .asciiz "User inputs are the same"
newLine: .asciiz "\n"
spacer: .asciiz " "

.text
main:
	#ask the user for the first integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the first integer from the user
	li $v0, 5	#read the first integer from user input
	syscall
	move $s0, $v0	#save first integer in $s0
	
	#ask the user for the second integer
	li $v0, 4	#print a string
	la $a0, prompt	#string specified as 'prompt'
	syscall
	
	#get the second integer from the user
	li $v0, 5	#read the second integer from user input
	syscall
	move $s1, $v0	#save second integer in $s1
	
	#print the integers to the user
	li $v0, 1	#print an integer
	move $a0, $s0	#print the first integer from $s0
	syscall
	
	li $v0, 4	#print a string
	la $a0, spacer	#string is specified as 'spacer'
	syscall
	
	li $v0, 1	#print an integer
	move $a0, $s1	#print the second integer from $s1
	syscall
	
	li $v0, 4	#print a string
	la $a0, newLine	#string is specified as 'newLine'
	syscall
	
	#add $s0 and $s1 and save the sum in $t0
	add $t0, $s0, $s1
	
	#print the sum of $s0 and $s1
	jal printResult
	
	#subtract $s0 and $s1 and save the difference in $t0
	sub $t0, $s0, $s1
	
	#print the difference of $s0 and $s1
	jal printResult
	
	#multiply $s0 and $s1 and save the product in $t0
	mul $t0, $s0, $s1
	
	#print the product of $s0 and $s1
	jal printResult
	
	#divide $s0 and $s1 and save the quotient in $t0
	div $t0, $s0, $s1
	
	#print the quotient of $s0 and $s1
	jal printResult
	
	#if the user values are equal, print that they're the same
	beq $s0, $s1, equalTo
	
	#if the user values aren't equal, print that they're different
	bne $s1, $s0, notEqual
	
printResult:
	li $v0, 4	#print a string
	la $a0, result	#string specified as 'result'
	syscall
	
	li $v0, 1	#print an integer
	move $a0, $t0	#print the sum in $t0
	syscall
	
	li $v0, 4	#print a string
	la $a0, newLine	#string is specified as 'newLine'
	syscall
	
	#returns to the main label after printing result and continue running through the program
	jr $ra
	
equalTo:
	li $v0, 4	#print a string
	la $a0, sameVal	#string is specified as 'sameVal'
	syscall
	
	j exit #exit the program after printing sameVal
	
notEqual:
	li $v0, 4	#print a string
	la $a0, diffVal	#string is specified as 'diffVal'
	syscall
	
exit:
	#exit program
	li $v0, 10
	syscall
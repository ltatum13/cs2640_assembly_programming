#CS 2640.02

#Author: Laila Tatum
#Date: 11/5/2025
#Description:
	#1.) define a macro to get the next element of the array
	#2.) store the value into a register
	#3.) save it to memory

#use a macro to get the last element
.macro get_element(%array)
	lw $t1, %array + 8
	addi $t1, $t1, 1
	sw $t1, %array + 12
.end_macro

.data
last_element: .asciiz "The last element is "
next_element: .asciiz "The next element is "
arr1: .word 1, 2, 3

.text
main:
	li $v0, 4		#print a string
	la $a0, last_element	#specify the string as 'last element'
	syscall
	
	li $v0, 1		#print an integer
	lw $a0, arr1 + 8	#specify the integer as 
	syscall
	
	li $v0, 4
	la $a0, next_element
	syscall
	
	get_element(arr1)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	#exit program
	li $v0, 10
	syscall

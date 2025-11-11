#CS 2640.02

#Author: Laila Tatum
#Date: 10/27/25
#Description: given the array:
	#1.) print out the elements to the user
	#2.) use a loop to traverse through the array
	
.data
array: .word 1, 2, 3, 4, 5
message: .asciiz "Array values: "
spacer: .asciiz " "
arraySize: .word 5

.text
main:
	#print the array values to user
	li $v0, 4	#syscall register ready to print string
	la $a0, message #specify arrayVal as string to print
	syscall
	
	#load address of the array into $s0 and array size into $t1
	la $s0, array
	lw $t1, arraySize	#load array size
	li $t2, 0		#start counter
	
	#jump to loop label
	j loop

loop:
	#if the counter hits the array length, exit the program
	bge $t2, $t1, exit
	
	#use $t0 for the current array element
	li $v0, 1	#syscall register ready to print array[i]
	lw $t0, 0($s0)	#array[0]
	move $a0, $t0	#specify the integer to print
	syscall
	
	#print a comma and space between numbers
	li $v0, 4	#priming the syscall regsiter to print a string
	la $a0, spacer	#specify the string
	syscall
	
	#traverse through the array
	addi $s0, $s0, 4	#increment to the next element
	addi $t2, $t2, 1	#increment the loop counter by 1
	j loop

exit:
	#exit program
	li $v0, 10
	syscall

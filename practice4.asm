#CS 2640.02

#Author: Laila Tatum
#Date: 10/27/25
#Description: given the array:
	#1.) add the values seperately
	#2.) add all three together
	#3.) output the values one at a time and display the operation details
	

.data
array: .word 3, 4, 5
arrayVal: .asciiz "Array values: "
commaSpace: .asciiz ", "
newLine: .asciiz "\n"


.text
main:
	#print the array values to user
	li $v0, 4	#syscall register ready to print string
	la $a0, arrayVal #specify arrayVal; as string to print
	syscall
	
	la $s0, array	#load address of the array into $s0
	
	li $v0, 1	#syscall register ready to print array[0]
	lw $a0, 0($s0)
	syscall
	
	#print a comma and space between numbers
	li $v0, 4
	la $a0, commaSpace
	syscall
	
	li $v0, 1
	lw $a0, 4($s0) #syscall register ready to print array[1]
	syscall
	
	#print a comma and space between numbers
	li $v0, 4
	la $a0, commaSpace
	syscall
	
	li $v0, 1
	lw $a0, 8($s0) #syscall register ready to print array[2]
	syscall
	
	#load elements into temporary registers ($t0, $t1, $t2)
	lw $t0, 0($s0)		#save array[0] = 3 into $t0
	lw $t1, 4($s0)		#save array[1] = 4 into $t1
	lw $t2, 8($s0)		#save array[2] = 5 into $t2
	
	#print the newline after the output
	li $v0, 4	#syscall register ready to print string
	la $a0, newLine #specify string to print
	syscall
	
	#add two values (3+4)
	add $t3, $t0, $t1	#add 3+4
	 
	#add two values (3+5)
	add $t4, $t0, $t2	#add 3+5
	
	#add two values (4+5)
	add $t5, $t1, $t2	#add 3+5
	
	#add all three values together (3+4+5)
	
	#output 3+4 to the user
	li $v0, 1
	move $a0, $t3
	syscall
	
	#print the newline after the output
	li $v0, 4	#syscall register ready to print string
	la $a0, newLine #specify string to print
	syscall
	
	#output 3+5 to the user
	li $v0, 1
	move $a0, $t4
	syscall
	
	#print the newline after the output
	li $v0, 4	#syscall register ready to print string
	la $a0, newLine #specify string to print
	syscall
	
	#output 3+4+5 to the user
	li $v0, 1
	move $a0, $t5
	syscall
	
	#exit the program
	li $v0, 10
	syscall

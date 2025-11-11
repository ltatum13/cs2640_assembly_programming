#assignment prompt, the goals of the program

#Author: Laila Tatum
#Date: 10/25/2025
#Description: takes two parameters (int and string), doubles the int, calls another macro to print the string

.macro printString(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

.macro getInput(%int, %string)
	li $v0, 5
	la $a0
	
	li $v0, 8
	la $a0, buffer
	li $a1, 11
.end_macro

.data
buffer: .space 11

.text
main:
	li $v0, 10
	syscall

#CS 2640.02
#task 1: write an Assembly program that will return a letter grade given a decimal integer from the user
	#include a user menu, a main/loop/exit label, a way for the user to continue getting letter grades or choose to exit
	#invalid input handling that re-prompts the user until the correct input is entered
	#note: anything above 100 counts and anything below 0 doesn't count

#Author: Laila Tatum
#Date: 11/10/2025
#Description: create a program that:
	#1.) provides the user with a menu prompt to (1) get a letter grade or (2) exit the program
	#2.) continues to ask the user if they want more letter grades until the decide to exit the program
	#3.) continues to re-prompt the user to enter valid entries if they enter an invalid entry

.data
#menus and prompts for user to input
menu: .asciiz "\n\n~~~~~~~~~~~~~~~ MAIN MENU ~~~~~~~~~~~~~~~\n(1) Get a Letter Grade\n(2) Exit the Program\n"
menuPrompt: .asciiz "\nEnter 1 or 2 for your selection: "
scorePrompt: .asciiz "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nPlease enter a score as an integer value: "
againPrompt: .asciiz "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\nWould you like to enter a new score?\n(Y)Yes\t(N)No\n\nEnter 'Y' or 'N' for your selection: "

#formatting for letter grade output
letterGrade: .asciiz "\nThe grade is: "
letterA: .asciiz "A"
letterB: .asciiz "B"
letterC: .asciiz "C"
letterD: .asciiz "D"
letterF: .asciiz "F"

#exit prompt
exitPrompt: .asciiz "\nThe program will now exit."

.text
main:
	#print the menu and prompt for the user
	li $v0, 4		#print a string
	la $a0, menu	#specify the string as 'menu'
	syscall
	
	la $a0, menuPrompt	#print the 'menuPrompt' string
	syscall
	
	#read the integer that the user inputs
	li $v0, 5		#read an integer
	syscall
	move $t0, $v0	#save the option number to $t0 
	
	#if the user enters 1, jump to the grader loop label
	beq $t0, 1, grader
	
	#if the user enters 2, jump to the exit labal
	beq $t0, 2, exit
	
	#if the user enters an integer that's not (1) or (2),
	#  prompt the user until they enter a valid integer
	blt $t0, 1, main
	bgt $t0, 2, main
	
grader:
	#ask the user for an integer value score
	li $v0, 4				#print a string
	la $a0, scorePrompt		#specify the string as 'scorePrompt'
	syscall
	
	#get the numeric score from user input
	li $v0, 5		#read an integer
	syscall
	move $t1, $v0	#save the score to $t1

	#if the user enters an integer less than 0, prompt the user until they
	#  enter a valid integer score
	blt $t1, 0, looping
	
	#otherwise, determine the final letter grade based on the score
	li $v0, 4				#print a string
	la $a0, letterGrade		#specify the string as 'letterGrade'
	syscall
	
	bge $t1, 90, gradeA		#A: +90
	bge $t1, 80, gradeB		#B: 89 - 80
	bge $t1, 70, gradeC		#C: 79 - 70
	bge $t1, 60, gradeD		#D: 69 - 60
	bge $t1, 0, gradeF		#F: 59 - 0
	
	#output the letter grade to the user
	gradeA:
		li $v0, 4			#print a string
		la $a0, letterA		#print the letter grade 'A'
		syscall
		
		j promptUser		#jump to the promptUser label
		
	gradeB:
		li $v0, 4			#print a string
		la $a0, letterB		#print the letter grade 'B'
		syscall
		
		j promptUser		#jump to the promptUser label
		
	gradeC:
		li $v0, 4			#print a string
		la $a0, letterC		#print the letter grade 'C'
		syscall
		
		j promptUser		#jump to the promptUser label
		
	gradeD:
		li $v0, 4			#print a string
		la $a0, letterD		#print the letter grade 'D'
		syscall
		
		j promptUser		#jump to the promptUser label
		
	gradeF:
		li $v0, 4			#print a string
		la $a0, letterF		#print the letter grade 'F'
		syscall
		
		j promptUser		#jump to the promptUser label
	
	promptUser:
		#ask the user if they want to get another letter grade
		li $v0, 4				#print a string
		la $a0, againPrompt		#specify string as 'againPrompt'
		syscall
		
		#get the integer option from user input
		li $v0, 12			#read a character
		syscall
		move $t2, $v0		#save the character option to $t2
	
		#if they select (Y), run through the grader loop again
		beq $t2, 'Y', grader
		beq $t2, 'y', grader
	
		#if they select (N), return them to the main label
		beq $t2, 'N', main
		beq $t2, 'n', main
		
		#if the user inputs something that's not (Y) or (N),
		#  prompt the user until they enter either (Y) or (N)
		bne $t2, 'Y', promptUser
		bne $t2, 'y', promptUser
		bne $t2, 'N', promptUser
		bne $t2, 'n', promptUser

exit:
	#print the exit prompt to the user
	li $v0, 4			#print a string
	la $a0, exitPrompt	#specify the string as 'exitPrompt'
	syscall
	
	#exit the program
	li $v0, 10
	syscall
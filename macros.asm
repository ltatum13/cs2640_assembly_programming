#save macros here

#macro that takes a programmer defined string to print 3 times
.macro printString(%string, %loopCount)
	.data
	aString: .asciiz %string	#makes it easy to put a string directly as the argument
	
	.text
	li $t0, 0			#loop counter
	li $t1, %loopCount		#how many times the loop should run

	loop:
		li $v0, 4		#print a string
		la $a0, aString		#specify the string as string parameter
		syscall
	
		addi $t0, $t0, 1	#increment the loop by 1
		beq $t0, $t1, exit	#stop when loop counter ($t0) hits the max loop count ($t1)
	
		j loop			#loops back through
.end_macro
###############################################################################
# Bruce Adams, CS 2318-251, Assignment 2 Part 1 Program A
# Prompt the user to enter each of the following:
# an integer, a string of up to 40 characters long
# and a character.
# Program reads the user's input, and displays 
# a labeled output about the user's input.
###############################################################################

		.data
eaiMsg:		.asciiz	"Enter integer : "	# label for entering integer
intLab:		.asciiz "Integer is : "		# label for displaying integer
easMsg:		.asciiz "Enter a string : "	# label for entering string
strLab:		.asciiz "String is : "		# label for displaying string
eacMsg:		.asciiz "Enter a  character : "	# label for entering a char
charLab:	.asciiz "Character is : "	# label for displaying a char
buffer:		.space 41			# space for 40 bytes buffer size
						# use 41 to read up to 40 max
		.text
		.globl main
main:

		li $v0, 11			# start with a new line
		li $a0, '\n'			
		syscall
###############################################################################
# Get integer input and display integer

		la $a0, eaiMsg			# load address of eaiMsg in $a0
		li $v0, 4			# display "Enter integer : "
		syscall
		
		li $v0, 5			# read integer from console
		syscall	
		
		move $t7, $v0			# move $v0 into $t7
		
		la $a0, intLab			# load address of intLab in $a0
		li $v0, 4			# displays "Integer is : "
		syscall
		
		li $v0, 1			# syscall 1, print integer
		move $a0, $t7			# move value from $t7 to $a0
		syscall
		
###############################################################################
# Get string input and display string (up to 40 characters)

		
		li $v0, 11			# create a new line
		li $a0, '\n'			
		syscall
		
		la $a0, easMsg			# put easMsg in $a0
		li $v0, 4			# display "Enter a string : "
		syscall	
		
		li $v0, 8			# read string input from console
		
		la $a0, buffer			# load byte space into address
		li $a1, 41			# allocate byte space for string
						# 41 to allow 40 bytes (max)
		
		move $t0, $a0			# save string to $t0	
		syscall
		
		la $a0, strLab			# address of string strLab
		li $v0, 4			# load and print "String is : "		
		syscall
		
		la $a0, buffer			# reload the buffer address
		move $a0, $t0			# move buffer string back to $a0
		li $v0, 4			# display user entered string
		syscall	

###############################################################################
# Get a character input from the user and display it
		
		la $a0, eacMsg			# put address of eacMsg in $a0
		li $v0, 4			# display "Enter a character : "
		syscall
			
		li $v0, 12			# load call read_char into $v0
		syscall	
		move $t1, $v0			# put $v0 into $t1
		
		li $v0, 11			# create a new line
		li $a0, '\n'			
		syscall
			
		li $v0, 4			# syscall 4, address of string
		la $a0, charLab			# display "Character is : "
		syscall
		
		move $a0, $t1			# move value from $t1 to $a0
		li $v0, 11			# load and print character

		syscall
				
###############################################################################
# Terminate the program	

		li $v0, 10			# exit the program
		syscall
		
		

################################################################################
# Bruce Adams, CS 2318-251, Assignment 2 Part 1 Program C
#
# Allocate a global array (i.e., space in the data segment) enough for storing 
# 4 integers and initialize the array (from 1st to 4th element) with 2, 3, 1 
# and 8 at the same time.
# Display a labeled output about the array's initial contents (from 1st to 4th)
# Re-order the values in the array so that the contents of the array in memory 
# (from 1st to 4th element) becomes 8, 1, 3 and 2, using the following 
# operations (in order)
# Swap the contents in memory of the 1st and 4th elements of the array.
# Swap the contents in memory of the 2nd and 3rd elements of the array.
################################################################################

	.data					# begin data segment
arrLab:	.asciiz "Array initial content: "	# label for displaying array
swArr:	.asciiz "Swapped array content: "	# label for swapped array
aSize:	.word 4					# space for 4 integer array
						
intArr:	.word 2, 3, 1, 8			# initialize array 
						# each word is 4 bytes
						
	.text					# begin text segment
	.globl main				# declare main as global
main:
	li $v0, 11				# start with a new line
	li $a0, '\n'			
	syscall
	
###############################################################################
# Display initial integer array

	la $a0, arrLab				# load address of arrLab in $a0
	li $v0, 4				# display Array initial content
	syscall
	
	la $t0, intArr				# load address of array
	lw $t1, 0($t0)				# load element 1
	lw $t2, 4($t0)				# load element 2
	lw $t3, 8($t0)				# load element 3
	lw $t4, 12($t0)				# load element 4
			
	li $v0, 1
	move $a0, $t1				# print element 1
	syscall
	move $a0, $t2				# print element 2
	syscall
	move $a0, $t3				# print element 3
	syscall
	move $a0, $t4				# print element 4
	syscall
			
###############################################################################
# Swap array numbers and then display swapped integer array

	sw $t4, 0($t0)				# swap element 1 w/ 4 
	sw $t1, 12($t0)				# swap element 4 w/ 1
	sw $t2, 8($t0)				# swap element 2 w/ 3
	sw $t3, 4($t0)				# swap element 3 w/ 2

	li $v0, 11				# make a new line
	li $a0, '\n'
	syscall

	la $a0, swArr				# load address of swArr in $a0
	li $v0, 4				# display "Swapped arrray content"
	syscall
	
	li $v0, 1				# syscall print integers
	lw $a0, 0($t0)				# print element 1
	syscall
	lw $a0, 4($t0)				# print element 2
	syscall	
	lw $a0, 8($t0)				# print element 3
	syscall
	lw $a0, 12($t0)				# print element 5
	syscall	

	li $v0, 11				# make a new line
	li $a0, '\n'
	syscall	
				
###############################################################################
# Terminate the program	

	li $v0, 10				# exit the program
	syscall
		
		

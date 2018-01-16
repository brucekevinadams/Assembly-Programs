###############################################################################			
# Bruce Adams, CS 2318-251, Assignment 2 Part 1 Program D			
# Prompt the user to enter the integer scores for Exam 1, Exam 2 and Final			
# Exam, read the scores, compute the weighted average score  			
# and display a labeled output about the weighted average score.			
###############################################################################			
			
	.data		
ex1Msg:	.asciiz	"Enter Exam 1 score : " 	# label for entering Exam 1
ex2Msg:	.asciiz	"Enter Exam 2 score : " 	# label for entering Exam 2
ex3Msg:	.asciiz	"Enter Final Exam score : " 	# label for entering Final
finMsg:	.asciiz	"Weighted average score : " 	# label for Average
			
	.text		
	.globl main		
main:			
			
	li $v0, 11				# start with a new line	
	li $a0, '\n'		
	syscall		
###############################################################################			
# Get Exam scores and peform multiplication and division to get average score			
			
	la $a0, ex1Msg				# load address of ex1Msg in $a0	
	li $v0, 4				# Enter Exam 1 score : 	
	syscall		
			
	li $v0, 5				# read Exam 1 score from console	
	syscall		
			
	move $t1, $v0				# $t1 has Exam 1 score	
			
	la $a0, ex2Msg				# load address of ex2Msg in $a0	
	li $v0, 4				# Enter Exam 2 score : 	
	syscall		
			
	li $v0, 5				# read Exam 2 score from console	
	syscall		
			
	move $t2, $v0				# $t2 has Exam 2 score	
			
	la $a0, ex3Msg				# load address of ex3Msg in $a0	
	li $v0, 4				# Enter Final Exam score : 	
	syscall		
			
	li $v0, 5				# read Final score from console	
	syscall		
			
	move $t3, $v0				# $t3 has Final score	
			
	li $t4, 205				# $t4 has 205	
	mult $t1, $t4				# Lo has Exam1 Score * 205	
	mflo $t9				# $t9 has E1 * 205	
	srl $t9, $t9, 10			# $t9 has E1 * 205 / 1024	
	sll $t2, $t2, 8				# $t2 has E2 * 256	
	li $t5, 854				# $t5 has 854	
	div $t2, $t5				# Lo has E2 * 256 / 854	
	mflo $t8				# $t8 has E2 * 256 / 854	
	add $t8, $t8, $t9			# $t8 has E1 avg + E2 avg	
	srl $t3, $t3, 1				# #t3 has Final / 2	
	add $t8, $t8, $t3			# $t8 has Average Score	
			
	la $a0, finMsg				# load address of finMsg in $a0	
	li $v0, 4				# Final weighted average is :	
	syscall		
			
	li $v0, 1				# syscall 1, print integer	
	move $a0, $t8				# Print average score	
	syscall		
			
###############################################################################			
# Terminate the program			
			
	li $v0, 10				# exit the program	
	syscall		

##########################################################################
# Bruce Adams, CS 2318-251, Assignment 2 Part 1 Program B
##########################################################################
# Checks if a user-entered int between 0 & 255 (inclusive) is less than 32
# & displays 0 if so, otherwise (32 or higher) displays 1
############################ data segment ################################
		.data
legend1:	.asciiz "0: less than 32\n"
legend2:	.asciiz "1: 32 or higher\n"
inPrompt:	.asciiz "Enter an integer between 0 and 255: "
outLab:		.asciiz "It is "
############################ code segment ################################		
		.text
		.globl main
main:
		li $v0, 4
		la $a0, legend1        
		syscall                   # print legend line 1
		la $a0, legend2        
		syscall                   # print legend line 2
		la $a0, inPrompt        
		syscall                   # print input prompt
		
		li $v0, 5
		syscall                   # read input integer

		##########################################################
		# Write NO MORE THAN 14 lines of code that involve using 
		# ONLY the following:
		# - syscall
		# - syscall supporting instructions (e.g.: li to load $v0)
		# - instruction to make a saved copy
		# - bit manipulating instructions (ANDing, ORing, XORing,
		#   NORing and shifting - only whatever that are needed)
		# so that the program will work just like the sample runs 
		# shown at the bottom.
		# You MUST test your completed program for AT LEAST the 
		# test cases shown (and include the result in hardcopy).
		##########################################################
		
		move $t0, $v0			# move integer value to $t0	
		
		srl $t1, $t0, 5			# shift right logical by 5 bits

		# if $t1 is 0, then number
		# entered is 31 or less, if $t1 is 1 or greater
		# then number is 32 or more

		andi $t4, $t1, 1
								
		la $a0, outLab			# load address of outLab in $a0
		li $v0, 4			# displays "It is : "
		syscall	
		
		li $v0, 1			# syscall 1, print integer
		move $a0, $t4			# move value from $t4 to $a0
		syscall
		
		li $v0, 11			# start with a new line
		li $a0, '\n'			
		syscall
		
		j main
		
		
		
		
		
		
		
		
		
		
		
		
		
                ##########################################################
                                
                li $v0, 10               # exit
                syscall

########################## sample test runs ##############################
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 0
# It is 0
# -- program is finished running --
# 
# 
# Reset: reset completed.
# 
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 31
# It is 0
# -- program is finished running --
# 
# 
# Reset: reset completed.
# 
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 32
# It is 1
# -- program is finished running --
# 
# 
# Reset: reset completed.
# 
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 64
# It is 1
# -- program is finished running --
# 
# 
# Reset: reset completed.
# 
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 128
# It is 1
# -- program is finished running --
# 
# 
# Reset: reset completed.
# 
# 0: less than 32
# 1: 32 or higher
# Enter an integer between 0 and 255: 255
# It is 1
# -- program is finished running --
######################## end sample test runs ############################

################################################################################
# MIPS assembly language translation of a contrived C++ program
# An example program illustrating:
# - MIPS basic support for doing functions (procedures)
# - pass-by-value versus pass-by-address
# NOTES:
# - does NOT follow function-call convention to be eventually covered/adopted
################################################################################
# Algorithm used:
# Given C++ program (TrivialFunc_PassingMechEg01.cpp)
################################################################################
# Sample test run:
##################
# times to run? 2
# vals per run? 4
# run #1:
# enter an int: 1
# enter an int: 2
# enter an int: 3
# enter an int: 4
# 4 ints: 1 2 3 4 
# run #2:
# enter an int: 4
# enter an int: 3
# enter an int: 2
# enter an int: 1
# 4 ints: 4 3 2 1 
################################################################################
					.text
					.globl main
################################################################################
main:					
#################
# Register Usage:
#################
# $t0: register holder for a value
# $t1: i
# $t2: j
#################
					addiu $sp, $sp, -87
					li $t0, ' '
					sb $t0, 0($sp)
					sb $t0, 6($sp)
					sb $t0, 13($sp)
					sb $t0, 16($sp)
					sb $t0, 21($sp)
					sb $t0, 26($sp)
					sb $t0, 33($sp)
					sb $t0, 37($sp)
					sb $t0, 42($sp)
					sb $t0, 49($sp)
					sb $t0, 52($sp)
					sb $t0, 57($sp)
					li $t0, 'i'
					sb $t0, 1($sp)
					sb $t0, 17($sp)
					sb $t0, 45($sp)
					li $t0, 'n'
					sb $t0, 2($sp)
					sb $t0, 9($sp)
					sb $t0, 15($sp)
					sb $t0, 18($sp)
					sb $t0, 25($sp)
					sb $t0, 40($sp)
					sb $t0, 55($sp)
					li $t0, 't'
					sb $t0, 3($sp)
					sb $t0, 10($sp)
					sb $t0, 19($sp)
					sb $t0, 44($sp)
					sb $t0, 50($sp)
					li $t0, 's'
					sb $t0, 4($sp)
					sb $t0, 32($sp)
					sb $t0, 48($sp)
					li $t0, ':'
					sb $t0, 5($sp)
					sb $t0, 20($sp)
					li $t0, '\0'
					sb $t0, 7($sp)
					sb $t0, 22($sp)
					sb $t0, 28($sp)
					sb $t0, 43($sp)
					sb $t0, 58($sp)
					li $t0, 'e'
					sb $t0, 8($sp)
					sb $t0, 11($sp)
					sb $t0, 35($sp)
					sb $t0, 47($sp)
					li $t0, 'r'
					sb $t0, 12($sp)
					sb $t0, 23($sp)
					sb $t0, 36($sp)
					sb $t0, 38($sp)
					sb $t0, 53($sp)
					li $t0, 'a'
					sb $t0, 14($sp)
					sb $t0, 30($sp)
					li $t0, 'u'
					sb $t0, 24($sp)
					sb $t0, 39($sp)
					sb $t0, 54($sp)
					li $t0, '#'
					sb $t0, 27($sp)
					li $t0, 'v'
					sb $t0, 29($sp)
					li $t0, 'l'
					sb $t0, 31($sp)
					li $t0, 'p'
					sb $t0, 34($sp)
					li $t0, '?'
					sb $t0, 41($sp)
					sb $t0, 56($sp)
					li $t0, 'm'
					sb $t0, 46($sp)
					li $t0, 'o'
					sb $t0, 51($sp)
					
					addi $a0, $sp, 44
					jal GetOneIntByVal
					sw $v0, 63($sp)

					addi $a0, $sp, 59
					addi $a1, $sp, 29
					jal GetOneIntByAddr
					
					addi $a0, $sp, 63
					addi $a1, $sp, 59
					li $a2, 3
					li $a3, 5
					jal ChkAdjIntInputs
					
					lw $t1, 63($sp)				# $t1 is i
					j FTest1
begFBody1:					
					addi $a0, $sp, 23
					lw $a1, 63($sp)
					sub $a1, $a1, $t1
					addi $a1, $a1, 1
					jal prtRunLabel
					
					lw $t2, 59($sp)
					j FTest2
begFBody2:					
					lw $a0, 59($sp)
					sub $a0, $a0, $t2
					sll $a0, $a0, 2
					addi $a0, $a0, 67
					add $a0, $a0, $sp
					addi $a1, $sp, 8
					jal GetOneIntByAddr
         
					addi $t2, $t2, -1
FTest2:
					bgtz $t2, begFBody2         
					
					move $a0, $sp
					lw $a1, 59($sp)
					jal prtOutLabel
					
					addi $a0, $sp, 67
					lw $a1, 59($sp)
					jal prtIntArr
      
					addi $t1, $t1, -1
FTest1:
					bgtz $t1, begFBody1
   
					addiu $sp, $sp, 87
					li $v0, 10
					syscall
					
################################################################################
GetOneIntByVal:
					li $v0, 4
					syscall
					
					li $v0, 5
					syscall

					jr $ra

################################################################################
GetOneIntByAddr:
#################
# Register Usage:
#################
# $t0: holder for saving 1st arg ($a0) received
#################
					move $t0, $a0			# save intVarToPutInPtr in $t0
					
					move $a0, $a1
					li $v0, 4
					syscall
					
					li $v0, 5
					syscall
					sw $v0, 0($t0)
					
					jr $ra

################################################################################
ChkAdjIntInputs:
#################
# Register Usage:
#################
# $t0: holder for a value loaded from memory
# $v1: holder constant 1
#################
					li $v1, 1				# $v1 has constant 1
					
					lw $t0, 0($a0)			# $t0 has *int1Ptr
					bge $t0, $v1, endIf1
					sw $v1, 0($a0)
endIf1:

					ble $t0, $a2, endIf2
					sw $a2, 0($a0)
endIf2:

					lw $t0, 0($a1)			# $t0 has *int2Ptr
					bge $t0, $v1, endIf3
					sw $v1, 0($a1)
endIf3:

					ble $t0, $a3, endIf4
					sw $a3, 0($a1)
endIf4:

					jr $ra

################################################################################
prtRunLabel:
					li $v0, 4
					syscall
					move $a0, $a1
					li $v0, 1
					syscall					
					li $a0, ':'
					li $v0, 11
					syscall
					li $a0, '\n'
					syscall

					jr $ra

################################################################################
prtOutLabel:
#################
# Register Usage:
#################
# $t0: holder for saving 1st arg ($a0) received
#################
					move $t0, $a0			# save &runOutLab[0] in $t0
					
					move $a0, $a1
					li $v0, 1
					syscall
					move $a0, $t0
					li $v0, 4
					syscall

					jr $ra

################################################################################
prtIntArr:
#################
# Register Usage:
#################
# $a2: i
# $a3: holder for building target address in memory
# $t0: holder for saving 1st arg ($a0) received
# $v1: holder for constant 1
#################
					move $t0, $a0			# save &intArr[0] in $t0
					
					move $a2, $a1			# $a2 is i
					#move $t1, $a1			# $t1 is i
					li $v1, 1				# $v1 has constant 1
					j WTest
begWBody:					
					sub $a3, $a1, $a2		# $a3 has size - i
					#sub $a3, $a1, $t1		# $a3 has size - i
					sll $a3, $a3, 2			# $a3 has (size - i)*4
					add $a3, $a3, $t0		# $a3 has &intArr[size - i]
					lw $a0, 0($a3)			# $a0 has intArr[size - 1]
					li $v0, 1
					syscall
					li $v0, 11
					li $a0, ' '
					syscall
					
					addi $a2, $a2, -1
WTest:
					bge $a2, $v1, begWBody
					
					li $v0, 11
					li $a0, '\n'
					syscall

					jr $ra
################################################################################

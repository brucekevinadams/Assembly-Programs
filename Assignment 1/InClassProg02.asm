#################################################
# CS-2318 in-class demo program 02
#################################################
			.data
oneChar:		.byte 'K'
charArr:		.byte 'A', 'B', 'C'
oneInt:			.word -31
intArr:			.word 123, 234, 456
			.text
			.globl main
main:
			la $t0, oneChar
			li $v0, 11
			lb $a0, 0($t0)
			syscall
			ori $a0, $a0, 0x20
			#xori $a0, $a0, 0x20
			syscall
			
			sb $a0, 0($t0)
			lb $a0, 0($t0)
			syscall
			andi $a0, $a0, 0xDF
			syscall
			xori $a0, $a0, 0x20
			syscall

			li $v0, 11
			li $a0, '\n'
			syscall
			
			la $t0, charArr
			lb $a0, 0($t0)
			syscall
			lb $a0, 1($t0)
			syscall
			lb $a0, 2($t0)
			syscall
			li $a0, '\n'
			syscall
			lb $t1, 0($t0)
			lb $t3, 2($t0)
			#sb $t3, 0($t0)
			#sb $t1, 2($t0)
			sb $t1, 2($t0)
			sb $t3, 0($t0)
			li $v0, 11
			lb $a0, 0($t0)
			syscall
			lb $a0, 1($t0)
			syscall
			lb $a0, 2($t0)
			syscall
			li $a0, '\n'
			syscall

			###################################
			
			la $t0, oneInt
			li $v0, 1
			lw $a0, 0($t0)
			syscall
			sll $a0, $a0, 2
			syscall
			srl $a0, $a0, 2
			#sra $a0, $a0, 2
			syscall

			li $v0, 11
			li $a0, '\n'
			syscall
									
			la $t0, intArr
			lw $t1, 0($t0)
			#lw $t3, 2($t0)
			lw $t3, 8($t0)
			
			li $v0, 1
			move $a0, $t1
			syscall
			move $a0, $t3
			syscall
			
			sw $t3, 0($t0)
			sw $t1, 8($t0)

			li $v0, 11
			li $a0, '\n'
			syscall

			li $v0, 1
			lw $a0, 0($t0)
			syscall
			lw $a0, 8($t0)
			syscall			
			
			li $v0, 10	# graceful exit service
			syscall
#################################################
						
			

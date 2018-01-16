###############################################################################
# Title: Assign02P3                   Author: Bruce Adams
# Class: CS 2318-25?, Spring 2017     Submitted: April 3, 2017
###############################################################################
# Program: MIPS tranlation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################

#include <iostream>
#using namespace std;

			.data
iArr1:			.space 80
iArr2:			.space 80
iArr3:			.space 80
colSpace:		.asciiz ": "
begA1Str:		.asciiz "\nbeginning a1: "
proA1Str:		.asciiz "processed a1: " 
proA2Str:		.asciiz "          a2: " 
proA3Str:		.asciiz "          a3: "
einStr:			.asciiz "\nEnter integer #"
moStr:			.asciiz "Max of "
ieStr:			.asciiz " ints entered..."
emiStr:			.asciiz "Enter more ints? (n or N = no, others = yes) "
dacStr: 		.asciiz "Do another case? (n or N = no, others = yes) "
d1Str:			.asciiz "================================"
byeStr:			.asciiz "bye..."

#int main()
#{
			.text
			.globl main
main:

################################################ 
# Register usage: 
################################################ 
# $a1: endPtr1 
# $a2: endPtr2 
# $a3: endPtr3 
# $t0: temp holder 
# $t1: used1 
# $t2: used2 
# $t3: used3 
# $t4: hopPtr1 
# $t5: hopPtr2 or remCount (non-overlappingly) 
# $t6: hopPtr11 or hopPtr22 (non-overlappingly) 
# $t7: hopPtr3 or hopPtr222 (non-overlappingly) 
# $t8: reply or anchor (non-overlappingly) 
# $t9: temp holder 
# $v1: temp holder  
################################################

#//           do
begDW1:#//   {
#		used1 = 0;
		li $t1, 0			#used1 = 0
         
#		hopPtr1 = a1;
		la $t4, iArr1			#Set address of hopPtr1 to iArr1
#//              do
begDW2:#//      {
#               cout << einStr;
		li $v0, 4
		la $a0, einStr			#Print "Enter integer #"
		syscall
#		cout << (used1 + 1);
		li $v0, 1
		addi $a0, $t1, 1		#add 1 to used1
		syscall
#               cout << ':' << ' ';
		li $v0, 4
		la $a0, colSpace		#Print a : 
		syscall
#               cin >> *hopPtr1;
		li $v0, 5			#Prepare integer input on console
		syscall
		sw $v0, 0($t4)			#Input integer on console	
#                  ++used1;
		addi $t1, $t1, 1		#Add 1 to used1
#                   ++hopPtr1;
                addi $t4, $t4, 4		#Add 4 because hopPtr1 is pointer
#//                 if (used1 == 12)
#                   if (used1 != 12) goto else1;
		li $t9, 12			#add 12 to temp $t9
		bne $t1, $t9, else1		#if (used1 != 12) goto else1
begI1:#//      {
#                     cout << moStr;
		li $v0, 4
		la $a0, moStr			#Print "Max of "
		syscall
#                     cout << 12;
		li $v0, 1			#Set up integer to print
		li $a0, 12			#Print a 12
		syscall				
#                    cout << ieStr;
		li $v0, 4
		la $a0, ieStr			#Print " ints entered..."
		syscall
#                     cout << endl;
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall
#                      reply = 'n';
		li $t0, 'n'			#Add 12 to temp $t0
		move $t8, $t0			#Reply = 'n'
#                  goto endI1;
		j endI1				#jump to endI1
#//                 }
else1:
#//           else
#//                {
#                     cout << emiStr;
		li $v0, 4
		la $a0, emiStr			#Print Enter more ints? (n or N = no, others = yes)
		syscall
#		      cin >> reply;
		li $v0, 12			#Prepare to enter character
		syscall
		move $t8, $v0			#Enter character on console, put in reply
endI1:
#//           }
#//              }
DWTest2:
#//             while (reply != 'n' && reply != 'N');
#////           if (reply != 'n' && reply != 'N')goto begDW2;
#               if (reply == 'n') goto xitDW2;
		li $t0, 'n'
		beq $t8, $t0, xitDW2
#                if (reply != 'N')goto begDW2;
		li $t0, 'N'
		bne $t8, $t0, begDW2
xitDW2:
#               cout << begA1Str;
		li $v0, 4
		la $a0, begA1Str		#Print "beginning a1:"
		syscall		
		
#               hopPtr1 = a1;
		la $t4, iArr1			#Set address of iArr1 into hopPtr1 ($t4)

#               endPtr1 = a1 + used1;
		la $a1, iArr1			#Set address of iArr1 into endPtr1($a1)
		sll $t0, $t1, 2			#Set up used1
		add $a1, $a1, $t0   		#endPtr1($a1) =  hopPtr1($t4) + used1($t1)
            
#//              while (hopPtr1 < endPtr1)
#                goto WTest1;
		j WTest1			#jump to WTest1
begW1:#//       {
#//             if (hopPtr1 == endPtr1 - 1) 
#		if (hopPtr1 != endPtr1 - 1) goto else2;
		addi $t0, $a1, -4	
		bne $t4, $t0, else2
begI2:#//           {
#                     cout << *hopPtr1 << endl;
		li $v0, 1
		lw $a0, 0($t4)			#Print hopPtr1
		syscall	
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall
#                  goto endI2;
		j endI2				#jump to endI2
#//                 }
else2:
#//           else
#//                 {
#                      cout << *hopPtr1 << ' ';
		li $v0, 1
		lw $a0, 0($t4)			#Print hopPtr1
		syscall
		li $v0, 11			#Set up space character
		li $a0, 32			#Print character space
		syscall
endI2:#//           }
#                   ++hopPtr1;
		addi $t4, $t4, 4		#Add 1 to hopPtr1
#//              }
WTest1:
#               if (hopPtr1 < endPtr1) goto begW1;
		blt $t4, $a1, begW1

#//              for (hopPtr1 = a1, hopPtr2 = a2, used2 = 0; // multiple initializations
#//                   hopPtr1 < endPtr1;                     // loop test
#//                   ++hopPtr1, ++hopPtr2, ++used2)         // multiple updates

#                hopPtr1 = a1;
		la $t4, iArr1			# Set address of hopPtr1 to iArr1
#                hopPtr2 = a2;
		la $t5, iArr2			# Set address of hopPtr2 to iArr2
#                used2 = 0; // multiple initializations
		li $t2, 0			# used2 = 0

#                goto FTest1;
		j FTest1			# Jump to FTest1
begF1:#//        {
#                  *hopPtr2 = *hopPtr1;
		lw $t0, 0($t4)			# hopPtr1
		sw $t0, 0($t5)			# hopPtr2
#               ++hopPtr1;
		addi $t4, $t4, 4		# Add 1 to hopPtr1
#               ++hopPtr2;
		addi $t5, $t5, 4		# Add 1 to hopPtr2
#                ++used2;         // multiple updates
		addi $t2, $t2, 1		# Add 1 to used2
#//              }
FTest1:
#               if (hopPtr1 < endPtr1) goto begF1;                     // loop test
		blt $t4, $a1, begF1

#               hopPtr2 = a2;
		la $t5, iArr2			# Set address of hopPtr2 to iArr2
#                endPtr2 = a2 + used2;
		la $a2, iArr2
		sll $t9, $t2, 2			# used2 * 4, store in temp $t0
		add $a2, $a2, $t9   		# endPtr2($a2) =  hopPtr2($t5) + used2($t0)
#//              while (hopPtr2 < endPtr2)
#                goto WTest2;
		j WTest2			#Jump to WTest2
begW2:#//        {
#                   anchor = *hopPtr2;
		lw $t8, 0($t5)			#Store *hopPtr2($t5) in anchor($t8)
 
#//                 for (hopPtr22 = hopPtr2 + 1; hopPtr22 < endPtr2; ++hopPtr22)
#                   hopPtr22 = hopPtr2 + 1;
		addi $t6, $t5, 4		#hopPtr22($t6) = hopPtr2($t5) + 1
#                   goto FTest2;
		j FTest2
begF2:#//           {
#//                    if (*hopPtr22 == anchor)
#                      if (*hopPtr22 != anchor) goto endI3;
		lw $t0, 0($t6)			# Must load word (lw) *hopPtr22 ($t6) before
						# comparing with brance (bne operation)
		bne  $t0, $t8, endI3		#if (*hopPtr22($t6) != anchor($t8)
befI3:#//              {
#//                       for (hopPtr222 = hopPtr22 + 1; hopPtr222 < endPtr2; ++hopPtr222)
#                         hopPtr222 = hopPtr22 + 1;
		addi $t7, $t6, 4		#hopPtr222($t7) = hopPtr22($t6) + 1
#		goto FTest3;
		j FTest3			#Jump to FTest3
begF3:#//                 {
#                            *(hopPtr222 - 1) = *hopPtr222;
		lw $t0, 0($t7)			#*hopPtr222
		sw $t0, -4($t7)			#*(hopPtr222 - 1) = *hopPtr222
		
#                         ++hopPtr222;
		addi $t7, $t7, 4		#Add 1 to hopPtr222
#//                       }
FTest3:
#                        if (hopPtr222 < endPtr2) goto begF3;
		blt $t7, $a2, begF3		#if (hopPtr222 < endPtr2) goto begF3
#                        --used2;
		addi $t2, $t2, -1		#Subtract 1 from used2	
#                         --endPtr2;
		addi $a2, $a2, -4		#Subtract 1 from endPtr2
#                         --hopPtr22;
		addi $t6, $t6, -4		#Subtract 1 from hopPtr22
endI3:#//              }
#                   ++hopPtr22;
		addi $t6, $t6, 4		#Add 1 to hopPtr22
#//                 }
FTest2:
 #                  if (hopPtr22 < endPtr2) goto begF2;
 		blt $t6, $a2, begF2		# if (hopPtr22 < endPtr2) goto begF2

#                   ++hopPtr2;
		addi $t5, $t5, 4		#Add 1 to hopPtr2
#//              }
WTest2:
#                if (hopPtr2 < endPtr2) goto begW2;
		blt $t5, $a2, begW2
#                used3 = 0;
		li $t3, 0			#used3 = 0
#                hopPtr3 = a3;
		la $t7, iArr3			#Set address of hopPtr3 to iArr3
#                hopPtr1 = a1;
		la $t4, iArr1			#Set address of hopPtr1 to iArr1
#//              while (hopPtr1 < endPtr1)
#                goto WTest3;
		j WTest3
begW3:#//        {
#                   *hopPtr3 = *hopPtr1;
		lw $t0, 0($t4)
		sw $t0, 0($t7)			#*hopPtr3 = *hopPtr1
#                   ++used3;
		addi $t3, $t3, 1		#Add 1 to used3
#                   ++hopPtr3;
		addi $t7, $t7, 4		#Add 1 to hopPtr3
#                   anchor = *hopPtr1;
		lw $t8, 0($t4)			#Store hopPtr1($t4) in anchor($t8)
#                   remCount = 0;
		li $t5, 0			#Load 0 into remCount ($t5)
#//                 for (hopPtr11 = hopPtr1 + 1; hopPtr11 < endPtr1; ++hopPtr11)
#                   hopPtr11 = hopPtr1 + 1;
		addi $t6, $t4, 4		#hopPtr11($t6) = hopPtr1($t4) + 1
#                   goto FTest4;
		j FTest4 			#Jump to FTest4
begF4:#//           {
#//                    if (*hopPtr11 == anchor)
#                      if (*hopPtr11 != anchor) goto else4
		lw $t0, 0($t6)		
		bne $t0, $t8, else4		#if (*hopPtr11 != anchor) goto else4 
begI4:#//              {
#                         ++remCount;
		addi $t5, $t5, 1		#Add 1 to remCount
#                      goto endI4;
                j endI4
#//                    }
else4:#//              else
#//                    {
#                         *(hopPtr11 - remCount) = *hopPtr11;		
		lw $t0, 0($t6)			#Store *hopPtr11 in $t0 (right side of equation)
		sll $t9, $t5, 2			#Store remCount * 4 in temp $t9
		sub $t9, $t6, $t9		#Subtract remCount from hopPtr11, store in temp $t9
		sw $t0, 0($t9)			#Store to RAM memory hopPtr11($t6)

endI4:#//              }
#                   ++hopPtr11;
		addi $t6, $t6, 4		#Add 1 to hopPtr11
#//                 }
FTest4:
#                   if (hopPtr11 < endPtr1) goto begF4;
		blt $t6, $a1, begF4		#if (hopPtr11 < endPtr1) goto begF4
#                   used1 -= remCount;
		sub $t1, $t1, $t5		# same as used1 = used1 - remCount
#                   endPtr1 -= remCount;
		sll $t0, $t5, 2			# remCount * 4, stored in temp $t0
		sub $a1, $a1, $t0		# same as endPtr1 = endPtr1 - remCount
#                   ++hopPtr1;
		addi $t4, $t4, 4		#Add 1 to hopPtr1
#//              }
WTest3:
#                if (hopPtr1 < endPtr1) goto begW3;
		blt $t4, $a1, begW3		#if (hopPtr1 < endPtr1) goto begW3
#                cout << proA1Str;
		li $v0, 4
		la $a0, proA1Str		#Print "processed a1:"
		syscall
#//              for (hopPtr1 = a1; hopPtr1 < endPtr1; ++hopPtr1)
#                hopPtr1 = a1;
		la $t4, iArr1			#Set address of hopPtr1 to iArr1                
#                goto FTest5;
		j FTest5			#Jump to FTest5
begF5:#//         {
#//                 if (hopPtr1 == endPtr1 - 1)
#                   if (hopPtr1 != endPtr1 - 1) goto else5;
		addi $t0, $a1, -4	
		bne $t4, $t0, else5		
begI5:#//           {
#                      cout << *hopPtr1 << endl;
		li $v0, 1
		lw $a0, 0($t4)			#cout << *hopPtr1 
		syscall
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall		
#                   goto endI5;
		j endI5				#Jump to endI5
#//                 }
else5:#//           else
#//                 {
#                      cout << *hopPtr1 << ' ';
		li $v0, 1
		lw $a0, 0($t4)			#cout << *hopPtr1 
		syscall
		li $v0, 11			#Set up blank space
		li $a0, 32			#Print blank space
		syscall
endI5:#//           }
#                ++hopPtr1;
		addi $t4, $t4, 4		#Add 1 to hopPtr1		
#//              }
FTest5:
#                if (hopPtr1 < endPtr1) goto begF5;
		blt $t4, $a1, begF5		#if (hopPtr1 < endPtr1) goto begF5
#                cout << comA2Str;
		li $v0, 4
		la $a0, proA2Str		#Print "processed a2:"
		syscall		
#//              for (hopPtr2 = a2; hopPtr2 < endPtr2; ++hopPtr2)
#                hopPtr2 = a2;
		la $t5, iArr2			#Set address of hopPtr2 to iArr2              
#                goto FTest6;
		j FTest6			#Jump to FTest6
begF6:#//        {
#//                 if (hopPtr2 == endPtr2 - 1)
#                   if (hopPtr2 != endPtr2 - 1) goto else6;
		addi $v1, $a2, -4	
		bne $t5, $v1, else6		#if (hopPtr2 != endPtr2 - 1) goto else6
begI6:#//           {
#                      cout << *hopPtr2 << endl;
		li $v0, 1
		lw $a0, 0($t5)			#cout << *hopPtr2 
		syscall
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall	
#                   goto endI6;
		j endI6				#Jump to endI6
#//                 }
else6:#//           else
#//                 {
#                      cout << *hopPtr2 << ' ';
		li $v0, 1
		lw $a0, 0($t5)			#cout << *hopPtr2 
		syscall
		
		li $v0, 11			#Set up blank space
		li $a0, 32			#Print blank space
		syscall
endI6:#//           }
#                ++hopPtr2;
		addi $t5, $t5, 4		#Add 1 to hopPtr2		
#//              }
FTest6:
#                if (hopPtr2 < endPtr2) goto begF6;
		blt $t5, $a2, begF6		#if (hopPtr2 < endPtr2) goto begF6
#                cout << comA3Str;
		li $v0, 4
		la $a0, proA3Str		#Print proA3Str
		syscall	

#                hopPtr3 = a3;
		la $t7, iArr3			#Set address of hopPtr3 to iArr3  

#                endPtr3 = a3 + used3;
		la $a3, iArr3
		sll $t0, $t3, 2			#Set up used3
		add $a3, $a3, $t0		#endPtr3($a3) =  hopPtr3($t7) + used3($t3)
				
#//              while (hopPtr3 < endPtr3)
#                goto WTest4;
		j WTest4			#Jump to WTest4
begW4:#//        {
#//                 if (hopPtr3 == endPtr3 - 1)
#		if (hopPtr3 != endPtr3 - 1) goto else7;
		addi $t0, $a3, -4	
		bne $t7, $t0, else7
begI7:#//           {
#                      cout << *hopPtr3 << endl;
		li $v0, 1
		lw $a0, 0($t7)			#cout << *hopPtr3 
		syscall
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall	
#                   goto endI7;
		j endI7				#Jump to endI7
#//                 }
else7:#//           else
#//                 {
#                      cout << *hopPtr3 << ' ';
		li $v0, 1
		lw $a0, 0($t7)			#cout << *hopPtr3 
		syscall
		li $v0, 11			#Set up blank space
		li $a0, 32			#Print blank 	
		syscall	
endI7:#//           }
#                   ++hopPtr3;
		addi $t7, $t7, 4		#Add 1 to hopPtr3		
#//              }
WTest4:
#                if (hopPtr3 < endPtr3) goto begW4;
		blt $t7, $a3, begW4		#if (hopPtr3 < endPtr3) goto begW4
#                cout << endl;
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall
#                cout << dacStr;
		li $v0, 4
		la $a0, dacStr			#Print dacStr
		syscall	
#		cin >> reply;
		li $v0, 12			#Prepare to enter character
		syscall
		move $t8, $v0			#Enter character on console, put in reply
#                cout << endl;
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall
#//           }
DWTest1:
#//           while (reply != 'n' && reply != 'N');
#////         if (reply != 'n' && reply != 'N') goto begDW1;
#             if (reply == 'n') goto xitDW1;
		li $t0, 'n'
		beq $t8, $t0, xitDW1
#             if (reply != 'N') goto begDW1;
		li $t0, 'N'
		bne $t8, $t0, begDW1            
xitDW1:

#             cout << dlStr;
		li $v0, 4
		la $a0, d1Str			#Print d1Str
		syscall
#             cout << '\n';
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall 
#	     cout << byeStr;
		li $v0, 4
		la $a0, byeStr			#Print byeStr
		syscall
#             cout << '\n';
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall
#             cout << dlStr;
		li $v0, 4
		la $a0, d1Str			#Print d1Str
		syscall
#             cout << '\n';
		li $v0, 11			#Set up end line
		li $a0, '\n'			#Print end line
		syscall 

#             return 0;
		li $v0, 10
		syscall
#}

/******************************************************************************
* file: Assignment 4: Part1
* author: Pavan Kumar G
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Assignment 4: PART 1 - 
		
  PART 1 - To determine the larger string provided two ASCII char strings of the same length
*/



 @ BSS section
      .bss

  @ DATA SECTION
	.data

	LENGTH: .word 3;
	START1: .ascii "C";
			.ascii "A";
			.ascii "T";
	/*------Test Case A----------*/
	/*START2: .ascii "B"
			.ascii "A"
			.ascii "T"
	*/
	/*------Test Case B----------*/
	/*START2: .ascii "C"
			.ascii "A"
			.ascii "T"
	*/		
	/*------Test Case C----------*/
	START2: .ascii "C"
			.ascii "U"
			.ascii "T"
	
	GREATER: .word 0;

	 @ TEXT section
      .text
.globl main

main:
	EOR R5, R5, R5      			;@R5 is used Store result 
	LDR R0, =LENGTH
	LDR R0, [R0]    				;@string length
	
	CMP R0, #0;
	BEQ LOOP_END;	           			@ Break if there are no elements i.e. length is 0, result is 0
	
	LDR R1, =START1 				;@starting address of string STR1 in R1
	LDR R2, =START2 				;@Starting address of string STR2 in R2

	ADD R0, R0, R1  				;@end address of STR1 + 1 in R1
	

LOOP_START: 								
									
  CMP R1, R0 						;@ [R1] < [R0], i.e. till end of the start1
  BGE LOOP_END

									;@iterate over to next characters in both the strings
  LDRB R3, [R1], #1					;@+1 is used as we are iterating byte by byte
  LDRB R4, [R2], #1

  CMP R3, R4
  BEQ LOOP_START      				@[R3]  = [R4], iterate the LOOP_START
  MOVLT R5,#-1 						@i.e [R5]<-0xFFFFFFFF
                
LOOP_END:

LDR R0, =GREATER @get address of GREATER
STR R5, [R0];    @Store value of R5 @PRESENT

END: NOP @END
.end
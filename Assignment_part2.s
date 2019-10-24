/******************************************************************************
* file: Assignment 4: Part2
* author: Pavan Kumar G
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  Assignment 4: PART 2 - 
		To check if one string is a substring of the other.
			 If it is substring
				store the index of first occurrence
			else
				Reset the index value
	
  */


	@ BSS section
		.bss

	@ DATA SECTION
		.data
	
		STRING: .ascii "C";
				.ascii "S";
				.ascii "6";
				.ascii "6";
				.ascii "2";
				.ascii "0";
				.ascii "\0";
				
		/*------Test Case A----------*/
		/*SUBSTR: .ascii "S";
				.ascii "S";
				.ascii "\0";
		*/
		/*---------Test Case B-------*/
		/*SUBSTR: .ascii "6";
				.ascii "2";
				.ascii "0";
				.ascii "\0"; 
		*/
		/*------Test Case C----------*/
		SUBSTR: .ascii "6";
				.ascii "\0"; 
		
				
		PRESENT: .word 0;
		
	@ TEXT section
		  .text

.globl _main

main:
	LDR R0, =STRING 		;@starting address of STRING
	LDR R1, =SUBSTR 		;@starting of SUBSTR

	EOR R4, R4, R4 				;@iterator1 for Sting & initialized to 0
	EOR R5, R5, R5 				;@itr2 for substr

	LDRB R2, [R0] 			;@Load fist byte from STRING
	LDRB R3, [R1] 			;@Load fist byte from SUBSTR

LOOP_START: 						
	  CMP R2, #0			; @termination condition for sting
	  BEQ LOOP_END
	  CMP R3, #0			; @termination condition for sub-sting
	  BEQ LOOP_END

	  CMP R2, R3
	  BNE CONTINUE			;@if both characters are NOT same, continue to check from prevous first occurance		

	  
	  ADD R4, #1			;@ increment iterators
	  ADD R5, #1
	  LDRB R2, [R0, R4]		
	  LDRB R3, [R1, R5]
	  B LOOP_START

	  @chars do not match, [R4]<- ( [R4] - ( [R5] - 1 ) ), [R5]<- 0
CONTINUE:
	  SUB R4, R5
	  ADD R4, #1
	  EOR R5, R5, R5
	  
	  LDRB R3, [R1, R5]		;@load next byte
	  LDRB R2, [R0, R4]
	  B LOOP_START
LOOP_END:

	CMP R5, #0 				;@[R5] is 0, SUBSTR not present in STRING
	BEQ END

	
	SUB R5, R4, R5 			;@else SUBSTR is R4 - R5 + 1
	ADD R5, #1     			;@[R5] <- ( [R5] + 1 )

END:
	LDR R0, =PRESENT 		;@address of PRESENT
	STR R5, [R0]			;@Store value of R5 at PRESENT
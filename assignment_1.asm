;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Mahdi Aouchiche
; Email: maouc001@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 23
; TA: Gowda, Nikhil
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;---------------------------------------------------------
;REG VALUES			R0	R1	R2	R3	R4	R5	R6	R7	
;---------------------------------------------------------
;Pre-Loop			0	6	12	0	0	0	0	1168
;
;Iteration 01		0	5	12	12	0	0	0	1168
;Iteration 02		0	4	12	24	0	0	0	1168
;Iteration 03		0	3	12	36	0	0	0	1168
;Iteration 04		0	2	12	48	0	0	0	1168	
;Iteration 05		0	1	12	60	0	0	0	1168
;End of Program		0	0	12	72	0	0	0	DEC_0
;--------------------------------------------------------

.ORIG x3000							; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R1,	DEC_6						;R1<--6
LD R2,	DEC_12						;R2<--12
LD R3,	DEC_0						;R3<--0

DO_While	ADD R3, R3, R2			;R3<--R3+R2
			ADD R1, R1, #-1			;R1<--R1-1
			BRp DO_While			;if(LMR>0)go to DO_WHILE
			
HALT								;Terminate the program	
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_0	.FILL	#0			;PUT THE VALUE 0 INTO MEMORY HERE		
DEC_6	.FILL	#6			;PUT THE VALUE 6 INTO MEMORY HERE
DEC_12	.FILL	#12			;PUT THE VALUE 12 INTO MEMORY HERE

;---------------	
;END of PROGRAM
;---------------	
.END

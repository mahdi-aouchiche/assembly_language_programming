;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Mahdi Aouchiche
; Email: maouc001@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 023
; TA:	Nikhil Gowda
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000				; Program begins here

;-------------
;Instructions
;-------------

LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD 	R2, DEC_16			; set to decrement do while loop 

DO_WHILE_LOOP			; start do while loop 

	ADD	R1, R1, #0			; set test to branch

	BRn ELSE				; if Value is negative go to ELSE

	LD	R0, CHAR_DEC_0		; R0 <- 0
	OUT						; outputs 0
	BR END_ELSE				; branch to the end of ELSE

	ELSE 					; branch here is value is negative
	    LD R0, CHAR_DEC_1	; R0 <- 1 
	    OUT					; outputs 1
	END_ELSE				; end of ELSE
	
	ADD R1, R1, R1			; left shift the value of R1
	
	ADD	R3, R2, #-13		; R3 <- R2 - 13	
	BRz	Output_Space		; if R3 = 0 then output space
				
	BR END_Output_Space		; skip and do not output space
				
	Output_Space			; if R3 = 0 branch here
		LD	R0, Space		; load a space 
		OUT					; output space to console
	END_Output_Space		; end of branch
	
	ADD	R3, R2, #-9			; R3 <- R2 - 13	
	BRz	Output_Space_2		; if R3 = 0 then output space
				
	BR END_Output_Space_2	; skip and do not output space
	
	Output_Space_2			; if R3 = 0 branch here
		LD	R0, Space		; load a space 
		OUT					; output space to console
	END_Output_Space_2		; end of branch
		
	ADD	R3, R2, #-5			; R3 <- R2 - 13	
	BRz	Output_Space_3		; if R3 = 0 then output space
				
	BR END_Output_Space_3	; skip and do not output space
				
	Output_Space_3			; if R3 = 0 branch here
		LD	R0, Space		; load a space 
		OUT					; output space to console
	END_Output_Space_3		; end of branch
	
    ADD	R2, R2, #-1			; decrement do while loop counter
    BRp	DO_WHILE_LOOP		; R2 > 0 do while loop 

END_DO_WHILE_LOOP			; terminate do while loop	

LD R0, Newline				; R0 <- newline
OUT							; output a new line

HALT

;---------------	
;Data
;---------------

Value_addr	.FILL xAB00		; The address where value to be displayed is stored
DEC_16		.FILL	#16		; number of bits 
CHAR_DEC_1	.FILL	#49		; ascii character of the digit 1
CHAR_DEC_0	.FILL	#48		; ascii character of the digit 0 
Newline		.FILL	'\n'	; holds a newline 
Space		.FILL	#32		; dec 32 represents space in ascii code
;=============================================================================

.ORIG xAB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END

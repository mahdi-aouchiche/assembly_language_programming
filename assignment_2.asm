;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Mahdi Aouchiche
; Email: maouc001@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 023
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	

LEA 	R0, intro		; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;---------------------------------------------
;INSERT YOUR CODE here
;---------------------------------------------

GETC 				;pause the program until user types a key, a corresponding ASCII code is captured in R0
OUT				;outputs whats in R0 to console as a character
ADD	R1, R0, #0		;adds 0 to R0 and transfer it to R1
LD 	R0, newline		;copy the value stored in newline to R0 i,e \n
OUT				;puts out the newline	

GETC 				;gets the 2nd character from user and store it to R0
OUT 				;outputs character in R0 to console 
ADD 	R2, R0, #0		;STORE WHATS IN R0 IN R2 
LD 	R0, newline		;copy the value stored in newline to R0 i,e \n
OUT				;puts out the newline

ADD 	R0, R1, #0 		;put stored value R1 to R0
OUT 				;outputs value of first number in R0 to console 

LEA	R0, minus 		;put the negative sign to R0
PUTS 				;outputs negative sign in R0 to console

ADD 	R0, R2, #0 		;put stored value R2 to R0
OUT 				;outputs value of 2nd number in R0 to console

LEA	R0, equal		;put the equal sign to R0
PUTS				;outputs equal sign in R0 to console

LD 	R3, ascii_to_number	; load x000f to R3 

AND 	R1, R1, R3		; convert the first ascii code to a number by AND with x0F
AND 	R2, R2, R3		; convert the second ascii code to a number by AND with x0F

NOT  	R2, R2			; use 1's complement of the second entered number and stores it bac;k in the same register R2
ADD	R2, R2, #1		; add 1 to 1's to convert to 2's complement and stores it back in the same register R2

ADD	R4, R1, R2		; first number + (- second number), The result is stored in R4

BRn	neg_number		; test if the number is negatif then branch to negative number

LD 	R0, num_to_ascii	; Load offset number x30 to R0

ADD	R0, R0,	R4		; add offset and the result from R4 and register in R0
OUT				; output the magnitude of result to the console

LD  R0, newline			; loads a newline
OUT				; outputs a newline to console  (what's in R0)

HALT

neg_number	
	LD  	R0, minus_sign		; load the minus sign to R0.
	OUT				; outputs the minus sign to console if number is negative
	
	NOT	R4, R4	 		; if the number is negative, get 1's complement
	ADD	R4, R4, #1 		; add 1 for 2's complement 
	
	AND	R0, R0, x0		; clear R0

	LD 	R0, num_to_ascii	; Load offset number x30 to R0
	
	ADD 	R0, R0, R4		; convert back the number to ascii code to be displayed as a character
	OUT				; output the magnitude of result to the console
	
	AND	R0, R0, #0
	LD  	R0, newline 		; load a newline to R0 
	OUT				; outputs a newline 

HALT					; Stop execution of program

;---------------	
;Data
;---------------

; String to prompt user. Note: already includes terminating newline!
intro 		.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 	; prompt string - use with LEA, followed by PUTS.

newline 	.FILL 		'\n'		; newline character - use with LD followed by OUT

minus		.STRINGZ	" - "		; outputs the minus sign into the equation, use with LEA fellowed by PUTS.
equal		.STRINGZ	" = " 		; outputs the equal sign into the equation, use with LEA fellowed by PUTS.
minus_sign	.FILL		x2D

ascii_to_number	.FILL 		xf		; AND the ascii code with x0f (00001111) to convert to a number 

num_to_ascii	.FILL		x30		; add to number to get ascii character (0011 0000)

;---------------	
;END of PROGRAM
;---------------	
.END

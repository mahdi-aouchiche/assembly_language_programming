;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Mahdi Aouchiche
; Email: maouc001@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 23
; TA: Nikhil Gowda
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R5
;=================================================================================

.ORIG x3000		

;-------------
;Instructions
;-------------

START					; if user enters a wrong input branch here to start over

; output intro prompt
LD R0, introPromptPtr			; load R0 with into prompt
PUTS					; outputs the intro to console 
	
; Set up flags, counters, accumulators as needed
AND R1, R1, #0				; reset R1 to 0
AND R2, R2, #0				; reset R2 to 0
AND R3, R3, #0				; reset R3 to 0
AND R4, R4, #0				; reset R4 to 0
AND R5, R5, #0				; reset R5 to 0
AND R6, R6, #0				; reset R6 to 0
AND R7, R7, #0				; reset R7 to 0

; Get first character, test for '\n', '+', '-', digit/non-digit 
GETC					; get the first user input character
OUT					; outputs the character to console
ADD	R1, R1, R0			; store user input in R1	
	
; is very first character = '\n'? if so, just quit (no message)!
ADD	R2, R1, #-10			; R2 <- R1 - 10 to check if a new line is entered 
BRz		quit			; quit program is user input is enter.	
						
; is it = '+'? if so, ignore it, go get digits
LD	R2, DEC_NEG_43			; R2 <- -43			
ADD	R2, R2, R1 			; R2 <- R1 - 43 to check if a '+' is entered
BRnp 	Not_A_Plus		
					
	ADD R6, R6, #1			; set a flag to get up to 5 more digits 					
	BR GET_THE_REST_OF_DIGITS
					
Not_A_Plus	
				
; is it = '-'? if so, set neg flag, go get digits
			
LD	R2, DEC_NEG_45			; R2 <- -45
			
ADD	R2, R2, R1 			; R2 <- R1 - 45 to check if a '-' is entered				
BRnp	Not_A_Minus
				
	ADD R6, R6, #-1			; set a flag to go through two's complement if number is negative
					; and get up to 5 more digits					
	BR GET_THE_REST_OF_DIGITS
						
Not_A_Minus
								
; is it < '0'? if so, it is not a digit	- o/p error message, start over
			
LD	R2, DEC_NEG_48			; R2 <- -48
ADD	R2, R2, R1 			; R2 <- R1 - 48 to check if user input is less then 0				
BRzp	Next_Check			; if positive or zero check upper bound
			
	LD R0, newline			; load R0 with a newline 
	OUT				; outputs the newline to console
				
	LD R0, errorMessagePtr		; loads error message to R0
	PUTS				; putputs error message to console
												 
	BR START			; if negative then input is invalid so start over
				
Next_Check	
				
; is it > '9'? if so, it is not a digit	- o/p error message, start over
LD	R2, DEC_NEG_57			; R2 <- -57
ADD	R2, R2, R1 			; R2 <- R1 - 57 to check if user input is greater then 9
BRnz	Next				; if negative  or zero then its a valid input 
				
	LD R0, newline			; load R0 with a newline 
	OUT				; outputs the newline to console
						
	LD R0, errorMessagePtr		; loads error message to R0
	PUTS				; putputs error message to console
													
	BR START			; if negative then input is invalid so start over
					
Next
				
; if none of the above, first character is first numeric digit - deal with it!
LD	R2, DEC_NEG_48			; R2 <- -48 
ADD	R1, R1, R2			; R1<- R1-48  convert user input from an ascii char to a digit 
ADD	R5, R5, R1			; R5 <- R5 + R1 get first user input if a valid digit
					
; Now get (remaining) digits (max 5) from user and build up number in accumulator
GET_THE_REST_OF_DIGITS
ADD R6, R6, #0 				; check if a minus or plus is entered
BRnp	skip				; if it is negative or positive go to skip
	ADD R3, R3, #4			; set R3 to 4 to get the last 4 digits
	BR END_skip	
	
skip
	ADD R3, R3, #5			; set R3 to 5 to get the last 5 digits
END_skip

DO_WHILE_LOOP	
	AND	R1, R1, #0 			; reset R1 to 0 
	AND 	R2, R2, #0			; reset R2 to 0	
	GETC					; get the first user input character
	OUT					; outputs the character to console
	ADD	R1, R1, R0			; store user input in R1	
		
	; is it the terminate character = '\n'? if so, quit the do while loop!
	ADD	R2, R1, #-10			; R2 <- R1 - 10 to check if a new line is entered 
	BRz	END_DO_WHILE_LOOP		; quit the loop if user input is enter.	
		; is it < '0'? if so, it is not a digit	- o/p error message, start over
		LD	R2, DEC_NEG_48		; R2 <- -48
		ADD	R2, R2, R1 		; R2 <- R1 - 48 to check if user input is less then 0				
		BRzp	Next_Check_1		; if positive or zero check upper bound
			LD R0, newline		; load R0 with a newline 
			OUT			; outputs the newline to console
			LD R0, errorMessagePtr	; loads error message to R0
			PUTS			; outputs error message to console
										
			BR START		; if negative then input is invalid so start over
				
		Next_Check_1	
		; is it > '9'? if so, it is not a digit	- o/p error message, start over
		LD	R2, DEC_NEG_57		; R2 <- -57
			
		ADD	R2, R2, R1 		; R2 <- R1 - 57 to check if user input is greater then 9
		BRnz	Next_1			; if negative or 0 then its a valid input 
			LD R0, newline		; load R0 with a newline 
			OUT			; outputs the newline to console
						
			LD R0, errorMessagePtr	; loads error message to R0
			PUTS			; outputs error message to console
								
			BR START		; if negative then input is invalid so start over
					
		Next_1						
		AND 	R2, R2, #0		; reset R2 to 0
		ADD	R2, R2, R5		; R2 <- R2 + R5  value to be added 10 times
		LD 	R4, DEC_9		;set R4 to 10 to multiply by 10
			
	DO_WHILE_LOOP_A
		ADD R5, R5, R2  		; R5 <- R5 + R2 (multiply by 10)
		ADD R4, R4, #-1			; decrement for inner do while loop to 10 times
		BRp	DO_WHILE_LOOP_A
			
	END_DO_WHILE_LOOP_A
		
	LD	R2, DEC_NEG_48			; R2 <- -48 
	ADD	R1, R1, R2			; R1<- R1-48  convert user input from an ascii char to a digit 
	ADD	R5, R5, R1			; add the digit intered to the value of R5 
	ADD R3, R3, #-1				; decrement R3 for the number of digits 
	BRp DO_WHILE_LOOP
				
END_DO_WHILE_LOOP	
	
ADD R6, R6, #0					; check if negative number to branch
BRzp quit
	NOT R5, R5				; flip to get 1's complement
	ADD R5, R5, #1				; add 1 for 2's complement 
	
quit						; if user inputs a wrong input or the enter key, the program quits
			
; remember to end with a newline!	
LD R0, newline					; load R0 with a newline 
OUT						; outputs the newline to console
										
HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL x3A00
errorMessagePtr		.FILL x3B00

newline			.FILL	'\n' 		; to outputs a newline to console
DEC_9			.FILL	#9		; set to multiply a number by 10 
DEC_NEG_43		.FILL	#-43		; to check for '+' input
DEC_NEG_45		.FILL	#-45		; to check for '-' input
DEC_NEG_48		.FILL	#-48		; to check for invalid input less then 0
DEC_NEG_57		.FILL	#-57		; to check for invalid input greater then 9 	


;------------
; Remote data
;------------
.ORIG x3A00	; intro prompt
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
.ORIG x3B00	; error message
.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's
; complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must also output a final newline.
; Input validation is performed on the individual characters as they are input, 
; but not on the magnitude of the number.
3

;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Mahdi Aouchiche
; Email: maouc001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 023
; TA: Nikhil Gowda
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

	START_PROGRAM

	AND R0, R0, #0		; reset R0 to 0
	AND R1, R1, #0		; reset R1 to 0
	AND R2, R2, #0		; reset R2 to 0
	AND R3, R3, #0		; reset R3 to 0
	AND R4, R4, #0		; reset R4 to 0
	AND R5, R5, #0		; reset R5 to 0
	AND R6, R6, #0		; reset R6 to 0
	AND R7, R7, #0		; reset R7 to 0
	
	JSR	MENU		; call SR Menu return user selection in R1 1 < R1 < 7
	
	LD R0, NEWLINE 		; load R0 with a newline 
	OUT			; outputs the newline to console
	
; check if user input is 7 ---------------------------------------------------------------------
	ADD 	R3, R1, #-7 			; R3 = R1 - 7
	BRnp	CHECK_IF_USER_INPUT_IS_1	; if R1 = 7 then quit 
		LEA 	R0, Goodbye 		; point to the memory address 
		PUTS				; output the message Goodbye!
		BR 	QUIT_PROGRAM 		; jump to halt to quit the program
	
	CHECK_IF_USER_INPUT_IS_1		; check if user input is 1  
		
; check if user input is 1------------------------------------------------------------------------ 
	AND 	R3, R3, #0 			; reset R3 to 0
	ADD 	R3, R1, #-1			; R3 = R1 - 1 ,check if user input is 1
	BRnp	CHECK_IF_USER_INPUT_IS_2	; if R3 != 0 then jump
	
		LD	R6, SUBROUTINE_ALL_MACHINES_BUSY 	; pointer to memory address x3400
		JSRR 	R6					; call for ALL_MACHINES_BUSY : return R2 = 1 or 0	
		
		ADD 	R5, R2, #0 				; R5 <- R2 
		BRz	MESSAGE_1				; if R2 = 0 go to message 1 
			LEA	R0, ALLBUSY			; point to string all busy
			PUTS					; output all machines are busy
		
			BR 	START_PROGRAM			; start again through the program
			
		MESSAGE_1
		LEA 	R0, ALLNOTBUSY				; point to string all not busy
		PUTS						; output Not all machines are busy
		BR 	START_PROGRAM				; start again through the program
	
	CHECK_IF_USER_INPUT_IS_2				; check if user input is 2  

; check if user input is 2 ------------------------------------------------------------------------ 
	AND 	R3, R3, #0					; reset R3 to 0
	ADD 	R3, R1, #-2					; R3 = R1 - 2 ,check if user input is 2
	BRnp	CHECK_IF_USER_INPUT_IS_3			; if R3 != 0  then jump 
	
		LD	R6, SUBROUTINE_ALL_MACHINES_FREE	; pointer to memory address x3600
		JSRR 	R6					; call for ALL_MACHINES_FREE, return R2 = 1 or 0	
		
		ADD 	R5, R2, #0 				; R5 <- R2 
		BRz	MESSAGE_2				;if R2 = 0 go to message 2 
			LEA 	R0, FREE			; point to string all free
			PUTS					; output all machines are free
			BR 	START_PROGRAM			; start again through the program
			
		MESSAGE_2
		LEA 	R0, NOTFREE				; point to string all not free
		PUTS						; output Not all machines are free	
		BR 	START_PROGRAM				; start again through the program
	
	CHECK_IF_USER_INPUT_IS_3				; check if user input is 3

; check if user input is 3 ------------------------------------------------------------------------ 
	AND 	R3, R3, #0					; reset R3 to 0
	ADD 	R3, R1, #-3					; R3 = R1 - 3 ,check if user input is 3
	BRnp	CHECK_IF_USER_INPUT_IS_4			; if R3 != 0  then jump 
		LD	R6, SUBROUTINE_NUM_BUSY_MACHINES	; pointer to memory address x3600
		JSRR 	R6					; call SUBROUTINE_NUM_BUSY_MACHINES, return R2 = number of busy (0) machines 
				
		LEA 	R0, BUSYMACHINE1 			; point to string there are 
		PUTS						; output string
		
		AND 	R1, R1, #0 				; reset R1 to 0 
		ADD 	R1, R2, #0				; passe value of R2 to R1 to be used by subroutine 4800. 
		
		LD	R6, SUBROUTINE_PRINT_NUM		; pointer to memory address x4800 
		JSRR 	R6 					; call SUBROUTINE_PRINT_NUM , return the value in R2 as a ascii character 
		
		LEA 	R0, BUSYMACHINE2 			; point to string busy machines 
		PUTS						; output string to console
		
		BR 	START_PROGRAM				; start again through the program
				
	CHECK_IF_USER_INPUT_IS_4				; check if user input is 4

; check if user input is 4 ------------------------------------------------------------------------
	AND 	R3, R3, #0 					; reset R3 to 0
	ADD 	R3, R1, #-4					; R3 = R1 - 4 ,check if user input is 4
	BRnp	CHECK_IF_USER_INPUT_IS_5			; if R3 != 0  then jump 
	
		LD	R6, SUBROUTINE_NUM_FREE_MACHINES	; pointer to memory address x4000
		JSRR 	R6					; call SUBROUTINE_NUM_BUSY_MACHINES, return R2 = number of busy (0) machines 
				
		LEA 	R0, FREEMACHINE1			; point to string there are 
		PUTS						; output string
		
		AND 	R1, R1, #0 				; reset R1 to 0 
		ADD 	R1, R2, #0 				; passe value of R2 to R1 to be used by subroutine 4800. 
		
		LD	R6, SUBROUTINE_PRINT_NUM		; pointer to memory address x4800 
		JSRR 	R6 					; call SUBROUTINE_PRINT_NUM , return the value in R2 as a ascii character 
		
		LEA 	R0, FREEMACHINE2			; point to string busy machines 
		PUTS						; output string to console
		
		BR 	START_PROGRAM				; start again through the program
				
	CHECK_IF_USER_INPUT_IS_5				; check if user input is 4

; check if user input is 5 ------------------------------------------------------------------------ 
	AND 	R3, R3, #0					; reset R3 to 0
	ADD 	R3, R1, #-5	 				; R3 = R1 - 5 ,check if user input is 5
	BRnp	CHECK_IF_USER_INPUT_IS_6			; if R3 != 0  then jump 	
		LD	R6, SUBROUTINE_GET_MACHINE_NUM_4600	; pointer to memory address x4600
		JSRR 	R6					; call SUBROUTINE_GET_MACHINE_NUM_4600, The input value is in R1 
		
		LEA 	R0, STATUS1 				; point to string Machine 
		PUTS						; output string
		
		LD	R6, SUBROUTINE_PRINT_NUM		; pointer to memory address x4800
		JSRR 	R6 					; call SUBROUTINE_PRINT_NUM, The input value is in R1
		
		LD	R6, SUBROUTINE_MACHINE_STATUS		; pointer to memory address x4800 
		JSRR	R6 					; call SUBROUTINE_MACHINE_STATUS 
		
		ADD 	R2, R2, #0 				; set to branch
		BRz	BUSY_MACHINE				; if R2 = 0 then go to busy machine
			LEA 	R0, STATUS3			; point to string is free 
			PUTS					; output string
			
			BR 	START_PROGRAM			; start again through the program
			
		BUSY_MACHINE					; machine is busy
		LEA R0, STATUS2					; point to string is busy 
		PUTS						; output string	
		BR START_PROGRAM				; start again through the program
			
	CHECK_IF_USER_INPUT_IS_6

; check if user input is 6 ---------------------------------------------------------------------
	LD	R6, SUBROUTINE_FIRST_FREE 			; pointer to memory address x4400
	JSRR 	R6 						; call SUBROUTINE_FIRST_FREE, The output value is in R2  
	
	AND 	R1, R1, #0					; reset R1 to 0
	ADD 	R1, R2, #0					; R1 <- R2 (the output of SUBROUTINE first free machine)
	LD	R3, DEC_NEG_16					; R3 = -16
	ADD 	R3, R3, R2
	BRZ	NO_MASHINES_ARE_FREE
		LEA 	R0, FIRSTFREE1 				; point to the firstfree1 string The first available machine is number
		PUTS						; output string
	
		LD	R6, SUBROUTINE_PRINT_NUM		; pointer to memory address x4800
		JSRR R6						; call SUBROUTINE_PRINT_NUM, The input value is in R1
		
		LD R0, NEWLINE					; load R0 with a newline 
		OUT						; outputs the newline to console
		
		BR START_PROGRAM				; start again through the program
		
	NO_MASHINES_ARE_FREE
	LEA 	R0, FIRSTFREE2    				; point to the firstfree2 string FIRSTFREE2, No machines are free
	PUTS							; output string
			
	BR START_PROGRAM					; start again through the program
	
;-------------------------------------------------------------------------------
	QUIT_PROGRAM						; jump here from MENU to quit program

HALT								; Stop execution of program

;---------------	
;Data
;---------------
;Add address for subroutines
	SUBROUTINE_MENU_3200			.FILL	x3200		; menu SR
	SUBROUTINE_ALL_MACHINES_BUSY		.FILL	x3400		; #1
	SUBROUTINE_ALL_MACHINES_FREE		.FILL	x3600		; #2
	SUBROUTINE_NUM_BUSY_MACHINES		.FILL	x3800		; #3
	SUBROUTINE_NUM_FREE_MACHINES		.FILL	x4000		; #4
	SUBROUTINE_MACHINE_STATUS		.FILL	x4200		; #5
	SUBROUTINE_FIRST_FREE			.FILL	x4400		; #6
	SUBROUTINE_GET_MACHINE_NUM_4600		.FILL	x4600
	SUBROUTINE_PRINT_NUM			.FILL	x4800

;Other data 
	DEC_NEG_16				.FILL	#-16		; decimal -16
	DEC_NEG_55				.FILL	#-55		; decimal -7 
	NEWLINE         			.FILL '\n'
	
;Strings for options
	Goodbye         .STRINGZ "Goodbye!\n"
	ALLNOTBUSY      .STRINGZ "Not all machines are busy\n"
	ALLBUSY         .STRINGZ "All machines are busy\n"
	FREE            .STRINGZ "All machines are free\n"
	NOTFREE		.STRINGZ "Not all machines are free\n"
	BUSYMACHINE1    .STRINGZ "There are "
	BUSYMACHINE2    .STRINGZ " busy machines\n"
	FREEMACHINE1    .STRINGZ "There are "
	FREEMACHINE2    .STRINGZ " free machines\n"
	STATUS1         .STRINGZ "Machine "
	STATUS2		.STRINGZ " is busy\n"
	STATUS3		 .STRINGZ " is free\n"
	FIRSTFREE1      .STRINGZ "The first available machine is number "
	FIRSTFREE2      .STRINGZ "No machines are free\n"

;---------------------
; Remote data
;---------------------
.ORIG x6000
	MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xCE00			
	BUSYNESS	.FILL x4815  		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
;=======================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, 
;				allowed the user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------

.Orig x3200

;========================
; Subroutine Instructions
;========================
	MENU

;(1) Backup the registers the subroutine changes except Return values

	ST R0, BACKUP_R0_3200	; backup R0
;	ST R1, BACKUP_R1_3200	; backup R1
;	ST R2, BACKUP_R2_3200	; backup R2
	ST R3, BACKUP_R3_3200	; backup R3
	ST R4, BACKUP_R4_3200	; backup R4
	ST R5, BACKUP_R5_3200	; backup R5
	ST R6, BACKUP_R6_3200	; backup R6
	ST R7, BACKUP_R7_3200	; backup R7
	
;(2) Subroutine Algorithm	

	START_MENU				; if user input is invalid start here again
	
	LD 	R0, Menu_string_addr 		; R0 <- Mem[x6000] 
	PUTS					; outputs the Menu to console
	
	GETC					; get the user input from menu
	OUT					; outputs the character to console
	
	LD	R3, DEC_NEG_49_3200		; R3 <- -49
				
	ADD	R3, R3, R0 			; R3 <- R0 - 49 to check if user input is less then 1				
	BRzp	Next_Check			; if positive or zero check upper bound in next check
			
		LD 	R0, NEWLINE_3200	; load R0 with a newline 
		OUT				; outputs the newline to console
			
		LEA R0, Error_msg_1		; loads error message to R0
		PUTS				; outputs error message (invalid input to console) 
												
		BR START_MENU			; if negative then input is invalid so start over
				
	Next_Check 				; if number entered is > 0 then check if < 7 
	LD	R3, DEC_NEG_55_3200		; R3 <- -55
	ADD	R3, R3, R0 			; R3 <- R0 - 55 to check if user input is greater then 7
	BRnz	Next				; if negative  or zero then its a valid input 
		LD 	R0, NEWLINE_3200	; load R0 with a newline 
		OUT				; outputs the newline to console
					
		LEA 	R0, Error_msg_1		; loads error message to R0
		PUTS 				; outputs error message (invalid input to console) 
												;
		BR START_MENU			; if positive then input is invalid so start over				
	Next
	LD 	R1, DEC_NEG_48_3200 		; R1 <- -48 to convert ascii code to decimal number
	ADD	R1, R1, R0			; when input is 1 < input < 7, then R1 = user input in R0 (R1 = R0 -48) 
	
;3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_3200		; restore R0
;	LD	R1, BACKUP_R1_3200		; restore R1
;	LD	R2, BACKUP_R2_3200		; restore R2
	LD	R3, BACKUP_R3_3200		; restore R3
	LD	R4, BACKUP_R4_3200		; restore R4
	LD	R5, BACKUP_R5_3200		; restore R5
	LD	R6, BACKUP_R6_3200		; restore R6	
	LD	R7, BACKUP_R7_3200		; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_3200  .BLKW #1 ; original data of R0
;	BACKUP_R1_3200  .BLKW #1 ; original data of R1
;	BACKUP_R2_3200  .BLKW #1 ; original data of R2
	BACKUP_R3_3200  .BLKW #1 ; original data of R3
	BACKUP_R4_3200  .BLKW #1 ; original data of R4
	BACKUP_R5_3200  .BLKW #1 ; original data of R5
	BACKUP_R6_3200  .BLKW #1 ; original data of R6
	BACKUP_R7_3200	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine MENU
;--------------------------------
	DEC_NEG_48_3200		.FILL	#-48		; convert ascii code char to a dec number
	DEC_NEG_49_3200		.FILL	#-49		; to check for invalid input less then 1
	DEC_NEG_55_3200		.FILL	#-55		; to check for invalid input greater then 7 
	
	NEWLINE_3200		.FILL	'\n'		; outputs a newline 
	
	Error_msg_1	      	.STRINGZ "INVALID INPUT\n"
	Menu_string_addr  	.FILL x6000
	
.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;--------------------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------------------
.Orig x3400

;========================
; Subroutine Instructions
;========================
	ALL_MACHINES_BUSY

;(1) Backup the registers the subroutine changes except Return values

	ST R0, BACKUP_R0_3400	; backup R0
	ST R1, BACKUP_R1_3400	; backup R1
;	ST R2, BACKUP_R2_3400	; backup R2
	ST R3, BACKUP_R3_3400	; backup R3
	ST R4, BACKUP_R4_3400	; backup R4
	ST R5, BACKUP_R5_3400	; backup R5
	ST R6, BACKUP_R6_3400	; backup R6
	ST R7, BACKUP_R7_3400	; backup R7
	
;(2) Subroutine Algorithm	
	AND 	R2, R2, #0					; set R2 to 0
	LD 	R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY		; R0 <- xCE00
	
	LDR	R3, R0, #0 					; R3 <- 16 bit vector 
	BRz	ALL_MACHINES_ARE_BUSY				; if R0 = 0 then branch 
		BR 	END_ALL_MACHINES_ARE_BUSY		; R2 = 0 jump to end
	
	ALL_MACHINES_ARE_BUSY 					; the vector value is x0000
		ADD R2, R2, #1					; set R2 = 1 (all machines are busy) 
	END_ALL_MACHINES_ARE_BUSY


;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_3400	; restore R0
	LD	R1, BACKUP_R1_3400	; restore R1
;	LD	R2, BACKUP_R2_3400	; restore R2
	LD	R3, BACKUP_R3_3400	; restore R3
	LD	R4, BACKUP_R4_3400	; restore R4
	LD	R5, BACKUP_R5_3400	; restore R5
	LD	R6, BACKUP_R6_3400	; restore R6	
	LD	R7, BACKUP_R7_3400	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_3400  .BLKW #1 ; original data of R0
	BACKUP_R1_3400  .BLKW #1 ; original data of R1
;	BACKUP_R2_3400  .BLKW #1 ; original data of R2
	BACKUP_R3_3400  .BLKW #1 ; original data of R3
	BACKUP_R4_3400  .BLKW #1 ; original data of R4
	BACKUP_R5_3400  .BLKW #1 ; original data of R5
	BACKUP_R6_3400  .BLKW #1 ; original data of R6
	BACKUP_R7_3400	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xCE00

.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;--------------------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------------------

.Orig x3600

;========================
; Subroutine Instructions
;========================
	ALL_MACHINES_FREE

;(1) Backup the registers the subroutine changes except Return values

	ST R0, BACKUP_R0_3600	; backup R0
	ST R1, BACKUP_R1_3600	; backup R1
	;ST R2, BACKUP_R2_3600	; backup R2
	ST R3, BACKUP_R3_3600	; backup R3
	ST R4, BACKUP_R4_3600	; backup R4
	ST R5, BACKUP_R5_3600	; backup R5
	ST R6, BACKUP_R6_3600	; backup R6
	ST R7, BACKUP_R7_3600	; backup R7
	
;(2) Subroutine Algorithm	

	AND 	R2, R2, #0					; set R2 to 0
	LD 	R0, BUSYNESS_ADDR_ALL_MACHINES_FREE		; R0 <- xCE00
	LDR	R3, R0, #0 					; R3 <- 16 bit vector 
	ADD 	R3, R3, #1								; R3 <- R3 +1  
	BRz	ALL_MACHINES_ARE_FREE				; if R3 = 0 then branch 
		BR END_ALL_MACHINES_ARE_FREE			; R2 = 0 jump to end
	
	ALL_MACHINES_ARE_FREE 					; the vector value is x0000
		ADD R2, R2, #1					; set R2 = 1 (all machines are busy) 
	END_ALL_MACHINES_ARE_FREE

;(3) Restore the registers that you backed up

	LD	R0, BACKUP_R0_3600	; restore R0
	LD	R1, BACKUP_R1_3600	; restore R1
	;LD	R2, BACKUP_R2_3600	; restore R2
	LD	R3, BACKUP_R3_3600	; restore R3
	LD	R4, BACKUP_R4_3600	; restore R4
	LD	R5, BACKUP_R5_3600	; restore R5
	LD	R6, BACKUP_R6_3600	; restore R6	
	LD	R7, BACKUP_R7_3600	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_3600  .BLKW #1 ; original data of R0
	BACKUP_R1_3600  .BLKW #1 ; original data of R1
	;BACKUP_R2_3600  .BLKW #1 ; original data of R2
	BACKUP_R3_3600  .BLKW #1 ; original data of R3
	BACKUP_R4_3600  .BLKW #1 ; original data of R4
	BACKUP_R5_3600  .BLKW #1 ; original data of R5
	BACKUP_R6_3600  .BLKW #1 ; original data of R6
	BACKUP_R7_3600	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xCE00


.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.Orig x3800

;========================
; Subroutine Instructions
;========================
	NUM_BUSY_MACHINES

;(1) Backup the registers the subroutine changes except Return values

	ST R0, BACKUP_R0_3800	; backup R0
	ST R1, BACKUP_R1_3800	; backup R1
	;ST R2, BACKUP_R2_3800	; backup R2
	ST R3, BACKUP_R3_3800	; backup R3
	ST R4, BACKUP_R4_3800	; backup R4
	ST R5, BACKUP_R5_3800	; backup R5
	ST R6, BACKUP_R6_3800	; backup R6
	ST R7, BACKUP_R7_3800	; backup R7
	
;(2) Subroutine Algorithm	
	LD 	R6, BUSYNESS_ADDR_NUM_BUSY_MACHINES		; load address of the Vector to R6
	LDR 	R6, R6, #0					; load vector to R6
	LD 	R5, DEC_15					; set R5 to 15 , used in do while loop to cover all 16 bits of vector 
	AND 	R2, R2, #0					; reset R2 to o , used as he flag to return the number of free machines 
	ADD 	R6, R6, #0					; set R4 for branch 
	BRn 	DO_NOT_INCREMENT				; if R4 [15] is 1 go to next
			ADD	R2, R2, #1			; if R4 [15] is 0 , increment R2
	DO_NOT_INCREMENT
	
	DO_WHILE_LOOP_3800	
		ADD 	R6, R6, R6				; left shift the vector to chech R[15]
		BRn 	NEXT_BIT				; if R4 [15] is 1 go to check next bit
			ADD	R2, R2, #1			; if R4 [15] is 0 , increment R2
		NEXT_BIT
		ADD 	R5, R5, #-1 				; decrement from 15 to 0 
		BRp	DO_WHILE_LOOP_3800			; if R5 > 0 go to loop again 
	END_DO_WHILE_LOOP_3800
	
;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_3800	; restore R0
	LD	R1, BACKUP_R1_3800	; restore R1
	;LD	R2, BACKUP_R2_3800	; restore R2
	LD	R3, BACKUP_R3_3800	; restore R3
	LD	R4, BACKUP_R4_3800	; restore R4
	LD	R5, BACKUP_R5_3800	; restore R5
	LD	R6, BACKUP_R6_3800	; restore R6	
	LD	R7, BACKUP_R7_3800	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_3800  .BLKW #1 ; original data of R0
	BACKUP_R1_3800  .BLKW #1 ; original data of R1
	;BACKUP_R2_3800  .BLKW #1 ; original data of R2
	BACKUP_R3_3800  .BLKW #1 ; original data of R3
	BACKUP_R4_3800  .BLKW #1 ; original data of R4
	BACKUP_R5_3800  .BLKW #1 ; original data of R5
	BACKUP_R6_3800  .BLKW #1 ; original data of R6
	BACKUP_R7_3800	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
	BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill 	xCE00
	DEC_15				.FILL 	#15		; represents the number of bits in the vector  

.END	; ends subroutine
;================================================================================================================


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.Orig x4000

;========================
; Subroutine Instructions
;========================
	NUM_FREE_MACHINES

;(1) Backup the registers the subroutine changes except Return values
	ST R0, BACKUP_R0_4000	; backup R0
	ST R1, BACKUP_R1_4000	; backup R1
	;ST R2, BACKUP_R2_4000	; backup R2
	ST R3, BACKUP_R3_4000	; backup R3
	ST R4, BACKUP_R4_4000	; backup R4
	ST R5, BACKUP_R5_4000	; backup R5
	ST R6, BACKUP_R6_4000	; backup R6
	ST R7, BACKUP_R7_4000	; backup R7
	
;(2) Subroutine Algorithm	
	LD 	R6, BUSYNESS_ADDR_NUM_FREE_MACHINES		; load address of the Vector to R6
	LDR 	R6, R6, #0					; load vector to R6
	LD 	R5, DEC_15_4000					; set R5 to 15 , used in do while loop to cover all 16 bits of vector 
	AND 	R2, R2, #0					; reset R2 to o , used as he flag to return the number of free machines 
	ADD 	R6, R6, #0					; set R6 for branch 
	BRzp 	DO_NOT_INCREMENT_4000				; if R6 [15] is 0 go to next
		ADD	R2, R2, #1				; if R2 [15] is 1 , increment R2
	DO_NOT_INCREMENT_4000
	
	DO_WHILE_LOOP_4000	
		ADD 	R6, R6, R6				; left shift the vector to chech R[15]
		BRzp 	NEXT_BIT_4000				; if R6 [15] is 0 go to check next bit
			ADD	R2, R2, #1			; if R2 [15] is 1 , increment R2
		NEXT_BIT_4000
		ADD R5, R5, #-1 				; decrement from 15 to 0 
		BRp	DO_WHILE_LOOP_4000			; if R5 > 0 go to loop again 
	END_DO_WHILE_LOOP_4000

;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_4000	; restore R0
	LD	R1, BACKUP_R1_4000	; restore R1
	;LD	R2, BACKUP_R2_4000	; restore R2
	LD	R3, BACKUP_R3_4000	; restore R3
	LD	R4, BACKUP_R4_4000	; restore R4
	LD	R5, BACKUP_R5_4000	; restore R5
	LD	R6, BACKUP_R6_4000	; restore R6	
	LD	R7, BACKUP_R7_4000	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_4000  .BLKW #1 ; original data of R0
	BACKUP_R1_4000  .BLKW #1 ; original data of R1
	;BACKUP_R2_4000  .BLKW #1 ; original data of R2
	BACKUP_R3_4000  .BLKW #1 ; original data of R3
	BACKUP_R4_4000  .BLKW #1 ; original data of R4
	BACKUP_R5_4000  .BLKW #1 ; original data of R5
	BACKUP_R6_4000  .BLKW #1 ; original data of R6
	BACKUP_R7_4000	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill 	xCE00
DEC_15_4000			.FILL 	#15		; represents the number of bits in the vector

.END	; ends subroutine
;================================================================================================================


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.Orig x4200

;========================
; Subroutine Instructions
;========================
	MACHINE_STATUS

;(1) Backup the registers the subroutine changes except Return values
	ST R0, BACKUP_R0_4200	; backup R0
	ST R1, BACKUP_R1_4200	; backup R1
	;ST R2, BACKUP_R2_4200	; backup R2
	ST R3, BACKUP_R3_4200	; backup R3
	ST R4, BACKUP_R4_4200	; backup R4
	ST R5, BACKUP_R5_4200	; backup R5
	ST R6, BACKUP_R6_4200	; backup R6
	ST R7, BACKUP_R7_4200	; backup R7
	
;(2) Subroutine Algorithm	
	LD 	R6, 	BUSYNESS_ADDR_MACHINE_STATUS		; load address of the Vector to R6
	LDR 	R6, R6, #0					; load vector to R6
	LD 	R5, DEC_15_4200					; set R5 to 15 , used in do while loop to shift 15 times to cover all [15:0] bits of vector 
	AND 	R2, R2, #0					; reset R2 to 0 , used as he flag to return the number of free machines
	NOT 	R1, R1						; flip R1 , 1's complement of R1
	ADD	R1, R1, #1					; add 1 ' 2' complement of R1
	ADD R5, R5, R1						; R5 <- 15 - R1 , set to left shift vector bit to get to machine R1 
	BRz SKIP_LOOP						; if user input is 15 go deal with machine [15] at skip loop 
		DO_WHILE_LOOP_4200
			ADD 	R6, R6, R6			; left shift the vector to check machine [user input]
			ADD	R5, R5, #-1			; decrement R5	until we get to desired machine										
			BRp	DO_WHILE_LOOP_4200		; iterate while R5>0 
		END_DO_WHILE_LOOP_4200
		
		ADD 	R6, R6, #0				; set to check for bit [user input]
		BRn	MACHINE_IS_FREE
			AND 	R0, R0, #0
			BR	END_SKIP_LOOP			; set R2 to 0 , machine is busy and go to the end of SR
			
		MACHINE_IS_FREE	
		ADD 	R2, R2, #1				; set R2 to 1 , machine is busy 
		BR	END_SKIP_LOOP				; go to the end of SR 
			
	SKIP_LOOP						; deal with bit [15] of vector 
		ADD 	R6, R6, #0				; use to check bit [15] of vector 
		BRn  	MACHINE_15_IS_FREE			; if [15] is 1 go to machine is free
			BR	END_SKIP_LOOP			; [15] is 0 (busy), resturn R2 = 0 
		MACHINE_15_IS_FREE
		ADD R2, R2, #1					; BIT[15] is a 1 then the machine is free, set R2 = 1 				
	END_SKIP_LOOP
	
;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_4200	; restore R0
	LD	R1, BACKUP_R1_4200	; restore R1
	;LD	R2, BACKUP_R2_4200	; restore R2
	LD	R3, BACKUP_R3_4200	; restore R3
	LD	R4, BACKUP_R4_4200	; restore R4
	LD	R5, BACKUP_R5_4200	; restore R5
	LD	R6, BACKUP_R6_4200	; restore R6	
	LD	R7, BACKUP_R7_4200	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_4200  .BLKW #1 ; original data of R0
	BACKUP_R1_4200  .BLKW #1 ; original data of R1
	;BACKUP_R2_4200  .BLKW #1 ; original data of R2
	BACKUP_R3_4200  .BLKW #1 ; original data of R3
	BACKUP_R4_4200  .BLKW #1 ; original data of R4
	BACKUP_R5_4200  .BLKW #1 ; original data of R5
	BACKUP_R6_4200  .BLKW #1 ; original data of R6
	BACKUP_R7_4200	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS	.Fill 	xCE00
DEC_15_4200			.FILL 	#15			; represents the max number of shifts to cover all bits in the vector

.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.Orig x4400

;========================
; Subroutine Instructions
;========================
	FIRST_FREE

;(1) Backup the registers the subroutine changes except Return values
	ST R0, BACKUP_R0_4400	; backup R0
	ST R1, BACKUP_R1_4400	; backup R1
	;ST R2, BACKUP_R2_4400	; backup R2
	ST R3, BACKUP_R3_4400	; backup R3
	ST R4, BACKUP_R4_4400	; backup R4
	ST R5, BACKUP_R5_4400	; backup R5
	ST R6, BACKUP_R6_4400	; backup R6
	ST R7, BACKUP_R7_4400	; backup R7
	
;(2) Subroutine Algorithm	
	LD 	R6, BUSYNESS_ADDR_FIRST_FREE		; load address of the Vector to R6
	LDR 	R6, R6, #0				; load vector to R6
	AND 	R2, R2, #0				; reset R2 to 0 , used as the flag to return the number of the lowest numbered free machine
	AND 	R3, R3, #0				; reset R3 to 0 used for powers of 10
	ADD 	R3, R3, #1				; set R3 to x0001  
	AND R4, R4, #0					; reset R4 to 0 , used to check the result of R6 and R3 is 0 or 1
	AND	R5, R5, #0				; reset R5 to 0
	ADD	R5, R5, #15				; set R5 to the length of Vector in R6
										
	DO_WHILE_LOOP_4400
		AND	R4, R6, R3			; logical AND every bit of Vector R6 with 1 
		BRnp 	END_DO_WHILE_LOOP_4400		; if R4 is 1 , return value or R2 and go to return 
		ADD	R2, R2, #1			; increment R2 by 1 each iteration
		ADD	R3, R3, R3			; left shift R3 to get powers of 10 
		ADD	R5, R5, #-1			; decrement R5 to go through all the vector
		BRzp DO_WHILE_LOOP_4400
	END_DO_WHILE_LOOP_4400
		
;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_4400	; restore R0
	LD	R1, BACKUP_R1_4400	; restore R1
	;LD	R2, BACKUP_R2_4400	; restore R2
	LD	R3, BACKUP_R3_4400	; restore R3
	LD	R4, BACKUP_R4_4400	; restore R4
	LD	R5, BACKUP_R5_4400	; restore R5
	LD	R6, BACKUP_R6_4400	; restore R6	
	LD	R7, BACKUP_R7_4400	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_4400  .BLKW #1 ; original data of R0
	BACKUP_R1_4400  .BLKW #1 ; original data of R1
	;BACKUP_R2_4400  .BLKW #1 ; original data of R2
	BACKUP_R3_4400  .BLKW #1 ; original data of R3
	BACKUP_R4_4400  .BLKW #1 ; original data of R4
	BACKUP_R5_4400  .BLKW #1 ; original data of R5
	BACKUP_R6_4400  .BLKW #1 ; original data of R6
	BACKUP_R7_4400	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill 	xCE00

.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 4
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

.Orig x4600

;========================
; Subroutine Instructions
;========================
	GET_MACHINE_NUM
	
;(1) Backup the registers the subroutine changes except Return values
	ST R0, BACKUP_R0_4600	; backup R0
	;ST R1, BACKUP_R1_4600	; backup R1
	ST R2, BACKUP_R2_4600	; backup R2
	ST R3, BACKUP_R3_4600	; backup R3
	ST R4, BACKUP_R4_4600	; backup R4
	ST R5, BACKUP_R5_4600	; backup R5
	ST R6, BACKUP_R6_4600	; backup R6
	ST R7, BACKUP_R7_4600	; backup R7
	
;(2) Subroutine Algorithm	

;-------------
;Instructions
;-------------
	START_4600					; if user enters a wrong input branch here to start over

; output intro prompt
	LEA 	R0, prompt				; load R0 with prompt to get user input
 	PUTS						; outputs the intro to console 
	
; Set up flags, counters, accumulators as needed
	AND R1, R1, #0		; reset R1 to 0
	AND R2, R2, #0		; reset R2 to 0
	AND R3, R3, #0		; reset R3 to 0
	AND R4, R4, #0		; reset R4 to 0
	AND R5, R5, #0		; reset R5 to 0
	AND R6, R6, #0		; reset R6 to 0
	;AND R7, R7, #0		; reset R7 to 0

; Get first character, test for '\n', '+', '-', digit/non-digit 
	GETC						; get the first user input character
	OUT						; outputs the character to console
	ADD	R1, R1, R0				; store user input in R1	
	LD	R2, DEC_NEG_43_4600			; R2 <- -43	
	ADD	R2, R2, R1 				; R2 <- R1 - 43 to check if a '+' is entered
	BRnp 	Not_A_Plus		
		ADD R6, R6, #1				; set a flag to get up to 5 more digits 
		BR GET_THE_REST_OF_DIGITS			
	Not_A_Plus	
				
; is it = '-'? if so, set neg flag, go get digits
	LD	R2, DEC_NEG_45_4600			; R2 <- -45
			
	ADD	R2, R2, R1 				; R2 <- R1 - 45 to check if a '-' is entered				
	BRnp	Not_A_Minus
		ADD 	R6, R6, #-1			; set a flag to go through two's complement if number is negative
							; and get up to 5 more digits		
		BR GET_THE_REST_OF_DIGITS
	Not_A_Minus
								
; if none of the above, first character is first numeric digit - deal with it!
	LD	R2, DEC_NEG_48_4600			; R2 <- -48 
	ADD	R1, R1, R2				; R1<- R1-48  convert user input from an ascii char to a digit 
	ADD	R5, R5, R1				; R5 <- R5 + R1 get first user input if a valid digit
	
; Now get (remaining) digits (max 5) from user and build up number in accumulator
	GET_THE_REST_OF_DIGITS
	ADD 	R6, R6, #0  				; check if a minus or plus is entered
	BRnp	skip					; if it is negative or positive go to skip
		ADD 	R3, R3, #4			; set R3 to 4 to get the last 4 digits
		BR 	END_skip	
	skip
		ADD 	R3, R3, #5			; set R3 to 5 to get the last 5 digits
	END_skip

	DO_WHILE_LOOP
		AND	R1, R1, #0			; reset R1 to 0 
		AND 	R2, R2, #0			; reset R2 to 0	
		GETC					; get the first user input character
		OUT					; outputs the character to console	
		ADD	R1, R1, R0			; store user input in R1	
		
		; is it the terminate character = '\n'? if so, quit the do while loop!
		ADD	R2, R1, #-10			; R2 <- R1 - 10 to check if a new line is entered 
		BRz	END_DO_WHILE_LOOP		; quit the loop if user input is enter.	
			AND 	R2, R2, #0		; reset R2 to 0
			ADD	R2, R2, R5		; R2 <-  R5  value to be added 10 times
			LD 	R4, DEC_9_4600		;set R4 to 9 to multiply by 10
			
			DO_WHILE_LOOP_A
				ADD 	R5, R5, R2  	; R5 <- R5 + R2 (multiply by 10)	
				ADD 	R4, R4, #-1	; decrement for inner do while loop to 9 times
				BRp	DO_WHILE_LOOP_A
			END_DO_WHILE_LOOP_A
		
		LD	R2, DEC_NEG_48_4600		; R2 <- -48 
		ADD	R1, R1, R2			; R1<- R1-48  convert user input from an ascii char to a digit 
		ADD	R5, R5, R1			; add the digit intered to the value of R5 
		ADD R3, R3, #-1				; decrement R3 for the number of digits 
		BRp DO_WHILE_LOOP
		
	END_DO_WHILE_LOOP	
	
	ADD 	R6, R6, #0				; check if negative number to branch
	BRzp 	quit					; if negative input then 2's complement otherwise no 
		LEA	R0, Error_msg_2			; point to error message to be displayed 
		PUTS					; outputs the error message to console
		BR START_4600				; number is negative, go back to start
	quit						; if user input is = or > 0 , we need to check if it is < then 15 
	AND	R3, R3, #0				; reset R3 to 0 
	ADD 	R3, R5, #-15				; R3 <- R5 - 15 
	BRnz 	INPUT_IS_VALID				; if input < or = 15 
		LEA	R0, Error_msg_2			; point to error message to be displayed 
		PUTS					; outputs the error message to console
		BR START_4600				; number is > 15, go back to start
			
	INPUT_IS_VALID
	AND	R1, R1, #0				; reset R3 to 0
	ADD 	R1, R1, R5				; put the value of input from R5 to R1 as the return value
					
;(3) Restore the registers that you backed up

	LD	R0, BACKUP_R0_4600	; restore R0
	;LD	R1, BACKUP_R1_4600	; restore R1
	LD	R2, BACKUP_R2_4600	; restore R2
	LD	R3, BACKUP_R3_4600	; restore R3
	LD	R4, BACKUP_R4_4600	; restore R4
	LD	R5, BACKUP_R5_4600	; restore R5
	LD	R6, BACKUP_R6_4600	; restore R6	
	LD	R7, BACKUP_R7_4600	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_4600  .BLKW #1 ; original data of R0
	;BACKUP_R1_4600  .BLKW #1 ; original data of R1
	BACKUP_R2_4600  .BLKW #1 ; original data of R2
	BACKUP_R3_4600  .BLKW #1 ; original data of R3
	BACKUP_R4_4600  .BLKW #1 ; original data of R4
	BACKUP_R5_4600  .BLKW #1 ; original data of R5
	BACKUP_R6_4600  .BLKW #1 ; original data of R6
	BACKUP_R7_4600	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine GET_MACHINE_NUM
;--------------------------------

DEC_9_4600		.FILL	#9		; set to multiply a number by 10 
DEC_NEG_43_4600		.FILL	#-43		; to check for '+' input
DEC_NEG_45_4600		.FILL	#-45		; to check for '-' input
DEC_NEG_48_4600		.FILL	#-48		; to check for invalid input less then 0
DEC_NEG_57_4600		.FILL	#-57		; to check for invalid input greater then 9 	

prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"

.END	; ends subroutine
;================================================================================================================

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string
; Return Value : R1 (unchanged from input)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;-------------------------------

.Orig x4800

;========================
; Subroutine Instructions
;========================
	PRINT_NUM

;(1) Backup the registers the subroutine changes except Return values

	ST R0, BACKUP_R0_4800	; backup R0
	ST R1, BACKUP_R1_4800	; backup R1
	ST R2, BACKUP_R2_4800	; backup R2
	ST R3, BACKUP_R3_4800	; backup R3
	ST R4, BACKUP_R4_4800	; backup R4
	ST R5, BACKUP_R5_4800	; backup R5
	ST R6, BACKUP_R6_4800	; backup R6
	ST R7, BACKUP_R7_4800	; backup R7
	
;(2) Subroutine Algorithm
	AND 	R0, R0, #0 			; reset R0 to 0
	AND	R3, R3, #0 			; reset R3 to 0 
	AND 	R4, R4, #0 			; reset R4 to 0 
		
	LD 	R4, ASCII_NUM			; R4 <- 48	, convert number to ascii character  
	
	ADD	R3, R1, #-10			; R3 <- R1 - 10				
	BRn	NUM_IS_ONE_DIGIT		; if number is one digit jump 
		ADD	R0, R4, #1		; R0 = 49 
		OUT				; output the character 1 to console
		
		ADD R4, R4, #-10		; deduct 10 to get the last digit 
		ADD R0, R1, R4			; R0 <- R1 + 48 , 
		OUT				; output the digit to console as an ascii character
		
		BR END_NUM_IS_ONE_DIGIT 
	
	NUM_IS_ONE_DIGIT
		ADD R0, R1, R4			; R0 <- R1 + 48 , 
		OUT				; output the digit to console as an ascii character
	END_NUM_IS_ONE_DIGIT
	
;(3) Restore the registers that you backed up
	LD	R0, BACKUP_R0_4800	; restore R0
	LD	R1, BACKUP_R1_4800	; restore R1
	LD	R2, BACKUP_R2_4800	; restore R2
	LD	R3, BACKUP_R3_4800	; restore R3
	LD	R4, BACKUP_R4_4800	; restore R4
	LD	R5, BACKUP_R5_4800	; restore R5
	LD	R6, BACKUP_R6_4800	; restore R6	
	LD	R7, BACKUP_R7_4800	; restore R7

;(4) RET - i.e. return to where you came from
; use the starting address as part of the sub name
	RET
	
;========================
; Subroutine Data
;========================
	BACKUP_R0_4800  .BLKW #1 ; original data of R0
	BACKUP_R1_4800  .BLKW #1 ; original data of R1
	BACKUP_R2_4800  .BLKW #1 ; original data of R2
	BACKUP_R3_4800  .BLKW #1 ; original data of R3
	BACKUP_R4_4800  .BLKW #1 ; original data of R4
	BACKUP_R5_4800  .BLKW #1 ; original data of R5
	BACKUP_R6_4800  .BLKW #1 ; original data of R6
	BACKUP_R7_4800	.BLKW #1 ; original data of R7

;--------------------------------
;Data for subroutine print number
;--------------------------------
	ASCII_NUM		.FILL	#48		; represents 0 in ascii character

.END	; ends subroutine
;===========================================================================================================

#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
    
RES_VECT  CODE    0x0000            ; processor reset vector
    
  
    GOTO    START                             ; go to beginning of program

INT_VECT CODE 0x004 
	DECFSZ cont
	GOTO $+7
	CALL NOTAS
	INCF nota
	MOVLW d'8' ; 50mS * value
	MOVWF cont
	MOVLW d'190' ; preload value
	MOVWF TMR0
	BCF INTCON, T0IF ; clr TMR0 interrupt flag
	RETFIE ; return from interrupt
	    
MAIN_PROG CODE                      ; let linker place main program
 
i equ 0x30
j equ 0x31
k equ 0x32
nota equ 0x33
cont equ 0x34
b1 equ 0x35
b2 equ 0x36
b3 equ 0x37
 
START     
    MOVLW 0x07
    MOVWF CMCON
    BSF STATUS, RP0
    MOVLW 0x00
    MOVWF TRISA
    MOVWF TRISB
    MOVLW b'10000111'
    MOVWF OPTION_REG
    BCF STATUS, RP0
    BSF INTCON, GIE
    BSF INTCON, T0IE
    BCF INTCON, T0IF
    MOVLW d'60'		
    MOVWF TMR0
    MOVLW d'10'		
    MOVWF cont
    BCF PORTA,1
    BCF PORTA,0
    CLRF nota
    
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
INICIO    
    BCF PORTA,3
    CALL TIEMPO
    BSF PORTA,3
    nop
    nop
    CALL TIEMPO
    GOTO INICIO

TIEMPO
    MOVFW b1
    MOVWF i
LOOPJ
    MOVFW b2
    MOVWF j
LOOPK
    DECFSZ j,f
    GOTO LOOPK
    DECFSZ i,f
    GOTO LOOPJ
    MOVFW b3
    MOVWF k
    DECFSZ k
    GOTO $-1
    RETURN
	    
	    
NOTAS ;Notas para reproducir la cancion
    MOVFW nota
    XORLW d'25'
    BTFSS STATUS,Z
    GOTO $+2
    CLRF nota    
    
    ;Do			;Primer Verso
    MOVFW nota
    XORLW d'0'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do
    CALL DO 
    MOVFW nota
    XORLW d'1'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Re
    CALL DO
    MOVFW nota
    XORLW d'2'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'23'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do
    CALL RE
    MOVFW nota
    XORLW d'3'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Fa
    CALL DO
    MOVFW nota
    XORLW d'4'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'19'
    MOVWF b2
    MOVLW d'6'
    MOVWF b3
    RETURN
    ;Mi
    CALL FA
    MOVFW nota
    XORLW d'5'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'20'
    MOVWF b2
    MOVLW d'12'
    MOVWF b3
    RETURN
    ;Do			;Segundo Verso
    CALL MI
    MOVFW nota
    XORLW d'6'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do
    CALL DO
    MOVFW nota
    XORLW d'7'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Re
    CALL DO
    MOVFW nota
    XORLW d'8'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'23'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do
    CALL RE
    MOVFW nota
    XORLW d'9'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Sol
    CALL DO
    MOVFW nota
    XORLW d'10'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'16'
    MOVWF b2
    MOVLW d'23'
    MOVWF b3
    RETURN
    ;Fa
    CALL SOL
    MOVFW nota
    XORLW d'11'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'19'
    MOVWF b2
    MOVLW d'6'
    MOVWF b3
    RETURN
    
    ;Do			;Tercer Verso
    CALL FA
    MOVFW nota
    XORLW d'12'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do
    CALL DO
    MOVFW nota
    XORLW d'13'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    ;Do6
    CALL DO
    MOVFW nota
    XORLW d'14'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'11'
    MOVWF b1
    MOVLW d'26'
    MOVWF b2
    MOVLW d'15'
    MOVWF b3
    RETURN
    ;La
    CALL DO6
    MOVFW nota
    XORLW d'15'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'14'
    MOVWF b2
    MOVLW d'23'
    MOVWF b3
    RETURN
    ;Fa
    CALL LA
    MOVFW nota
    XORLW d'16'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'19'
    MOVWF b2
    MOVLW d'6'
    MOVWF b3
    RETURN
    ;Mi
    CALL FA
    MOVFW nota
    XORLW d'17'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'20'
    MOVWF b2
    MOVLW d'12'
    MOVWF b3
    RETURN
    ;Re
    CALL MI
    MOVFW nota
    XORLW d'18'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'23'
    MOVWF b2
    MOVLW d'5'
    MOVWF b3
    RETURN
    
    ;SiBe		    ;Cuarto Verso
    CALL RE
    MOVFW nota
    XORLW d'19'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'12'
    MOVWF b2
    MOVLW d'48'
    MOVWF b3
    RETURN
    ;SiBe
    CALL SIBE
    MOVFW nota
    XORLW d'20'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'12'
    MOVWF b2
    MOVLW d'48'
    MOVWF b3
    RETURN
    ;La
    CALL SIBE
    MOVFW nota
    XORLW d'21'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'14'
    MOVWF b2
    MOVLW d'23'
    MOVWF b3
    RETURN
    ;Fa
    CALL LA
    MOVFW nota
    XORLW d'22'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'19'
    MOVWF b2
    MOVLW d'6'
    MOVWF b3
    RETURN
    ;Sol
    CALL FA
    MOVFW nota
    XORLW d'23'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'16'
    MOVWF b2
    MOVLW d'23'
    MOVWF b3
    RETURN
    ;Fa
    CALL SOL
    MOVFW nota
    XORLW d'24'
    BTFSS STATUS,Z 
    GOTO $+8
    MOVLW d'23'
    MOVWF b1
    MOVLW d'19'
    MOVWF b2
    MOVLW d'6'
    MOVWF b3
    RETURN
    CALL FA
    
DO
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
RE
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
FA
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN

MI 
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'M'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
SOL
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
DO6
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
LA 
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
SIBE
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x87		;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    RETURN
    
Borrar
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    RETURN
   
    
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    END
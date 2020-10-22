PAGE 60,120
TITLE PANTALLA

DATOS SEGMENT PARA PUBLIC 'DATA'
	A	DB ' **  $'
	B	DB '  *  $'
	C	DB '  *  $'
	D	DB '  *  $'
	E	DB '*****$'

	F	DB '    *$'
	G	DB '*    $'
		
	H	DB '*   *$'
	I	DB '     $'
	J	DB '*$'
	K	DB 'El programa ha terminado...$'
	L	DB 'Presione una tecla para continuar$'
	FAC1	DB 'Facultad$'
	FAC2	DB 'Ingenieria en Computacion$'
	FAC3	DB 'Materia Ensamblador$'
	FAC4	DB 'Miembros del equipo:$'
	FAC5	DB 'Nombre1$'
	FAC6	DB 'Nombre2$'
	FAC7	DB '-------------------$'
	FAC8	DB 'Ciclo escolar$'
	LET6	DB 'Presiona una tecla para continuar...$'
	BIENV	DB 'BIENVENIDO AL PROGRAMA DE RELOJ$'
	LET4	DB 'Desea volver a usar el programa?  S/N$'
	DET	DB 'Para detener el reloj presiona ENTER$'

DATOS ENDS

PILA SEGMENT PARA STACK 'STACK'
        DB 64 DUP (0)
PILA ENDS

CODIGO SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CODIGO,SS:PILA,DS:DATOS
    MAIN PROC FAR
    INI:PUSH DS
	SUB AX,AX
	PUSH AX

	MOV AX,DATOS
	MOV DS,AX


	CALL LIMPIA	   ;llama al subprograma para limpiar pantalla

	MOV DH,02
	MOV DL,21
	CALL CURSOR
	MOV DX,OFFSET FAC1
	CALL LET

	MOV DH,05
	MOV DL,20
	CALL CURSOR
	MOV DX,OFFSET FAC2
	CALL LET


	MOV DH,08
	MOV DL,32
	CALL CURSOR
	MOV DX,OFFSET FAC3
	CALL LET


	MOV DH,11
	MOV DL,32
	CALL CURSOR
	MOV DX,OFFSET FAC4
	CALL LET


	MOV DH,13
	MOV DL,30
	CALL CURSOR
	MOV DX,OFFSET FAC5
	CALL LET


	MOV DH,15
	MOV DL,31
	CALL CURSOR
	MOV DX,OFFSET FAC6
	CALL LET


	MOV DH,18
	MOV DL,31
	CALL CURSOR
	MOV DX,OFFSET FAC7
	CALL LET


	MOV DH,21
	MOV DL,35
	CALL CURSOR
	MOV DX,OFFSET FAC8
	CALL LET

	MOV DH,23
	MOV DL,35
	CALL CURSOR
	MOV DX,OFFSET LET6
	CALL LET

	MOV AH,1
	INT 21H

	CALL LIMPIA

	MOV DH,10
	MOV DL,23
	CALL CURSOR
	MOV DX,OFFSET BIENV
	CALL LET


	MOV DH,18
	MOV DL,28
	CALL CURSOR
	MOV DX,OFFSET LET6
	CALL LET

	MOV AH,01
	INT 21H

@DOS:	CALL LIMPIA

	MOV CX,50
	JMP PID

   PID:	MOV AH,2CH	   ;pide la hora al sistema
	INT 21H		   ;Llama interrupcion 21H
	MOV AH,CH	   ;guardar horas en registro AH
	MOV BL,18
	CALL CONV

	PUSH DX
	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,31	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET J    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	POP DX

	PUSH DX
	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,31	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET J    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	POP DX

	JMP @SSE

@UNO:	JMP @DOS


@SSE:	MOV AH,CL	   ;guarda minutos en registo AH
	MOV BL,34
	CALL CONV

	PUSH DX
	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,47	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET J    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	POP DX

	PUSH DX
	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,47	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET J    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	POP DX

	MOV AH,DH	   ;guarda segundos en registro AH
	MOV BL,50
	CALL CONV

	MOV DH,09
	MOV DL,23
	CALL CURSOR
	MOV DX,OFFSET DET	;letrero de ENTER
	CALL LET

	MOV AH,06H
	MOV DL,0FFH
	INT 21H
	CMP AL,0DH
	JE END
	LOOP PID

    END:MOV DH,12	   ;numero de fila donde se pondra el cursor
	MOV DL,31	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET K    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,14	   ;numero de fila donde se pondra el cursor
	MOV DL,31	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET L    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

@ET:	MOV DH,16	   ;numero de fila donde se pondra el cursor
	MOV DL,28	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET LET4    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	
	MOV AH,01
	INT 21H

	CMP AL,'S'
	JE @UNO

	CMP AL,'N'
	JNE @ET

	MOV DH,18
	MOV DL,31
	CALL CURSOR
	MOV DX,OFFSET LET6
	CALL LET

	MOV AH,01
	INT 21H

	RET
    MAIN ENDP



    LET PROC NEAR	   ;subprograma para imprimir cadena
	MOV AH,09
	INT 21H
	RET
    LET ENDP


;---conversion---

    CONV PROC NEAR
	PUSH AX
	PUSH DX
	MOV AL,'0'
    CO:	CMP AH,10
    	JL FIN
	INC AL
	SUB AH,10
	JMP CO
    FIN:ADD AH,30H
	PUSH AX
	
;---se comparan decenas---

	MOV DL,AL

	CMP DL,'0'
	JE CERO

	CMP DL,'1'
	JE UNO

	CMP DL,'2'
	JE DOS

	CMP DL,'3'
	JE TRES

	CMP DL,'4'
	JE CUATRO

	CMP DL,'5'
	JE CINCO

	CMP DL,'6'
	JE SEIS

;---se llaman letreros---
   CERO: CALL ZERO
	JMP POP

   UNO: CALL ONE
	JMP POP

   DOS: CALL TWO
	JMP POP

   TRES: CALL THREE
	JMP POP

   CUATRO: CALL FOUR
	JMP POP

   CINCO: CALL FIVE
	JMP POP

   SEIS: CALL SIX
	JMP POP


   POP:	POP AX ;Restaura el registro AX
	ADD BL,6
	MOV DL,AH
	
	CMP DL,'0'
	JE CE

	CMP DL,'1'
	JE UN

	CMP DL,'2'
	JE DO

	CMP DL,'3'
	JE TR

	CMP DL,'4'
	JE CUA

	CMP DL,'5'
	JE CIN

	CMP DL,'6'
	JE SEI

	CMP DL,'7'
	JE SIE

	CMP DL,'8'
	JE OCH

	CMP DL,'9'
	JE NUE


;---se llaman letreros para unidades
   CE: CALL ZERO
	JMP REST

   UN: CALL ONE
	JMP REST

   DO: CALL TWO
	JMP REST

   TR: CALL THREE
	JMP REST

   CUA:CALL FOUR
	JMP REST

   CIN:CALL FIVE
	JMP REST

   SEI: CALL SIX
	JMP REST

   SIE:	CALL SEVEN
	JMP REST

   OCH:	CALL EIGHT
	JMP REST

   NUE:	CALL NINE
	JMP REST


   REST:POP DX ;Restaura los registros
	POP AX ;
	
       FFF:RET
   CONV ENDP


;---numero cero--

   ZERO PROC NEAR
 	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   ZERO ENDP


;---numero uno---

   ONE PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET A    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET B    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET C    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET D    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   ONE ENDP


;---numero dos---

   TWO PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET G    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
    TWO ENDP	

;---numero tres---

    THREE PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
    THREE ENDP

;---numero cuatro---
   FOUR PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   FOUR ENDP

;numero cinco---
   FIVE PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET G    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   FIVE ENDP

;---numero seis---
    SIX PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET G    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   SIX ENDP


;---numero siete
   SEVEN PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   SEVEN ENDP

;---numero ocho---
   EIGHT PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   EIGHT ENDP

;---numero nueve---
   NINE PROC NEAR
	MOV DH,01	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,02	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET H    ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,03	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,04	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET F  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena

	MOV DH,05	   ;numero de fila donde se pondra el cursor
	MOV DL,BL	   ;numero de coluna donde se pondra el cursor
	CALL CURSOR	   ;llama al subprograma para colocar el cursor
	MOV DX,OFFSET E  ;se obtiene la direccion de la cadena
	CALL LET	   ;llama al subprograma para imprimir la cadena
	RET
   NINE ENDP



    CURSOR PROC NEAR	   ;subprograma para colocar el cursor
	MOV AH,02
	MOV BH,00
	INT 10H
	RET
    CURSOR ENDP

    LIMPIA PROC NEAR	   ;subprograma para limpiar pantalla
	MOV AH,06
	MOV AL,0
	MOV CX,0
	MOV DH,26
	MOV DL,79
	MOV BH,17H	   ;color de pantalla y de letra
	INT 10H
	RET
    LIMPIA ENDP
CODIGO ENDS
    END INI

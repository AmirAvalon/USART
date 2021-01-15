.include "m32def.inc"

.ORG 0
 RJMP main

.ORG $002
 RJMP send
.ORG $100
main:
	LDI R16,$40
	LDI R17,$01
	LDI R18,$08
	LDI R19,$A6
	CLR R20

	LDI R22,$0F
	LDI R23,$02
	LDI R24,$03

	MOV R0,R22
	MOV R1,R23
	MOV R2,R24

	OUT UCSRA,R20
	OUT UCSRB,R18
	OUT UCSRC,R19

	OUT GICR,R16
	OUT MCUCR,R17

	LDI R21,$02
	OUT UBRRH,R20
	OUT UBRRL,R21

	SBI DDRD,2
	
	SEI

wait: RJMP wait

send:
	LD R20,Z+
	loop:
		SBIS UCSRA,5
		RJMP loop
		OUT UDR,R20
		RETI
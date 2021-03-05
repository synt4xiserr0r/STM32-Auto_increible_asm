;Declaración de variable
D	EQU		0x00000001
	

;Configuración para habilitar puertos
RCC_BASE		EQU		0x40023800	;RCC_Base son los registros relacionados a la ocnfiguración de Reset y Relojes		
RCC_AHB1ENR		EQU		0x40023830	;RCC_BASE + 0x30 Registro para habilitar el reloj de los perifericos

;Offset para habilitar puerto D	
GPIODEN			EQU		1 << 3	


;Bases para los GPIO  D (para establecer el modo el cual tiene offset 0x00)
GPIOD_BASE		EQU		0x40020C00	
		
;00: Input (reset state)
;01: General purpose output mode

	
;Registro para escribir datos en puerto D
GPIOD_ODR		EQU		(GPIOD_BASE|0x14)	

;Tiempo para el delay
DELAY			EQU		0x000F

;
ONESEC			EQU		5333333
HSEC			EQU		266667
FSEC			EQU		106667
	
	
			AREA	|.text|,CODE,READONLY,ALIGN=2
			THUMB
			EXPORT	__main
				
__main

			BL			GPIOD_Init	;Ir a subrutina GPIOD_Init
			
	

GPIOD_Init
			LDR		R0,=RCC_AHB1ENR ; R0 apunta a la dirección del registro de reloj de perifericos
									;LDR	R1,RCC_AHB1ENR	; R1=contenido de la dirección a la que apunta R0	
			ORR		R1,#GPIODEN
			STR		R1,[R0]			; Guarda el contenido de R1 en la dirección a la que apunta R0
			
			;Puerto D
			LDR		R0,=GPIOD_BASE	; R0 apunta a la dirección del registro de configuración del puerto B
			LDR		R1,=0x155555	; Pines del 0 al 09 en modo output 
			STR		R1,[R0]			; Carga en la dirección a la apunta R0, el resultado de R1 (para habilitar modos)						
			
			;Direcciones de inputs and outputs
			LDR		R4,= GPIOD_ODR	; Carga en R2 la dirección del registro IDR 
				
		

Auto_Increible
		
		LDR 	R6,=D
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
	
		LDR		R6,=(D<<1)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<2)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<3)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<4)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<5)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay

		LDR		R6,=(D<<6)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<7)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay

		LDR		R7,=80
		CMP		R7,R6
		BNE		Inv_Auto_Increible
		

		
				
Inv_Auto_Increible

		LDR		R6,=(D<<6)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay

		LDR		R6,=(D<<5)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<4)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<3)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay

		LDR		R6,=(D<<2)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R6,=(D<<1)
		STR		R6,[R4]
		LDR		R5,=HSEC
		BL		Delay
		
		LDR		R7,=80
		CMP		R7,R6
		BNE		Auto_Increible
		

;Subrutina para realizar un delay			
Delay
			SUBS	R5,R5,#1	;R3=R3-1
			BNE		Delay		;Si resultado es dif de 0, salta a Delay
			BX		LR			;Si resultado=0, entonces regresa de la subrutina
			ALIGN
			END
			
		

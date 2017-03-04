
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,46 :: 		void interrupt(){
;MyProject.c,47 :: 		contagem++;                            //para cada interrpção do TIMER1 incrementa a variável contagem
	INCF       _contagem+0, 1
;MyProject.c,48 :: 		TMR1L=0xDC;                            //recarrega o TMR1L;
	MOVLW      220
	MOVWF      TMR1L+0
;MyProject.c,49 :: 		TMR1H=0x0B;                            //recarrega o TMR1H;
	MOVLW      11
	MOVWF      TMR1H+0
;MyProject.c,50 :: 		PIR1.TMR1IF = 0;                       //limpa o overflow.
	BCF        PIR1+0, 0
;MyProject.c,51 :: 		}
L_end_interrupt:
L__interrupt22:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_init:

;MyProject.c,53 :: 		char init(){
;MyProject.c,54 :: 		char *ok = "OK";
	MOVLW      ?lstr1_MyProject+0
	MOVWF      init_ok_L0+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      init_error_L0+0
;MyProject.c,57 :: 		TRY
	MOVF       PCLATH+0, 0
	MOVWF      R1+0
	MOVLW      2
	ADDWF      PCL+0, 0
	MOVWF      R1+1
	CLRF       R1+2
	GOTO       L_init3
L_init5:
;MyProject.c,60 :: 		TRISA = 0;
	CLRF       TRISA+0
;MyProject.c,61 :: 		PORTA = 0;
	CLRF       PORTA+0
;MyProject.c,63 :: 		TRISB = 0;
	CLRF       TRISB+0
;MyProject.c,64 :: 		TRISB.b6 = 1;
	BSF        TRISB+0, 6
;MyProject.c,65 :: 		TRISB.b7 = 1;
	BSF        TRISB+0, 7
;MyProject.c,66 :: 		PORTB = 0;
	CLRF       PORTB+0
;MyProject.c,68 :: 		TRISC = 0;
	CLRF       TRISC+0
;MyProject.c,69 :: 		PORTC= 0;
	CLRF       PORTC+0
;MyProject.c,71 :: 		TRISD = 0;
	CLRF       TRISD+0
;MyProject.c,72 :: 		PORTD = 0;
	CLRF       PORTD+0
;MyProject.c,74 :: 		ADCON1 = 0x0F;                        //configura todos pinos A/D como I/O de uso geral
	MOVLW      15
	MOVWF      ADCON1+0
;MyProject.c,82 :: 		INTCON.GIE=1;                          //habilita interrupção global
	BSF        INTCON+0, 7
;MyProject.c,83 :: 		INTCON.PEIE=1;                         //habilita interrupção dos perifericos
	BSF        INTCON+0, 6
;MyProject.c,84 :: 		PIE1.TMR1IE=1;                         //habilita interrupção do TIMER1
	BSF        PIE1+0, 0
;MyProject.c,86 :: 		TMR1L=0xDC;                            // byte menos significativo
	MOVLW      220
	MOVWF      TMR1L+0
;MyProject.c,87 :: 		TMR1H=0x0B;                            // byte mais significativo
	MOVLW      11
	MOVWF      TMR1H+0
;MyProject.c,88 :: 		T1CON=0b00110001;                      // Modo Temporizador, prescaler 1:4, clock interno
	MOVLW      49
	MOVWF      T1CON+0
;MyProject.c,90 :: 		contagem = 0;
	CLRF       _contagem+0
;MyProject.c,91 :: 		segundo = 0;
	CLRF       _segundo+0
;MyProject.c,92 :: 		minuto = 0;
	CLRF       _minuto+0
;MyProject.c,93 :: 		hora = 0;
	CLRF       _hora+0
;MyProject.c,96 :: 		EXCEPT(EXCEPTION_1)
	GOTO       L_init7
L_init8:
;MyProject.c,98 :: 		return error;
	MOVF       init_error_L0+0, 0
	MOVWF      R0+0
	GOTO       L_end_init
;MyProject.c,100 :: 		ETRY;
L_init7:
	GOTO       L_init4
L_init3:
	MOVF       R1+2, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_init5
	MOVF       R1+2, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_init8
L_init4:
;MyProject.c,101 :: 		return ok;
	MOVF       init_ok_L0+0, 0
	MOVWF      R0+0
;MyProject.c,102 :: 		}
L_end_init:
	RETURN
; end of _init

_main:

;MyProject.c,104 :: 		void main(){
;MyProject.c,106 :: 		char *ok = "OK";
	MOVLW      ?lstr3_MyProject+0
	MOVWF      main_ok_L0+0
;MyProject.c,110 :: 		do{
L_main9:
;MyProject.c,111 :: 		str = init();
	CALL       _init+0
;MyProject.c,112 :: 		res = strncmp(ok, str, 2);
	MOVF       main_ok_L0+0, 0
	MOVWF      FARG_strncmp_s1+0
	MOVF       R0+0, 0
	MOVWF      FARG_strncmp_s2+0
	MOVLW      2
	MOVWF      FARG_strncmp_len+0
	CALL       _strncmp+0
;MyProject.c,113 :: 		}while (res != 0);
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;MyProject.c,115 :: 		while(true)
L_main12:
;MyProject.c,117 :: 		if (contagem == 10){
	MOVF       _contagem+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;MyProject.c,118 :: 		segundo++;
	INCF       _segundo+0, 1
;MyProject.c,119 :: 		contagem = 0;
	CLRF       _contagem+0
;MyProject.c,120 :: 		}
L_main14:
;MyProject.c,122 :: 		if (segundo == 60){
	MOVF       _segundo+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;MyProject.c,123 :: 		minuto++;
	INCF       _minuto+0, 1
;MyProject.c,124 :: 		segundo = 0;
	CLRF       _segundo+0
;MyProject.c,125 :: 		}
L_main15:
;MyProject.c,127 :: 		if (minuto == 60){
	MOVF       _minuto+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;MyProject.c,128 :: 		hora++;
	INCF       _hora+0, 1
;MyProject.c,129 :: 		minuto = 0;
	CLRF       _minuto+0
;MyProject.c,130 :: 		}
L_main16:
;MyProject.c,132 :: 		if (hora == 24)
	MOVF       _hora+0, 0
	XORLW      24
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;MyProject.c,133 :: 		hora = 0;
	CLRF       _hora+0
L_main17:
;MyProject.c,135 :: 		PORTD = segundo;
	MOVF       _segundo+0, 0
	MOVWF      PORTD+0
;MyProject.c,136 :: 		PORTC = minuto;
	MOVF       _minuto+0, 0
	MOVWF      PORTC+0
;MyProject.c,137 :: 		PORTB = hora;
	MOVF       _hora+0, 0
	MOVWF      PORTB+0
;MyProject.c,150 :: 		if ((Button (&PORTB, 6, 250, 1)))
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      250
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
;MyProject.c,151 :: 		minuto++;
	INCF       _minuto+0, 1
	GOTO       L_main19
L_main18:
;MyProject.c,153 :: 		else if ((Button (&PORTB, 7, 250, 1)))
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      250
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main20
;MyProject.c,154 :: 		hora++;
	INCF       _hora+0, 1
L_main20:
L_main19:
;MyProject.c,155 :: 		}
	GOTO       L_main12
;MyProject.c,156 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

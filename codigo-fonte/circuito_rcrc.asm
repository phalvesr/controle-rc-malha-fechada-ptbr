
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,41 :: 		void interrupt() {
;circuito_rcrc.c,43 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,44 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,45 :: 		pinoDebug = !pinoDebug;
	MOVLW      1
	XORWF      PORTC+0, 1
;circuito_rcrc.c,46 :: 		}
L_interrupt0:
;circuito_rcrc.c,48 :: 		}
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

_main:

;circuito_rcrc.c,51 :: 		void main() {
;circuito_rcrc.c,53 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,54 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,55 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,56 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,57 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
;circuito_rcrc.c,58 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,60 :: 		while(1) {
L_main2:
;circuito_rcrc.c,62 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,64 :: 		switch(selecaoModo) {
	GOTO       L_main4
;circuito_rcrc.c,65 :: 		case 0:
L_main6:
;circuito_rcrc.c,66 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,67 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,68 :: 		Lcd_Chr (1,4, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,69 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,70 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,71 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,72 :: 		break;
	GOTO       L_main5
;circuito_rcrc.c,73 :: 		case 1:
L_main7:
;circuito_rcrc.c,74 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,75 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,76 :: 		Lcd_Chr (1,4, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,77 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,78 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,79 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,80 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,81 :: 		break;
	GOTO       L_main5
;circuito_rcrc.c,82 :: 		case 2:
L_main8:
;circuito_rcrc.c,83 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,84 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,85 :: 		Lcd_Chr (1,4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,86 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,87 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,88 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,89 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,90 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,91 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,92 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,93 :: 		break;
	GOTO       L_main5
;circuito_rcrc.c,94 :: 		}
L_main4:
	MOVF       _selecaoModo+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVF       _selecaoModo+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _selecaoModo+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main8
L_main5:
;circuito_rcrc.c,96 :: 		}
	GOTO       L_main2
;circuito_rcrc.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,99 :: 		void configurarRegistradores() {
;circuito_rcrc.c,103 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,104 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,105 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,106 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,107 :: 		ADCON1 = 0b00001110;
	MOVLW      14
	MOVWF      ADCON1+0
;circuito_rcrc.c,108 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,109 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,111 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,112 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,113 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,117 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,118 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;circuito_rcrc.c,119 :: 		OPTION_REG = 0b10000000; // Ultimos 3 bits setam o prescaler:
	MOVLW      128
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,137 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,139 :: 		void iniciarLcd() {
;circuito_rcrc.c,140 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,141 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,142 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,143 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,144 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,145 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,147 :: 		void iniciarPwm() {
;circuito_rcrc.c,148 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,149 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,150 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,151 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,153 :: 		void testarBotoes() {
;circuito_rcrc.c,155 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes9
;circuito_rcrc.c,156 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,157 :: 		}
L_testarBotoes9:
;circuito_rcrc.c,159 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes12
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes12
L__testarBotoes20:
;circuito_rcrc.c,160 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,161 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,163 :: 		}
L_testarBotoes12:
;circuito_rcrc.c,165 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes13
;circuito_rcrc.c,166 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,167 :: 		}
L_testarBotoes13:
;circuito_rcrc.c,169 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes16
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes16
L__testarBotoes19:
;circuito_rcrc.c,170 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,171 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,172 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,173 :: 		}
L_testarBotoes16:
;circuito_rcrc.c,175 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes17
;circuito_rcrc.c,176 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,177 :: 		}
L_testarBotoes17:
;circuito_rcrc.c,178 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes18
;circuito_rcrc.c,179 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,180 :: 		}
L_testarBotoes18:
;circuito_rcrc.c,181 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

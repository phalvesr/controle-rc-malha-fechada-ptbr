
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,79 :: 		void interrupt() {
;circuito_rcrc.c,82 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,83 :: 		auxiliarContagemTimerZero++;
	INCF       _auxiliarContagemTimerZero+0, 1
;circuito_rcrc.c,84 :: 		if (dentroDoMenuUm) {
	BTFSS      _flagsA+0, 6
	GOTO       L_interrupt1
;circuito_rcrc.c,85 :: 		flagCalculoControlador = 1;
	BSF        _flagsB+0, 1
;circuito_rcrc.c,86 :: 		}
L_interrupt1:
;circuito_rcrc.c,89 :: 		if (auxiliarContagemTimerZero == 10) {
	MOVF       _auxiliarContagemTimerZero+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;circuito_rcrc.c,90 :: 		acoesACadaCemMs();
	CALL       _acoesACadaCemMs+0
;circuito_rcrc.c,92 :: 		auxiliarContagemTimerZero = 0;
	CLRF       _auxiliarContagemTimerZero+0
;circuito_rcrc.c,93 :: 		}
L_interrupt2:
;circuito_rcrc.c,97 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,98 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,99 :: 		}
L_interrupt0:
;circuito_rcrc.c,101 :: 		}
L_end_interrupt:
L__interrupt56:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;circuito_rcrc.c,105 :: 		void main() {
;circuito_rcrc.c,107 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,108 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,109 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,110 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,111 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
;circuito_rcrc.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,114 :: 		while(1) {
L_main4:
;circuito_rcrc.c,116 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,117 :: 		switch(selecaoModo) {
	GOTO       L_main6
;circuito_rcrc.c,118 :: 		case 0:
L_main8:
;circuito_rcrc.c,119 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,120 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,121 :: 		Lcd_Chr (1,6, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,122 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,123 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,124 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,126 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main9
;circuito_rcrc.c,127 :: 		dentroDoMenuUm = 1;
	BSF        _flagsA+0, 6
;circuito_rcrc.c,128 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,129 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,130 :: 		menuVout();
	CALL       _menuVout+0
;circuito_rcrc.c,131 :: 		}
L_main9:
;circuito_rcrc.c,133 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,134 :: 		case 1:
L_main10:
;circuito_rcrc.c,135 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,136 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,137 :: 		Lcd_Chr (1,4, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,138 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,139 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,140 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,141 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,143 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main11
;circuito_rcrc.c,144 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,145 :: 		dentroDoMenuDois = 1;
	BSF        _flagsA+0, 7
;circuito_rcrc.c,146 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,147 :: 		menuCargaCoulomb();
	CALL       _menuCargaCoulomb+0
;circuito_rcrc.c,148 :: 		}
L_main11:
;circuito_rcrc.c,150 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,151 :: 		case 2:
L_main12:
;circuito_rcrc.c,152 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,153 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,154 :: 		Lcd_Chr (1,4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,155 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,156 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,157 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,158 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,159 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,160 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,161 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,163 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main13
;circuito_rcrc.c,164 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,165 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,166 :: 		dentroDoMenuTres = 1;
	BSF        _flagsB+0, 0
;circuito_rcrc.c,167 :: 		menuNumeroEletrons();
	CALL       _menuNumeroEletrons+0
;circuito_rcrc.c,168 :: 		}
L_main13:
;circuito_rcrc.c,170 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,171 :: 		}
L_main6:
	MOVF       _selecaoModo+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _selecaoModo+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _selecaoModo+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main12
L_main7:
;circuito_rcrc.c,172 :: 		}
	GOTO       L_main4
;circuito_rcrc.c,173 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,177 :: 		void configurarRegistradores() {
;circuito_rcrc.c,181 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,182 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,183 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,184 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,185 :: 		ADCON1 = 0b00001110;
	MOVLW      14
	MOVWF      ADCON1+0
;circuito_rcrc.c,187 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,188 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,190 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,191 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,192 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,196 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,197 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,198 :: 		OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
	MOVLW      135
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,216 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,218 :: 		void iniciarLcd() {
;circuito_rcrc.c,219 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,220 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,221 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,222 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,223 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,224 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,226 :: 		void iniciarPwm() {
;circuito_rcrc.c,227 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,228 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,229 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,230 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,232 :: 		void testarBotoes() {
;circuito_rcrc.c,234 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes14
;circuito_rcrc.c,235 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,236 :: 		}
L_testarBotoes14:
;circuito_rcrc.c,238 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes17
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes17
L__testarBotoes52:
;circuito_rcrc.c,239 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,240 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,241 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,242 :: 		}
L_testarBotoes17:
;circuito_rcrc.c,244 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes18
;circuito_rcrc.c,245 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,246 :: 		}
L_testarBotoes18:
;circuito_rcrc.c,248 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes21
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes21
L__testarBotoes51:
;circuito_rcrc.c,249 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,250 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,251 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,252 :: 		}
L_testarBotoes21:
;circuito_rcrc.c,254 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes22
;circuito_rcrc.c,255 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,256 :: 		}
L_testarBotoes22:
;circuito_rcrc.c,257 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes23
;circuito_rcrc.c,258 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,259 :: 		}
L_testarBotoes23:
;circuito_rcrc.c,260 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

_acoesACadaCemMs:

;circuito_rcrc.c,262 :: 		void acoesACadaCemMs() {
;circuito_rcrc.c,264 :: 		if (!botaoEnter) {
	BTFSC      PORTB+0, 6
	GOTO       L_acoesACadaCemMs24
;circuito_rcrc.c,265 :: 		flagEntradaMenu = 1;
	BSF        _flagsA+0, 3
;circuito_rcrc.c,266 :: 		flagSaidaMenu = 0;
	BCF        _flagsA+0, 4
;circuito_rcrc.c,267 :: 		} else if (!botaoBack) {
	GOTO       L_acoesACadaCemMs25
L_acoesACadaCemMs24:
	BTFSC      PORTB+0, 7
	GOTO       L_acoesACadaCemMs26
;circuito_rcrc.c,268 :: 		flagSaidaMenu = 1;
	BSF        _flagsA+0, 4
;circuito_rcrc.c,269 :: 		flagEntradaMenu = 0;
	BCF        _flagsA+0, 3
;circuito_rcrc.c,270 :: 		}
L_acoesACadaCemMs26:
L_acoesACadaCemMs25:
;circuito_rcrc.c,271 :: 		}
L_end_acoesACadaCemMs:
	RETURN
; end of _acoesACadaCemMs

_menuVout:

;circuito_rcrc.c,273 :: 		void menuVout() {
;circuito_rcrc.c,275 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,276 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,277 :: 		Lcd_Chr(1, 10, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,278 :: 		Lcd_Chr(2, 2, 'S');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,279 :: 		Lcd_Chr_Cp('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,280 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,281 :: 		Lcd_Chr_Cp('P');
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,282 :: 		Lcd_Chr_Cp('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,283 :: 		Lcd_Chr_Cp('i');
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,284 :: 		Lcd_Chr_Cp('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,285 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,286 :: 		Lcd_Chr_Cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,287 :: 		Lcd_Chr(2, 15, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,291 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,292 :: 		do {
L_menuVout27:
;circuito_rcrc.c,293 :: 		setSetPoint();
	CALL       _setSetPoint+0
;circuito_rcrc.c,295 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuVout30
;circuito_rcrc.c,296 :: 		leituraAdc = Adc_Get_Sample(0);
	CLRF       FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       R0+0, 0
	MOVWF      _leituraAdc+0
	MOVF       R0+1, 0
	MOVWF      _leituraAdc+1
;circuito_rcrc.c,297 :: 		if (leituraAdc > 550) pinoDebug = 1;
	MOVF       R0+1, 0
	SUBLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__menuVout64
	MOVF       R0+0, 0
	SUBLW      38
L__menuVout64:
	BTFSC      STATUS+0, 0
	GOTO       L_menuVout31
	BSF        PORTC+0, 0
	GOTO       L_menuVout32
L_menuVout31:
;circuito_rcrc.c,298 :: 		else pinoDebug = 0;
	BCF        PORTC+0, 0
L_menuVout32:
;circuito_rcrc.c,299 :: 		valorIdealAdc = (int) tensaoDesejada * 20.4;
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	CALL       _int2double+0
	MOVLW      51
	MOVWF      R4+0
	MOVLW      51
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _valorIdealAdc+0
	MOVF       R0+1, 0
	MOVWF      _valorIdealAdc+1
	MOVF       R0+2, 0
	MOVWF      _valorIdealAdc+2
	MOVF       R0+3, 0
	MOVWF      _valorIdealAdc+3
;circuito_rcrc.c,300 :: 		erroMedidas = ((int) valorIdealAdc - leituraAdc) >> 2;
	CALL       _double2int+0
	MOVF       _leituraAdc+0, 0
	SUBWF      R0+0, 0
	MOVWF      R3+0
	MOVF       _leituraAdc+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      _erroMedidas+0
	MOVF       R0+1, 0
	MOVWF      _erroMedidas+1
;circuito_rcrc.c,303 :: 		valorPwm = ganhoProporcional * erroMedidas;
	CALL       _int2double+0
	MOVF       _ganhoProporcional+0, 0
	MOVWF      R4+0
	MOVF       _ganhoProporcional+1, 0
	MOVWF      R4+1
	MOVF       _ganhoProporcional+2, 0
	MOVWF      R4+2
	MOVF       _ganhoProporcional+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      _valorPwm+0
;circuito_rcrc.c,305 :: 		if (valorPwm > 255) valorPwm = 255;
	MOVF       R0+0, 0
	SUBLW      255
	BTFSC      STATUS+0, 0
	GOTO       L_menuVout33
	MOVLW      255
	MOVWF      _valorPwm+0
L_menuVout33:
;circuito_rcrc.c,307 :: 		PWM1_Set_Duty(valorPwm);
	MOVF       _valorPwm+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,308 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,309 :: 		}
L_menuVout30:
;circuito_rcrc.c,310 :: 		}  while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuVout27
;circuito_rcrc.c,312 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,313 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,314 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,315 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,316 :: 		}
L_end_menuVout:
	RETURN
; end of _menuVout

_menuCargaCoulomb:

;circuito_rcrc.c,318 :: 		void menuCargaCoulomb() {
;circuito_rcrc.c,320 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,321 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,322 :: 		Lcd_Chr(1, 9, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,324 :: 		do {
L_menuCargaCoulomb34:
;circuito_rcrc.c,325 :: 		} while(!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuCargaCoulomb34
;circuito_rcrc.c,327 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,328 :: 		}
L_end_menuCargaCoulomb:
	RETURN
; end of _menuCargaCoulomb

_menuNumeroEletrons:

;circuito_rcrc.c,330 :: 		void menuNumeroEletrons() {
;circuito_rcrc.c,332 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,333 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,334 :: 		Lcd_Chr(1, 12, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,336 :: 		do {
L_menuNumeroEletrons37:
;circuito_rcrc.c,337 :: 		} while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuNumeroEletrons37
;circuito_rcrc.c,339 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,340 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,341 :: 		}
L_end_menuNumeroEletrons:
	RETURN
; end of _menuNumeroEletrons

_setSetPoint:

;circuito_rcrc.c,343 :: 		void setSetPoint() {
;circuito_rcrc.c,344 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setSetPoint40
;circuito_rcrc.c,345 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,346 :: 		}
L_setSetPoint40:
;circuito_rcrc.c,348 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setSetPoint43
	BTFSS      _flagsA+0, 1
	GOTO       L_setSetPoint43
L__setSetPoint54:
;circuito_rcrc.c,349 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,350 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,351 :: 		if (tensaoDesejada > 50) {
	MOVLW      128
	XORLW      50
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint44
;circuito_rcrc.c,352 :: 		tensaoDesejada = 50;
	MOVLW      50
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,353 :: 		}
L_setSetPoint44:
;circuito_rcrc.c,354 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,355 :: 		}
L_setSetPoint43:
;circuito_rcrc.c,357 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setSetPoint45
;circuito_rcrc.c,358 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,359 :: 		}
L_setSetPoint45:
;circuito_rcrc.c,361 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setSetPoint48
	BTFSS      _flagsA+0, 2
	GOTO       L_setSetPoint48
L__setSetPoint53:
;circuito_rcrc.c,362 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,363 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,364 :: 		if (tensaoDesejada < 0) {
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint49
;circuito_rcrc.c,365 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,366 :: 		}
L_setSetPoint49:
;circuito_rcrc.c,367 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,368 :: 		}
L_setSetPoint48:
;circuito_rcrc.c,370 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setSetPoint50
;circuito_rcrc.c,371 :: 		calculoLcd();
	CALL       _calculoLcd+0
;circuito_rcrc.c,372 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,373 :: 		}
L_setSetPoint50:
;circuito_rcrc.c,374 :: 		}
L_end_setSetPoint:
	RETURN
; end of _setSetPoint

_calculoLcd:

;circuito_rcrc.c,376 :: 		void calculoLcd() {
;circuito_rcrc.c,380 :: 		unidadeLcd = 0x00;
	CLRF       calculoLcd_unidadeLcd_L0+0
;circuito_rcrc.c,383 :: 		dezenaLcd = (((tensaoDesejada / 10) % 10) + '0');
	MOVLW      10
	MOVWF      R4+0
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
;circuito_rcrc.c,384 :: 		unidadeLcd = ((tensaoDesejada % 10) + '0');
	MOVLW      10
	MOVWF      R4+0
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      calculoLcd_unidadeLcd_L0+0
;circuito_rcrc.c,386 :: 		Lcd_Chr(2, 12, dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,387 :: 		Lcd_Chr(2, 13, '.');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,388 :: 		Lcd_Chr(2, 14, unidadeLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       calculoLcd_unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,390 :: 		}
L_end_calculoLcd:
	RETURN
; end of _calculoLcd


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,81 :: 		void interrupt() {
;circuito_rcrc.c,84 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,85 :: 		auxiliarContagemTimerZero++;
	INCF       _auxiliarContagemTimerZero+0, 1
;circuito_rcrc.c,86 :: 		if (dentroDoMenuUm) {
	BTFSS      _flagsA+0, 6
	GOTO       L_interrupt1
;circuito_rcrc.c,87 :: 		flagCalculoControlador = 1;
	BSF        _flagsB+0, 1
;circuito_rcrc.c,88 :: 		}
L_interrupt1:
;circuito_rcrc.c,91 :: 		if (auxiliarContagemTimerZero == 10) {
	MOVF       _auxiliarContagemTimerZero+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;circuito_rcrc.c,92 :: 		acoesACadaCemMs();
	CALL       _acoesACadaCemMs+0
;circuito_rcrc.c,94 :: 		auxiliarContagemTimerZero = 0;
	CLRF       _auxiliarContagemTimerZero+0
;circuito_rcrc.c,95 :: 		}
L_interrupt2:
;circuito_rcrc.c,99 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,100 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,101 :: 		}
L_interrupt0:
;circuito_rcrc.c,103 :: 		}
L_end_interrupt:
L__interrupt59:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;circuito_rcrc.c,107 :: 		void main() {
;circuito_rcrc.c,109 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,110 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,111 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,112 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,113 :: 		delay_ms(2000);
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
;circuito_rcrc.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,116 :: 		while(1) {
L_main4:
;circuito_rcrc.c,118 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,119 :: 		switch(selecaoModo) {
	GOTO       L_main6
;circuito_rcrc.c,120 :: 		case 0:
L_main8:
;circuito_rcrc.c,121 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,122 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,123 :: 		Lcd_Chr (1,6, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,124 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,125 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,126 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,128 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main9
;circuito_rcrc.c,129 :: 		dentroDoMenuUm = 1;
	BSF        _flagsA+0, 6
;circuito_rcrc.c,130 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,131 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,132 :: 		menuVout();
	CALL       _menuVout+0
;circuito_rcrc.c,133 :: 		}
L_main9:
;circuito_rcrc.c,135 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,136 :: 		case 1:
L_main10:
;circuito_rcrc.c,137 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,138 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,139 :: 		Lcd_Chr (1,4, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,140 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,141 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,142 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,143 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,145 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main11
;circuito_rcrc.c,146 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,147 :: 		dentroDoMenuDois = 1;
	BSF        _flagsA+0, 7
;circuito_rcrc.c,148 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,149 :: 		menuCargaCoulomb();
	CALL       _menuCargaCoulomb+0
;circuito_rcrc.c,150 :: 		}
L_main11:
;circuito_rcrc.c,152 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,153 :: 		case 2:
L_main12:
;circuito_rcrc.c,154 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,155 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,156 :: 		Lcd_Chr (1,4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,157 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,158 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,159 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,160 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,161 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,162 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,163 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,165 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main13
;circuito_rcrc.c,166 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,167 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,168 :: 		dentroDoMenuTres = 1;
	BSF        _flagsB+0, 0
;circuito_rcrc.c,169 :: 		menuNumeroEletrons();
	CALL       _menuNumeroEletrons+0
;circuito_rcrc.c,170 :: 		}
L_main13:
;circuito_rcrc.c,172 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,173 :: 		}
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
;circuito_rcrc.c,174 :: 		}
	GOTO       L_main4
;circuito_rcrc.c,175 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,179 :: 		void configurarRegistradores() {
;circuito_rcrc.c,183 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,184 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,185 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,186 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,187 :: 		ADCON1 = 0b10001110;
	MOVLW      142
	MOVWF      ADCON1+0
;circuito_rcrc.c,189 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,190 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,192 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,193 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,194 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,198 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,199 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,200 :: 		OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
	MOVLW      135
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,218 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,220 :: 		void iniciarLcd() {
;circuito_rcrc.c,221 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,222 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,223 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,224 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,225 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,226 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,228 :: 		void iniciarPwm() {
;circuito_rcrc.c,229 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,230 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,231 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,232 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,234 :: 		void testarBotoes() {
;circuito_rcrc.c,236 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes14
;circuito_rcrc.c,237 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,238 :: 		}
L_testarBotoes14:
;circuito_rcrc.c,240 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes17
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes17
L__testarBotoes55:
;circuito_rcrc.c,241 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,242 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,243 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,244 :: 		}
L_testarBotoes17:
;circuito_rcrc.c,246 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes18
;circuito_rcrc.c,247 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,248 :: 		}
L_testarBotoes18:
;circuito_rcrc.c,250 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes21
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes21
L__testarBotoes54:
;circuito_rcrc.c,251 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,252 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,253 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,254 :: 		}
L_testarBotoes21:
;circuito_rcrc.c,256 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes22
;circuito_rcrc.c,257 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,258 :: 		}
L_testarBotoes22:
;circuito_rcrc.c,259 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes23
;circuito_rcrc.c,260 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,261 :: 		}
L_testarBotoes23:
;circuito_rcrc.c,262 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

_acoesACadaCemMs:

;circuito_rcrc.c,264 :: 		void acoesACadaCemMs() {
;circuito_rcrc.c,266 :: 		if (!botaoEnter) {
	BTFSC      PORTB+0, 6
	GOTO       L_acoesACadaCemMs24
;circuito_rcrc.c,267 :: 		flagEntradaMenu = 1;
	BSF        _flagsA+0, 3
;circuito_rcrc.c,268 :: 		flagSaidaMenu = 0;
	BCF        _flagsA+0, 4
;circuito_rcrc.c,269 :: 		} else if (!botaoBack) {
	GOTO       L_acoesACadaCemMs25
L_acoesACadaCemMs24:
	BTFSC      PORTB+0, 7
	GOTO       L_acoesACadaCemMs26
;circuito_rcrc.c,270 :: 		flagSaidaMenu = 1;
	BSF        _flagsA+0, 4
;circuito_rcrc.c,271 :: 		flagEntradaMenu = 0;
	BCF        _flagsA+0, 3
;circuito_rcrc.c,272 :: 		}
L_acoesACadaCemMs26:
L_acoesACadaCemMs25:
;circuito_rcrc.c,273 :: 		}
L_end_acoesACadaCemMs:
	RETURN
; end of _acoesACadaCemMs

_menuVout:

;circuito_rcrc.c,275 :: 		void menuVout() {
;circuito_rcrc.c,277 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,278 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,279 :: 		Lcd_Chr(1, 10, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,280 :: 		Lcd_Chr(2, 2, 'S');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,281 :: 		Lcd_Chr_Cp('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,282 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,283 :: 		Lcd_Chr_Cp('P');
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,284 :: 		Lcd_Chr_Cp('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,285 :: 		Lcd_Chr_Cp('i');
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,286 :: 		Lcd_Chr_Cp('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,287 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,288 :: 		Lcd_Chr_Cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,289 :: 		Lcd_Chr(2, 15, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,293 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,294 :: 		do {
L_menuVout27:
;circuito_rcrc.c,295 :: 		setSetPoint();
	CALL       _setSetPoint+0
;circuito_rcrc.c,297 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuVout30
;circuito_rcrc.c,298 :: 		leituraAdc = ADC_Get_Sample(0);
	CLRF       FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       R0+0, 0
	MOVWF      FLOC__menuVout+4
	MOVF       R0+1, 0
	MOVWF      FLOC__menuVout+5
	MOVF       FLOC__menuVout+4, 0
	MOVWF      _leituraAdc+0
	MOVF       FLOC__menuVout+5, 0
	MOVWF      _leituraAdc+1
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
	MOVWF      FLOC__menuVout+0
	MOVF       R0+1, 0
	MOVWF      FLOC__menuVout+1
	MOVF       R0+2, 0
	MOVWF      FLOC__menuVout+2
	MOVF       R0+3, 0
	MOVWF      FLOC__menuVout+3
	MOVF       FLOC__menuVout+0, 0
	MOVWF      _valorIdealAdc+0
	MOVF       FLOC__menuVout+1, 0
	MOVWF      _valorIdealAdc+1
	MOVF       FLOC__menuVout+2, 0
	MOVWF      _valorIdealAdc+2
	MOVF       FLOC__menuVout+3, 0
	MOVWF      _valorIdealAdc+3
;circuito_rcrc.c,302 :: 		erroMedidas = (valorIdealAdc - leituraAdc);
	MOVF       FLOC__menuVout+4, 0
	MOVWF      R0+0
	MOVF       FLOC__menuVout+5, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__menuVout+0, 0
	MOVWF      R0+0
	MOVF       FLOC__menuVout+1, 0
	MOVWF      R0+1
	MOVF       FLOC__menuVout+2, 0
	MOVWF      R0+2
	MOVF       FLOC__menuVout+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _erroMedidas+0
	MOVF       R0+1, 0
	MOVWF      _erroMedidas+1
	MOVF       R0+2, 0
	MOVWF      _erroMedidas+2
	MOVF       R0+3, 0
	MOVWF      _erroMedidas+3
;circuito_rcrc.c,303 :: 		integral = integral + ganhoIntegral * ((erroMedidas + ultimoErro) / 2) * 0.010;
	MOVF       _ultimoErro+0, 0
	MOVWF      R4+0
	MOVF       _ultimoErro+1, 0
	MOVWF      R4+1
	MOVF       _ultimoErro+2, 0
	MOVWF      R4+2
	MOVF       _ultimoErro+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       _ganhoIntegral+0, 0
	MOVWF      R4+0
	MOVF       _ganhoIntegral+1, 0
	MOVWF      R4+1
	MOVF       _ganhoIntegral+2, 0
	MOVWF      R4+2
	MOVF       _ganhoIntegral+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      215
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      120
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       _integral+0, 0
	MOVWF      R4+0
	MOVF       _integral+1, 0
	MOVWF      R4+1
	MOVF       _integral+2, 0
	MOVWF      R4+2
	MOVF       _integral+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _integral+0
	MOVF       R0+1, 0
	MOVWF      _integral+1
	MOVF       R0+2, 0
	MOVWF      _integral+2
	MOVF       R0+3, 0
	MOVWF      _integral+3
;circuito_rcrc.c,305 :: 		if (integral > 255) integral = 255;     // Windup
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      127
	MOVWF      R0+2
	MOVLW      134
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuVout31
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      0
	MOVWF      _integral+1
	MOVLW      127
	MOVWF      _integral+2
	MOVLW      134
	MOVWF      _integral+3
	GOTO       L_menuVout32
L_menuVout31:
;circuito_rcrc.c,306 :: 		else if (integral < -255) integral = -255;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      255
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	MOVF       _integral+0, 0
	MOVWF      R0+0
	MOVF       _integral+1, 0
	MOVWF      R0+1
	MOVF       _integral+2, 0
	MOVWF      R0+2
	MOVF       _integral+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuVout33
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      0
	MOVWF      _integral+1
	MOVLW      255
	MOVWF      _integral+2
	MOVLW      134
	MOVWF      _integral+3
L_menuVout33:
L_menuVout32:
;circuito_rcrc.c,308 :: 		derivada = ganhoDerivativo * (erroMedidas - ultimoErro)/0.010;
	MOVF       _ultimoErro+0, 0
	MOVWF      R4+0
	MOVF       _ultimoErro+1, 0
	MOVWF      R4+1
	MOVF       _ultimoErro+2, 0
	MOVWF      R4+2
	MOVF       _ultimoErro+3, 0
	MOVWF      R4+3
	MOVF       _erroMedidas+0, 0
	MOVWF      R0+0
	MOVF       _erroMedidas+1, 0
	MOVWF      R0+1
	MOVF       _erroMedidas+2, 0
	MOVWF      R0+2
	MOVF       _erroMedidas+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       _ganhoDerivativo+0, 0
	MOVWF      R4+0
	MOVF       _ganhoDerivativo+1, 0
	MOVWF      R4+1
	MOVF       _ganhoDerivativo+2, 0
	MOVWF      R4+2
	MOVF       _ganhoDerivativo+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      215
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      120
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__menuVout+0
	MOVF       R0+1, 0
	MOVWF      FLOC__menuVout+1
	MOVF       R0+2, 0
	MOVWF      FLOC__menuVout+2
	MOVF       R0+3, 0
	MOVWF      FLOC__menuVout+3
	MOVF       FLOC__menuVout+0, 0
	MOVWF      _derivada+0
	MOVF       FLOC__menuVout+1, 0
	MOVWF      _derivada+1
	MOVF       FLOC__menuVout+2, 0
	MOVWF      _derivada+2
	MOVF       FLOC__menuVout+3, 0
	MOVWF      _derivada+3
;circuito_rcrc.c,310 :: 		ultimoErro = erroMedidas;
	MOVF       _erroMedidas+0, 0
	MOVWF      _ultimoErro+0
	MOVF       _erroMedidas+1, 0
	MOVWF      _ultimoErro+1
	MOVF       _erroMedidas+2, 0
	MOVWF      _ultimoErro+2
	MOVF       _erroMedidas+3, 0
	MOVWF      _ultimoErro+3
;circuito_rcrc.c,312 :: 		valorPwm = (ganhoProporcional * ((int)erroMedidas >> 2)) + integral + derivada;
	MOVF       _erroMedidas+0, 0
	MOVWF      R0+0
	MOVF       _erroMedidas+1, 0
	MOVWF      R0+1
	MOVF       _erroMedidas+2, 0
	MOVWF      R0+2
	MOVF       _erroMedidas+3, 0
	MOVWF      R0+3
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	BTFSC      R4+1, 6
	BSF        R4+1, 7
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	BTFSC      R4+1, 6
	BSF        R4+1, 7
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
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
	MOVF       _integral+0, 0
	MOVWF      R4+0
	MOVF       _integral+1, 0
	MOVWF      R4+1
	MOVF       _integral+2, 0
	MOVWF      R4+2
	MOVF       _integral+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       FLOC__menuVout+0, 0
	MOVWF      R4+0
	MOVF       FLOC__menuVout+1, 0
	MOVWF      R4+1
	MOVF       FLOC__menuVout+2, 0
	MOVWF      R4+2
	MOVF       FLOC__menuVout+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _valorPwm+0
	MOVF       R0+1, 0
	MOVWF      _valorPwm+1
	MOVF       R0+2, 0
	MOVWF      _valorPwm+2
	MOVF       R0+3, 0
	MOVWF      _valorPwm+3
;circuito_rcrc.c,314 :: 		if (valorPwm > 255) valorPwm = 255;
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      127
	MOVWF      R0+2
	MOVLW      134
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuVout34
	MOVLW      0
	MOVWF      _valorPwm+0
	MOVLW      0
	MOVWF      _valorPwm+1
	MOVLW      127
	MOVWF      _valorPwm+2
	MOVLW      134
	MOVWF      _valorPwm+3
	GOTO       L_menuVout35
L_menuVout34:
;circuito_rcrc.c,315 :: 		else if (valorPwm < 0) valorPwm = 0;
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _valorPwm+0, 0
	MOVWF      R0+0
	MOVF       _valorPwm+1, 0
	MOVWF      R0+1
	MOVF       _valorPwm+2, 0
	MOVWF      R0+2
	MOVF       _valorPwm+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuVout36
	CLRF       _valorPwm+0
	CLRF       _valorPwm+1
	CLRF       _valorPwm+2
	CLRF       _valorPwm+3
L_menuVout36:
L_menuVout35:
;circuito_rcrc.c,317 :: 		PWM1_Set_Duty((char)valorPwm);
	MOVF       _valorPwm+0, 0
	MOVWF      R0+0
	MOVF       _valorPwm+1, 0
	MOVWF      R0+1
	MOVF       _valorPwm+2, 0
	MOVWF      R0+2
	MOVF       _valorPwm+3, 0
	MOVWF      R0+3
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,318 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,319 :: 		}
L_menuVout30:
;circuito_rcrc.c,320 :: 		}  while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuVout27
;circuito_rcrc.c,322 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,323 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,324 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,325 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,326 :: 		}
L_end_menuVout:
	RETURN
; end of _menuVout

_menuCargaCoulomb:

;circuito_rcrc.c,328 :: 		void menuCargaCoulomb() {
;circuito_rcrc.c,330 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,331 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,332 :: 		Lcd_Chr(1, 9, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,334 :: 		do {
L_menuCargaCoulomb37:
;circuito_rcrc.c,335 :: 		} while(!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuCargaCoulomb37
;circuito_rcrc.c,337 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,338 :: 		}
L_end_menuCargaCoulomb:
	RETURN
; end of _menuCargaCoulomb

_menuNumeroEletrons:

;circuito_rcrc.c,340 :: 		void menuNumeroEletrons() {
;circuito_rcrc.c,342 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,343 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,344 :: 		Lcd_Chr(1, 12, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,346 :: 		do {
L_menuNumeroEletrons40:
;circuito_rcrc.c,347 :: 		} while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuNumeroEletrons40
;circuito_rcrc.c,349 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,350 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,351 :: 		}
L_end_menuNumeroEletrons:
	RETURN
; end of _menuNumeroEletrons

_setSetPoint:

;circuito_rcrc.c,353 :: 		void setSetPoint() {
;circuito_rcrc.c,354 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setSetPoint43
;circuito_rcrc.c,355 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,356 :: 		}
L_setSetPoint43:
;circuito_rcrc.c,358 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setSetPoint46
	BTFSS      _flagsA+0, 1
	GOTO       L_setSetPoint46
L__setSetPoint57:
;circuito_rcrc.c,359 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,360 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,361 :: 		if (tensaoDesejada > 25) {
	MOVLW      128
	XORLW      25
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint47
;circuito_rcrc.c,362 :: 		tensaoDesejada = 25;
	MOVLW      25
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,363 :: 		}
L_setSetPoint47:
;circuito_rcrc.c,364 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,365 :: 		}
L_setSetPoint46:
;circuito_rcrc.c,367 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setSetPoint48
;circuito_rcrc.c,368 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,369 :: 		}
L_setSetPoint48:
;circuito_rcrc.c,371 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setSetPoint51
	BTFSS      _flagsA+0, 2
	GOTO       L_setSetPoint51
L__setSetPoint56:
;circuito_rcrc.c,372 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,373 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,374 :: 		if (tensaoDesejada < 0) {
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint52
;circuito_rcrc.c,375 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,376 :: 		}
L_setSetPoint52:
;circuito_rcrc.c,377 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,378 :: 		}
L_setSetPoint51:
;circuito_rcrc.c,380 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setSetPoint53
;circuito_rcrc.c,381 :: 		calculoLcd();
	CALL       _calculoLcd+0
;circuito_rcrc.c,382 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,383 :: 		}
L_setSetPoint53:
;circuito_rcrc.c,384 :: 		}
L_end_setSetPoint:
	RETURN
; end of _setSetPoint

_calculoLcd:

;circuito_rcrc.c,386 :: 		void calculoLcd() {
;circuito_rcrc.c,390 :: 		unidadeLcd = 0x00;
	CLRF       calculoLcd_unidadeLcd_L0+0
;circuito_rcrc.c,393 :: 		dezenaLcd = (((tensaoDesejada / 10) % 10) + '0');
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
;circuito_rcrc.c,394 :: 		unidadeLcd = ((tensaoDesejada % 10) + '0');
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
;circuito_rcrc.c,396 :: 		Lcd_Chr(2, 12, dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,397 :: 		Lcd_Chr(2, 13, '.');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,398 :: 		Lcd_Chr(2, 14, unidadeLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       calculoLcd_unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,400 :: 		}
L_end_calculoLcd:
	RETURN
; end of _calculoLcd

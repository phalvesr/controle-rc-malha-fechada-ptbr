
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,87 :: 		void interrupt() {
;circuito_rcrc.c,90 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,91 :: 		auxiliarContagemTimerZero++;
	INCF       _auxiliarContagemTimerZero+0, 1
;circuito_rcrc.c,92 :: 		if (dentroDoMenuUm || dentroDoMenuDois || dentroDoMenuTres) {
	BTFSC      _flagsA+0, 6
	GOTO       L__interrupt88
	BTFSC      _flagsA+0, 7
	GOTO       L__interrupt88
	BTFSC      _flagsB+0, 0
	GOTO       L__interrupt88
	GOTO       L_interrupt3
L__interrupt88:
;circuito_rcrc.c,93 :: 		flagCalculoControlador = 1;
	BSF        _flagsB+0, 1
;circuito_rcrc.c,94 :: 		}
L_interrupt3:
;circuito_rcrc.c,97 :: 		if (auxiliarContagemTimerZero == 10) {
	MOVF       _auxiliarContagemTimerZero+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;circuito_rcrc.c,98 :: 		acoesACadaCemMs();
	CALL       _acoesACadaCemMs+0
;circuito_rcrc.c,100 :: 		auxiliarContagemTimerZero = 0;
	CLRF       _auxiliarContagemTimerZero+0
;circuito_rcrc.c,101 :: 		}
L_interrupt4:
;circuito_rcrc.c,105 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,106 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,107 :: 		}
L_interrupt0:
;circuito_rcrc.c,109 :: 		}
L_end_interrupt:
L__interrupt98:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;circuito_rcrc.c,113 :: 		void main() {
;circuito_rcrc.c,115 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,116 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,117 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,118 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,119 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
;circuito_rcrc.c,120 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,122 :: 		while(1) {
L_main6:
;circuito_rcrc.c,124 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,125 :: 		switch(selecaoModo) {
	GOTO       L_main8
;circuito_rcrc.c,126 :: 		case 0:
L_main10:
;circuito_rcrc.c,127 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,128 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,129 :: 		Lcd_Chr (1,6, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,130 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,131 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,132 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,134 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main11
;circuito_rcrc.c,135 :: 		dentroDoMenuUm = 1;
	BSF        _flagsA+0, 6
;circuito_rcrc.c,136 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,137 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,138 :: 		menuVout();
	CALL       _menuVout+0
;circuito_rcrc.c,139 :: 		}
L_main11:
;circuito_rcrc.c,141 :: 		break;
	GOTO       L_main9
;circuito_rcrc.c,142 :: 		case 1:
L_main12:
;circuito_rcrc.c,143 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,144 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,145 :: 		Lcd_Chr (1, 6, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,146 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,147 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,148 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,149 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,151 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main13
;circuito_rcrc.c,152 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,153 :: 		dentroDoMenuDois = 1;
	BSF        _flagsA+0, 7
;circuito_rcrc.c,154 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,155 :: 		menuCargaCoulomb();
	CALL       _menuCargaCoulomb+0
;circuito_rcrc.c,156 :: 		}
L_main13:
;circuito_rcrc.c,158 :: 		break;
	GOTO       L_main9
;circuito_rcrc.c,159 :: 		case 2:
L_main14:
;circuito_rcrc.c,160 :: 		Lcd_Chr (1, 1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,161 :: 		Lcd_Chr (1, 16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,162 :: 		Lcd_Chr (1, 4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,163 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,164 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,165 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,166 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,167 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,168 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,169 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,171 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main15
;circuito_rcrc.c,172 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,173 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,174 :: 		dentroDoMenuTres = 1;
	BSF        _flagsB+0, 0
;circuito_rcrc.c,175 :: 		menuNumeroEletrons();
	CALL       _menuNumeroEletrons+0
;circuito_rcrc.c,176 :: 		}
L_main15:
;circuito_rcrc.c,178 :: 		break;
	GOTO       L_main9
;circuito_rcrc.c,179 :: 		}
L_main8:
	MOVF       _selecaoModo+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _selecaoModo+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _selecaoModo+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main14
L_main9:
;circuito_rcrc.c,180 :: 		}
	GOTO       L_main6
;circuito_rcrc.c,181 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,185 :: 		void configurarRegistradores() {
;circuito_rcrc.c,189 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,190 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,191 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,192 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,193 :: 		ADCON1 = 0b10001110;
	MOVLW      142
	MOVWF      ADCON1+0
;circuito_rcrc.c,195 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,196 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,198 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,199 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,200 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,204 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,205 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,206 :: 		OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
	MOVLW      135
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,224 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,226 :: 		void iniciarLcd() {
;circuito_rcrc.c,227 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,228 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,229 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,230 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,231 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,232 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,234 :: 		void iniciarPwm() {
;circuito_rcrc.c,235 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,236 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,237 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,238 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,240 :: 		void testarBotoes() {
;circuito_rcrc.c,242 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes16
;circuito_rcrc.c,243 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,244 :: 		}
L_testarBotoes16:
;circuito_rcrc.c,246 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes19
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes19
L__testarBotoes90:
;circuito_rcrc.c,247 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,248 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,249 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,250 :: 		}
L_testarBotoes19:
;circuito_rcrc.c,252 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes20
;circuito_rcrc.c,253 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,254 :: 		}
L_testarBotoes20:
;circuito_rcrc.c,256 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes23
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes23
L__testarBotoes89:
;circuito_rcrc.c,257 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,258 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,259 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,260 :: 		}
L_testarBotoes23:
;circuito_rcrc.c,262 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes24
;circuito_rcrc.c,263 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,264 :: 		}
L_testarBotoes24:
;circuito_rcrc.c,265 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes25
;circuito_rcrc.c,266 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,267 :: 		}
L_testarBotoes25:
;circuito_rcrc.c,268 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

_acoesACadaCemMs:

;circuito_rcrc.c,270 :: 		void acoesACadaCemMs() {
;circuito_rcrc.c,272 :: 		if (!botaoEnter) {
	BTFSC      PORTB+0, 6
	GOTO       L_acoesACadaCemMs26
;circuito_rcrc.c,273 :: 		flagEntradaMenu = 1;
	BSF        _flagsA+0, 3
;circuito_rcrc.c,274 :: 		flagSaidaMenu = 0;
	BCF        _flagsA+0, 4
;circuito_rcrc.c,275 :: 		} else if (!botaoBack) {
	GOTO       L_acoesACadaCemMs27
L_acoesACadaCemMs26:
	BTFSC      PORTB+0, 7
	GOTO       L_acoesACadaCemMs28
;circuito_rcrc.c,276 :: 		flagSaidaMenu = 1;
	BSF        _flagsA+0, 4
;circuito_rcrc.c,277 :: 		flagEntradaMenu = 0;
	BCF        _flagsA+0, 3
;circuito_rcrc.c,278 :: 		}
L_acoesACadaCemMs28:
L_acoesACadaCemMs27:
;circuito_rcrc.c,279 :: 		}
L_end_acoesACadaCemMs:
	RETURN
; end of _acoesACadaCemMs

_menuVout:

;circuito_rcrc.c,281 :: 		void menuVout() {
;circuito_rcrc.c,282 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,283 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,284 :: 		Lcd_Chr(1, 10, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,285 :: 		Lcd_Chr(2, 2, 'S');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,286 :: 		Lcd_Chr_Cp('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,287 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,288 :: 		Lcd_Chr_Cp('P');
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,289 :: 		Lcd_Chr_Cp('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,290 :: 		Lcd_Chr_Cp('i');
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,291 :: 		Lcd_Chr_Cp('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,292 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,293 :: 		Lcd_Chr_Cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,294 :: 		Lcd_Chr(2, 15, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,296 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,297 :: 		do {
L_menuVout29:
;circuito_rcrc.c,298 :: 		setSetPoint();
	CALL       _setSetPoint+0
;circuito_rcrc.c,300 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuVout32
;circuito_rcrc.c,301 :: 		calcularPid();
	CALL       _calcularPid+0
;circuito_rcrc.c,302 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,303 :: 		}
L_menuVout32:
;circuito_rcrc.c,304 :: 		}  while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuVout29
;circuito_rcrc.c,306 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,307 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,308 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,309 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,310 :: 		}
L_end_menuVout:
	RETURN
; end of _menuVout

_menuCargaCoulomb:

;circuito_rcrc.c,312 :: 		void menuCargaCoulomb() {
;circuito_rcrc.c,313 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,314 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,315 :: 		Lcd_Chr(1, 11, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,316 :: 		Lcd_Chr(2, 6, 'u');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,317 :: 		Lcd_Chr_Cp('C');
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,318 :: 		Lcd_Chr(2, 9, '=');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      61
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,319 :: 		Lcd_Chr(2, 14, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,321 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,323 :: 		do {
L_menuCargaCoulomb33:
;circuito_rcrc.c,324 :: 		setCarga();
	CALL       _setCarga+0
;circuito_rcrc.c,325 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuCargaCoulomb36
;circuito_rcrc.c,326 :: 		calcularPid();
	CALL       _calcularPid+0
;circuito_rcrc.c,327 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,328 :: 		}
L_menuCargaCoulomb36:
;circuito_rcrc.c,329 :: 		} while(!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuCargaCoulomb33
;circuito_rcrc.c,331 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,332 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,333 :: 		cargaDesejada = 0;
	CLRF       _cargaDesejada+0
	CLRF       _cargaDesejada+1
;circuito_rcrc.c,334 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,335 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,336 :: 		}
L_end_menuCargaCoulomb:
	RETURN
; end of _menuCargaCoulomb

_menuNumeroEletrons:

;circuito_rcrc.c,338 :: 		void menuNumeroEletrons() {
;circuito_rcrc.c,339 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,340 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,341 :: 		Lcd_Chr(1, 12, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,342 :: 		Lcd_Chr(2, 10, '=');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      61
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,343 :: 		Lcd_Chr(2, 15, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,345 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,347 :: 		do {
L_menuNumeroEletrons37:
;circuito_rcrc.c,351 :: 		setNumeroEletrons();
	CALL       _setNumeroEletrons+0
;circuito_rcrc.c,352 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuNumeroEletrons40
;circuito_rcrc.c,353 :: 		calcularPid();
	CALL       _calcularPid+0
;circuito_rcrc.c,354 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,355 :: 		}
L_menuNumeroEletrons40:
;circuito_rcrc.c,358 :: 		} while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuNumeroEletrons37
;circuito_rcrc.c,360 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,361 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,362 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,363 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,364 :: 		}
L_end_menuNumeroEletrons:
	RETURN
; end of _menuNumeroEletrons

_setSetPoint:

;circuito_rcrc.c,366 :: 		void setSetPoint() {
;circuito_rcrc.c,368 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setSetPoint41
;circuito_rcrc.c,369 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,370 :: 		}
L_setSetPoint41:
;circuito_rcrc.c,372 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setSetPoint44
	BTFSS      _flagsA+0, 1
	GOTO       L_setSetPoint44
L__setSetPoint92:
;circuito_rcrc.c,373 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,374 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,375 :: 		if (tensaoDesejada > 50) {
	MOVLW      128
	XORLW      50
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint45
;circuito_rcrc.c,376 :: 		tensaoDesejada = 50;
	MOVLW      50
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,377 :: 		}
L_setSetPoint45:
;circuito_rcrc.c,378 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,379 :: 		}
L_setSetPoint44:
;circuito_rcrc.c,381 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setSetPoint46
;circuito_rcrc.c,382 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,383 :: 		}
L_setSetPoint46:
;circuito_rcrc.c,385 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setSetPoint49
	BTFSS      _flagsA+0, 2
	GOTO       L_setSetPoint49
L__setSetPoint91:
;circuito_rcrc.c,386 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,387 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,388 :: 		if (tensaoDesejada < 0) {
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint50
;circuito_rcrc.c,389 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,390 :: 		}
L_setSetPoint50:
;circuito_rcrc.c,391 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,392 :: 		}
L_setSetPoint49:
;circuito_rcrc.c,394 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setSetPoint51
;circuito_rcrc.c,395 :: 		calculoLcd('V');
	MOVLW      86
	MOVWF      FARG_calculoLcd_modo+0
	CALL       _calculoLcd+0
;circuito_rcrc.c,396 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,397 :: 		}
L_setSetPoint51:
;circuito_rcrc.c,398 :: 		}
L_end_setSetPoint:
	RETURN
; end of _setSetPoint

_setCarga:

;circuito_rcrc.c,400 :: 		void setCarga() {
;circuito_rcrc.c,401 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setCarga52
;circuito_rcrc.c,402 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,403 :: 		}
L_setCarga52:
;circuito_rcrc.c,405 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setCarga55
	BTFSS      _flagsA+0, 1
	GOTO       L_setCarga55
L__setCarga94:
;circuito_rcrc.c,406 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,407 :: 		cargaDesejada += 10;
	MOVLW      10
	ADDWF      _cargaDesejada+0, 0
	MOVWF      R1+0
	MOVF       _cargaDesejada+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _cargaDesejada+0
	MOVF       R1+1, 0
	MOVWF      _cargaDesejada+1
;circuito_rcrc.c,408 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,409 :: 		if (cargaDesejada > 250) cargaDesejada = 250;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setCarga110
	MOVF       R1+0, 0
	SUBLW      250
L__setCarga110:
	BTFSC      STATUS+0, 0
	GOTO       L_setCarga56
	MOVLW      250
	MOVWF      _cargaDesejada+0
	CLRF       _cargaDesejada+1
L_setCarga56:
;circuito_rcrc.c,410 :: 		tensaoDesejada = cargaDesejada / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cargaDesejada+0, 0
	MOVWF      R0+0
	MOVF       _cargaDesejada+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,411 :: 		}
L_setCarga55:
;circuito_rcrc.c,413 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setCarga57
;circuito_rcrc.c,414 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,415 :: 		}
L_setCarga57:
;circuito_rcrc.c,417 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setCarga60
	BTFSS      _flagsA+0, 2
	GOTO       L_setCarga60
L__setCarga93:
;circuito_rcrc.c,418 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,419 :: 		cargaDesejada -= 10;
	MOVLW      10
	SUBWF      _cargaDesejada+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _cargaDesejada+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _cargaDesejada+0
	MOVF       R1+1, 0
	MOVWF      _cargaDesejada+1
;circuito_rcrc.c,420 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,421 :: 		if (cargaDesejada < 0) cargaDesejada = 0;
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__setCarga111
	MOVLW      0
	SUBWF      R1+0, 0
L__setCarga111:
	BTFSC      STATUS+0, 0
	GOTO       L_setCarga61
	CLRF       _cargaDesejada+0
	CLRF       _cargaDesejada+1
L_setCarga61:
;circuito_rcrc.c,422 :: 		tensaoDesejada = cargaDesejada / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cargaDesejada+0, 0
	MOVWF      R0+0
	MOVF       _cargaDesejada+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,423 :: 		}
L_setCarga60:
;circuito_rcrc.c,425 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setCarga62
;circuito_rcrc.c,426 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,427 :: 		calculoLcd('C');
	MOVLW      67
	MOVWF      FARG_calculoLcd_modo+0
	CALL       _calculoLcd+0
;circuito_rcrc.c,428 :: 		}
L_setCarga62:
;circuito_rcrc.c,430 :: 		}
L_end_setCarga:
	RETURN
; end of _setCarga

_setNumeroEletrons:

;circuito_rcrc.c,432 :: 		void setNumeroEletrons() {
;circuito_rcrc.c,433 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setNumeroEletrons63
;circuito_rcrc.c,434 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,435 :: 		}
L_setNumeroEletrons63:
;circuito_rcrc.c,437 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setNumeroEletrons64
;circuito_rcrc.c,438 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,439 :: 		}
L_setNumeroEletrons64:
;circuito_rcrc.c,441 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setNumeroEletrons67
	BTFSS      _flagsA+0, 1
	GOTO       L_setNumeroEletrons67
L__setNumeroEletrons96:
;circuito_rcrc.c,442 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,443 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,444 :: 		if (tensaoDesejada > 25)
	MOVLW      128
	XORLW      25
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setNumeroEletrons68
;circuito_rcrc.c,445 :: 		tensaoDesejada = 25;
	MOVLW      25
	MOVWF      _tensaoDesejada+0
L_setNumeroEletrons68:
;circuito_rcrc.c,446 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,447 :: 		}
L_setNumeroEletrons67:
;circuito_rcrc.c,449 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setNumeroEletrons71
	BTFSS      _flagsA+0, 2
	GOTO       L_setNumeroEletrons71
L__setNumeroEletrons95:
;circuito_rcrc.c,450 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,451 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,452 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,453 :: 		}
L_setNumeroEletrons71:
;circuito_rcrc.c,455 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setNumeroEletrons72
;circuito_rcrc.c,456 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,457 :: 		calculoLcd('E');
	MOVLW      69
	MOVWF      FARG_calculoLcd_modo+0
	CALL       _calculoLcd+0
;circuito_rcrc.c,458 :: 		}
L_setNumeroEletrons72:
;circuito_rcrc.c,460 :: 		}
L_end_setNumeroEletrons:
	RETURN
; end of _setNumeroEletrons

_calculoLcd:

;circuito_rcrc.c,462 :: 		void calculoLcd(char modo) {
;circuito_rcrc.c,464 :: 		char _centenaLcd = 0, _dezenaLcd = 0, _unidadeLcd = 0;
	CLRF       calculoLcd__dezenaLcd_L0+0
	CLRF       calculoLcd__unidadeLcd_L0+0
;circuito_rcrc.c,466 :: 		switch (modo) {
	GOTO       L_calculoLcd73
;circuito_rcrc.c,467 :: 		case 'V':
L_calculoLcd75:
;circuito_rcrc.c,468 :: 		Lcd_Chr(2, 12, (((tensaoDesejada / 10) % 10) + '0'));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
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
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,469 :: 		Lcd_Chr(2, 13, '.');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,470 :: 		Lcd_Chr(2, 14, ((tensaoDesejada % 10) + '0'));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,471 :: 		break;
	GOTO       L_calculoLcd74
;circuito_rcrc.c,473 :: 		case 'C':
L_calculoLcd76:
;circuito_rcrc.c,474 :: 		Lcd_Chr(2, 3, ((cargaDesejada / 100) % 10) + '0');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cargaDesejada+0, 0
	MOVWF      R0+0
	MOVF       _cargaDesejada+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,475 :: 		Lcd_Chr_Cp((((cargaDesejada / 10) % 10) + '0'));
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cargaDesejada+0, 0
	MOVWF      R0+0
	MOVF       _cargaDesejada+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,476 :: 		Lcd_Chr_Cp(((cargaDesejada % 10) + '0'));
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cargaDesejada+0, 0
	MOVWF      R0+0
	MOVF       _cargaDesejada+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,477 :: 		Lcd_Chr(2, 11, (((tensaoDesejada / 10) % 10) + '0'));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
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
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,478 :: 		Lcd_Chr_Cp('.');
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,479 :: 		Lcd_Chr_Cp(((tensaoDesejada % 10) + '0'));
	MOVLW      10
	MOVWF      R4+0
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,480 :: 		break;
	GOTO       L_calculoLcd74
;circuito_rcrc.c,482 :: 		case 'E':
L_calculoLcd77:
;circuito_rcrc.c,483 :: 		_unidadeLcd = ((tensaoDesejada % 10) + '0');
	MOVLW      10
	MOVWF      R4+0
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      calculoLcd__unidadeLcd_L0+0
;circuito_rcrc.c,484 :: 		_dezenaLcd = ((tensaoDesejada / 10) % 10) + '0';
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
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      calculoLcd__dezenaLcd_L0+0
;circuito_rcrc.c,486 :: 		Lcd_Chr(2, 2, _dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,487 :: 		Lcd_Chr_Cp(_unidadeLcd);
	MOVF       calculoLcd__unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,488 :: 		Lcd_Chr_Cp('*');
	MOVLW      42
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,489 :: 		Lcd_Chr_Cp('6');
	MOVLW      54
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,490 :: 		Lcd_Chr_Cp('.');
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,491 :: 		Lcd_Chr_Cp('2');
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,492 :: 		Lcd_Chr_Cp('5');
	MOVLW      53
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,493 :: 		Lcd_Chr(2, 12, _dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       calculoLcd__dezenaLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,494 :: 		Lcd_Chr_Cp('.');
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,495 :: 		Lcd_Chr_Cp(_unidadeLcd);
	MOVF       calculoLcd__unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,496 :: 		break;
	GOTO       L_calculoLcd74
;circuito_rcrc.c,497 :: 		}
L_calculoLcd73:
	MOVF       FARG_calculoLcd_modo+0, 0
	XORLW      86
	BTFSC      STATUS+0, 2
	GOTO       L_calculoLcd75
	MOVF       FARG_calculoLcd_modo+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_calculoLcd76
	MOVF       FARG_calculoLcd_modo+0, 0
	XORLW      69
	BTFSC      STATUS+0, 2
	GOTO       L_calculoLcd77
L_calculoLcd74:
;circuito_rcrc.c,500 :: 		}
L_end_calculoLcd:
	RETURN
; end of _calculoLcd

_filtrarLeitura:

;circuito_rcrc.c,502 :: 		int filtrarLeitura() {
;circuito_rcrc.c,503 :: 		int somatorio = 0, i;
	CLRF       filtrarLeitura_somatorio_L0+0
	CLRF       filtrarLeitura_somatorio_L0+1
;circuito_rcrc.c,507 :: 		index++;
	INCF       filtrarLeitura_index_L0+0, 1
;circuito_rcrc.c,508 :: 		if (index > 7) index = 0;
	MOVF       filtrarLeitura_index_L0+0, 0
	SUBLW      7
	BTFSC      STATUS+0, 0
	GOTO       L_filtrarLeitura78
	CLRF       filtrarLeitura_index_L0+0
L_filtrarLeitura78:
;circuito_rcrc.c,510 :: 		leituras[index] = ADC_Get_Sample(0);
	MOVF       filtrarLeitura_index_L0+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      filtrarLeitura_leituras_L0+0
	MOVWF      FLOC__filtrarLeitura+0
	CLRF       FARG_ADC_Get_Sample_channel+0
	CALL       _ADC_Get_Sample+0
	MOVF       FLOC__filtrarLeitura+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;circuito_rcrc.c,512 :: 		for (i = 0; i < 8; i++) {
	CLRF       filtrarLeitura_i_L0+0
	CLRF       filtrarLeitura_i_L0+1
L_filtrarLeitura79:
	MOVLW      128
	XORWF      filtrarLeitura_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filtrarLeitura115
	MOVLW      8
	SUBWF      filtrarLeitura_i_L0+0, 0
L__filtrarLeitura115:
	BTFSC      STATUS+0, 0
	GOTO       L_filtrarLeitura80
;circuito_rcrc.c,513 :: 		somatorio += leituras[i];
	MOVF       filtrarLeitura_i_L0+0, 0
	MOVWF      R0+0
	MOVF       filtrarLeitura_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      filtrarLeitura_leituras_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      filtrarLeitura_somatorio_L0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      filtrarLeitura_somatorio_L0+1, 1
;circuito_rcrc.c,512 :: 		for (i = 0; i < 8; i++) {
	INCF       filtrarLeitura_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       filtrarLeitura_i_L0+1, 1
;circuito_rcrc.c,514 :: 		}
	GOTO       L_filtrarLeitura79
L_filtrarLeitura80:
;circuito_rcrc.c,516 :: 		return (somatorio >> 3);
	MOVLW      3
	MOVWF      R2+0
	MOVF       filtrarLeitura_somatorio_L0+0, 0
	MOVWF      R0+0
	MOVF       filtrarLeitura_somatorio_L0+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__filtrarLeitura116:
	BTFSC      STATUS+0, 2
	GOTO       L__filtrarLeitura117
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__filtrarLeitura116
L__filtrarLeitura117:
;circuito_rcrc.c,518 :: 		}
L_end_filtrarLeitura:
	RETURN
; end of _filtrarLeitura

_calcularPid:

;circuito_rcrc.c,520 :: 		void calcularPid() {
;circuito_rcrc.c,521 :: 		leituraAdc = filtrarLeitura();
	CALL       _filtrarLeitura+0
	MOVF       R0+0, 0
	MOVWF      FLOC__calcularPid+4
	MOVF       R0+1, 0
	MOVWF      FLOC__calcularPid+5
	MOVF       FLOC__calcularPid+4, 0
	MOVWF      _leituraAdc+0
	MOVF       FLOC__calcularPid+5, 0
	MOVWF      _leituraAdc+1
;circuito_rcrc.c,524 :: 		valorIdealAdc = (int)tensaoDesejada * 20.46;
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	CALL       _int2double+0
	MOVLW      20
	MOVWF      R4+0
	MOVLW      174
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__calcularPid+0
	MOVF       R0+1, 0
	MOVWF      FLOC__calcularPid+1
	MOVF       R0+2, 0
	MOVWF      FLOC__calcularPid+2
	MOVF       R0+3, 0
	MOVWF      FLOC__calcularPid+3
	MOVF       FLOC__calcularPid+0, 0
	MOVWF      _valorIdealAdc+0
	MOVF       FLOC__calcularPid+1, 0
	MOVWF      _valorIdealAdc+1
	MOVF       FLOC__calcularPid+2, 0
	MOVWF      _valorIdealAdc+2
	MOVF       FLOC__calcularPid+3, 0
	MOVWF      _valorIdealAdc+3
;circuito_rcrc.c,527 :: 		erroMedidas = (valorIdealAdc - leituraAdc);
	MOVF       FLOC__calcularPid+4, 0
	MOVWF      R0+0
	MOVF       FLOC__calcularPid+5, 0
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
	MOVF       FLOC__calcularPid+0, 0
	MOVWF      R0+0
	MOVF       FLOC__calcularPid+1, 0
	MOVWF      R0+1
	MOVF       FLOC__calcularPid+2, 0
	MOVWF      R0+2
	MOVF       FLOC__calcularPid+3, 0
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
;circuito_rcrc.c,528 :: 		integral = integral + ganhoIntegral * ((erroMedidas + ultimoErro) / 2) * 0.010;
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
;circuito_rcrc.c,530 :: 		if (integral > 255) integral = 255;     // Anti-Windup
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
	GOTO       L_calcularPid82
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      0
	MOVWF      _integral+1
	MOVLW      127
	MOVWF      _integral+2
	MOVLW      134
	MOVWF      _integral+3
	GOTO       L_calcularPid83
L_calcularPid82:
;circuito_rcrc.c,531 :: 		else if (integral < -255) integral = -255;
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
	GOTO       L_calcularPid84
	MOVLW      0
	MOVWF      _integral+0
	MOVLW      0
	MOVWF      _integral+1
	MOVLW      255
	MOVWF      _integral+2
	MOVLW      134
	MOVWF      _integral+3
L_calcularPid84:
L_calcularPid83:
;circuito_rcrc.c,533 :: 		derivada = ganhoDerivativo * (erroMedidas - ultimoErro) / 0.010;
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
	MOVWF      FLOC__calcularPid+0
	MOVF       R0+1, 0
	MOVWF      FLOC__calcularPid+1
	MOVF       R0+2, 0
	MOVWF      FLOC__calcularPid+2
	MOVF       R0+3, 0
	MOVWF      FLOC__calcularPid+3
	MOVF       FLOC__calcularPid+0, 0
	MOVWF      _derivada+0
	MOVF       FLOC__calcularPid+1, 0
	MOVWF      _derivada+1
	MOVF       FLOC__calcularPid+2, 0
	MOVWF      _derivada+2
	MOVF       FLOC__calcularPid+3, 0
	MOVWF      _derivada+3
;circuito_rcrc.c,535 :: 		ultimoErro = erroMedidas;
	MOVF       _erroMedidas+0, 0
	MOVWF      _ultimoErro+0
	MOVF       _erroMedidas+1, 0
	MOVWF      _ultimoErro+1
	MOVF       _erroMedidas+2, 0
	MOVWF      _ultimoErro+2
	MOVF       _erroMedidas+3, 0
	MOVWF      _ultimoErro+3
;circuito_rcrc.c,537 :: 		valorPwm = (ganhoProporcional * ((int)erroMedidas >> 2)) + integral + derivada;
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
	MOVF       FLOC__calcularPid+0, 0
	MOVWF      R4+0
	MOVF       FLOC__calcularPid+1, 0
	MOVWF      R4+1
	MOVF       FLOC__calcularPid+2, 0
	MOVWF      R4+2
	MOVF       FLOC__calcularPid+3, 0
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
;circuito_rcrc.c,539 :: 		if (valorPwm > 255) valorPwm = 255;
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
	GOTO       L_calcularPid85
	MOVLW      0
	MOVWF      _valorPwm+0
	MOVLW      0
	MOVWF      _valorPwm+1
	MOVLW      127
	MOVWF      _valorPwm+2
	MOVLW      134
	MOVWF      _valorPwm+3
	GOTO       L_calcularPid86
L_calcularPid85:
;circuito_rcrc.c,540 :: 		else if (valorPwm < 0) valorPwm = 0;
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
	GOTO       L_calcularPid87
	CLRF       _valorPwm+0
	CLRF       _valorPwm+1
	CLRF       _valorPwm+2
	CLRF       _valorPwm+3
L_calcularPid87:
L_calcularPid86:
;circuito_rcrc.c,541 :: 		PWM1_Set_Duty((char)valorPwm);
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
;circuito_rcrc.c,542 :: 		}
L_end_calcularPid:
	RETURN
; end of _calcularPid

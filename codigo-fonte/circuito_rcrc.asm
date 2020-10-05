
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,83 :: 		void interrupt() {
;circuito_rcrc.c,86 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,87 :: 		auxiliarContagemTimerZero++;
	INCF       _auxiliarContagemTimerZero+0, 1
;circuito_rcrc.c,88 :: 		if (dentroDoMenuUm) {
	BTFSS      _flagsA+0, 6
	GOTO       L_interrupt1
;circuito_rcrc.c,89 :: 		flagCalculoControlador = 1;
	BSF        _flagsB+0, 1
;circuito_rcrc.c,90 :: 		}
L_interrupt1:
;circuito_rcrc.c,93 :: 		if (auxiliarContagemTimerZero == 10) {
	MOVF       _auxiliarContagemTimerZero+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;circuito_rcrc.c,94 :: 		acoesACadaCemMs();
	CALL       _acoesACadaCemMs+0
;circuito_rcrc.c,96 :: 		auxiliarContagemTimerZero = 0;
	CLRF       _auxiliarContagemTimerZero+0
;circuito_rcrc.c,97 :: 		}
L_interrupt2:
;circuito_rcrc.c,101 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,102 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,103 :: 		}
L_interrupt0:
;circuito_rcrc.c,105 :: 		}
L_end_interrupt:
L__interrupt63:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;circuito_rcrc.c,109 :: 		void main() {
;circuito_rcrc.c,111 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,112 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,113 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,114 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,115 :: 		delay_ms(2000);
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
;circuito_rcrc.c,116 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,118 :: 		while(1) {
L_main4:
;circuito_rcrc.c,120 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,121 :: 		switch(selecaoModo) {
	GOTO       L_main6
;circuito_rcrc.c,122 :: 		case 0:
L_main8:
;circuito_rcrc.c,123 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,124 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,125 :: 		Lcd_Chr (1,6, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,126 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,127 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,128 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,130 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main9
;circuito_rcrc.c,131 :: 		dentroDoMenuUm = 1;
	BSF        _flagsA+0, 6
;circuito_rcrc.c,132 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,133 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,134 :: 		menuVout();
	CALL       _menuVout+0
;circuito_rcrc.c,135 :: 		}
L_main9:
;circuito_rcrc.c,137 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,138 :: 		case 1:
L_main10:
;circuito_rcrc.c,139 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,140 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,141 :: 		Lcd_Chr (1,4, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,142 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,143 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,144 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,145 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,147 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main11
;circuito_rcrc.c,148 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,149 :: 		dentroDoMenuDois = 1;
	BSF        _flagsA+0, 7
;circuito_rcrc.c,150 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,151 :: 		menuCargaCoulomb();
	CALL       _menuCargaCoulomb+0
;circuito_rcrc.c,152 :: 		}
L_main11:
;circuito_rcrc.c,154 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,155 :: 		case 2:
L_main12:
;circuito_rcrc.c,156 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,157 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,158 :: 		Lcd_Chr (1,4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,159 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,160 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,161 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,162 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,163 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,164 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,165 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,167 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main13
;circuito_rcrc.c,168 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,169 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,170 :: 		dentroDoMenuTres = 1;
	BSF        _flagsB+0, 0
;circuito_rcrc.c,171 :: 		menuNumeroEletrons();
	CALL       _menuNumeroEletrons+0
;circuito_rcrc.c,172 :: 		}
L_main13:
;circuito_rcrc.c,174 :: 		break;
	GOTO       L_main7
;circuito_rcrc.c,175 :: 		}
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
;circuito_rcrc.c,176 :: 		}
	GOTO       L_main4
;circuito_rcrc.c,177 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,181 :: 		void configurarRegistradores() {
;circuito_rcrc.c,185 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,186 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,187 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,188 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,189 :: 		ADCON1 = 0b10001110;
	MOVLW      142
	MOVWF      ADCON1+0
;circuito_rcrc.c,191 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,192 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,194 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,195 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,196 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,200 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,201 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,202 :: 		OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
	MOVLW      135
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,220 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,222 :: 		void iniciarLcd() {
;circuito_rcrc.c,223 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,224 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,225 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,226 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,227 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,228 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,230 :: 		void iniciarPwm() {
;circuito_rcrc.c,231 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,232 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,233 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,234 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,236 :: 		void testarBotoes() {
;circuito_rcrc.c,238 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes14
;circuito_rcrc.c,239 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,240 :: 		}
L_testarBotoes14:
;circuito_rcrc.c,242 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes17
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes17
L__testarBotoes59:
;circuito_rcrc.c,243 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,244 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,245 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,246 :: 		}
L_testarBotoes17:
;circuito_rcrc.c,248 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes18
;circuito_rcrc.c,249 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,250 :: 		}
L_testarBotoes18:
;circuito_rcrc.c,252 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes21
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes21
L__testarBotoes58:
;circuito_rcrc.c,253 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,254 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,255 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,256 :: 		}
L_testarBotoes21:
;circuito_rcrc.c,258 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes22
;circuito_rcrc.c,259 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,260 :: 		}
L_testarBotoes22:
;circuito_rcrc.c,261 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes23
;circuito_rcrc.c,262 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,263 :: 		}
L_testarBotoes23:
;circuito_rcrc.c,264 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

_acoesACadaCemMs:

;circuito_rcrc.c,266 :: 		void acoesACadaCemMs() {
;circuito_rcrc.c,268 :: 		if (!botaoEnter) {
	BTFSC      PORTB+0, 6
	GOTO       L_acoesACadaCemMs24
;circuito_rcrc.c,269 :: 		flagEntradaMenu = 1;
	BSF        _flagsA+0, 3
;circuito_rcrc.c,270 :: 		flagSaidaMenu = 0;
	BCF        _flagsA+0, 4
;circuito_rcrc.c,271 :: 		} else if (!botaoBack) {
	GOTO       L_acoesACadaCemMs25
L_acoesACadaCemMs24:
	BTFSC      PORTB+0, 7
	GOTO       L_acoesACadaCemMs26
;circuito_rcrc.c,272 :: 		flagSaidaMenu = 1;
	BSF        _flagsA+0, 4
;circuito_rcrc.c,273 :: 		flagEntradaMenu = 0;
	BCF        _flagsA+0, 3
;circuito_rcrc.c,274 :: 		}
L_acoesACadaCemMs26:
L_acoesACadaCemMs25:
;circuito_rcrc.c,275 :: 		}
L_end_acoesACadaCemMs:
	RETURN
; end of _acoesACadaCemMs

_menuVout:

;circuito_rcrc.c,277 :: 		void menuVout() {
;circuito_rcrc.c,279 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,280 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,281 :: 		Lcd_Chr(1, 10, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,282 :: 		Lcd_Chr(2, 2, 'S');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,283 :: 		Lcd_Chr_Cp('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,284 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,285 :: 		Lcd_Chr_Cp('P');
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,286 :: 		Lcd_Chr_Cp('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,287 :: 		Lcd_Chr_Cp('i');
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,288 :: 		Lcd_Chr_Cp('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,289 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,290 :: 		Lcd_Chr_Cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,291 :: 		Lcd_Chr(2, 15, 'M');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      77
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,295 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,296 :: 		do {
L_menuVout27:
;circuito_rcrc.c,297 :: 		setSetPoint();
	CALL       _setSetPoint+0
;circuito_rcrc.c,299 :: 		if (flagCalculoControlador) {
	BTFSS      _flagsB+0, 1
	GOTO       L_menuVout30
;circuito_rcrc.c,301 :: 		leituraAdc = filtrarLeitura();
	CALL       _filtrarLeitura+0
	MOVF       R0+0, 0
	MOVWF      FLOC__menuVout+4
	MOVF       R0+1, 0
	MOVWF      FLOC__menuVout+5
	MOVF       FLOC__menuVout+4, 0
	MOVWF      _leituraAdc+0
	MOVF       FLOC__menuVout+5, 0
	MOVWF      _leituraAdc+1
;circuito_rcrc.c,302 :: 		valorIdealAdc = (int)tensaoDesejada * 20.4;
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
;circuito_rcrc.c,305 :: 		erroMedidas = (valorIdealAdc - leituraAdc);
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
;circuito_rcrc.c,306 :: 		integral = integral + ganhoIntegral * ((erroMedidas + ultimoErro) / 2) * 0.010;
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
;circuito_rcrc.c,308 :: 		if (integral > 255) integral = 255;     // Anti-Windup
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
;circuito_rcrc.c,309 :: 		else if (integral < -255) integral = -255;
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
;circuito_rcrc.c,311 :: 		derivada = ganhoDerivativo * (erroMedidas - ultimoErro) / 0.010;
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
;circuito_rcrc.c,313 :: 		ultimoErro = erroMedidas;
	MOVF       _erroMedidas+0, 0
	MOVWF      _ultimoErro+0
	MOVF       _erroMedidas+1, 0
	MOVWF      _ultimoErro+1
	MOVF       _erroMedidas+2, 0
	MOVWF      _ultimoErro+2
	MOVF       _erroMedidas+3, 0
	MOVWF      _ultimoErro+3
;circuito_rcrc.c,315 :: 		valorPwm = (ganhoProporcional * ((int)erroMedidas >> 2)) + integral + derivada;
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
;circuito_rcrc.c,317 :: 		if (valorPwm > 255) valorPwm = 255;
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
;circuito_rcrc.c,318 :: 		else if (valorPwm < 0) valorPwm = 0;
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
;circuito_rcrc.c,319 :: 		PWM1_Set_Duty((char)valorPwm);
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
;circuito_rcrc.c,321 :: 		flagCalculoControlador = 0;
	BCF        _flagsB+0, 1
;circuito_rcrc.c,322 :: 		}
L_menuVout30:
;circuito_rcrc.c,323 :: 		}  while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuVout27
;circuito_rcrc.c,325 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,326 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,327 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,328 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,329 :: 		}
L_end_menuVout:
	RETURN
; end of _menuVout

_menuCargaCoulomb:

;circuito_rcrc.c,331 :: 		void menuCargaCoulomb() {
;circuito_rcrc.c,333 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,334 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,335 :: 		Lcd_Chr(1, 9, 'F');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      70
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,337 :: 		do {
L_menuCargaCoulomb37:
;circuito_rcrc.c,338 :: 		} while(!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuCargaCoulomb37
;circuito_rcrc.c,340 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,341 :: 		}
L_end_menuCargaCoulomb:
	RETURN
; end of _menuCargaCoulomb

_menuNumeroEletrons:

;circuito_rcrc.c,343 :: 		void menuNumeroEletrons() {
;circuito_rcrc.c,345 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,346 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,347 :: 		Lcd_Chr(1, 12, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,349 :: 		do {
L_menuNumeroEletrons40:
;circuito_rcrc.c,350 :: 		} while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuNumeroEletrons40
;circuito_rcrc.c,352 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,353 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,354 :: 		}
L_end_menuNumeroEletrons:
	RETURN
; end of _menuNumeroEletrons

_setSetPoint:

;circuito_rcrc.c,356 :: 		void setSetPoint() {
;circuito_rcrc.c,357 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setSetPoint43
;circuito_rcrc.c,358 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,359 :: 		}
L_setSetPoint43:
;circuito_rcrc.c,361 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setSetPoint46
	BTFSS      _flagsA+0, 1
	GOTO       L_setSetPoint46
L__setSetPoint61:
;circuito_rcrc.c,362 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,363 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,364 :: 		if (tensaoDesejada > 25) {
	MOVLW      128
	XORLW      25
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint47
;circuito_rcrc.c,365 :: 		tensaoDesejada = 25;
	MOVLW      25
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,366 :: 		}
L_setSetPoint47:
;circuito_rcrc.c,367 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,368 :: 		}
L_setSetPoint46:
;circuito_rcrc.c,370 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setSetPoint48
;circuito_rcrc.c,371 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,372 :: 		}
L_setSetPoint48:
;circuito_rcrc.c,374 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setSetPoint51
	BTFSS      _flagsA+0, 2
	GOTO       L_setSetPoint51
L__setSetPoint60:
;circuito_rcrc.c,375 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,376 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,377 :: 		if (tensaoDesejada < 0) {
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint52
;circuito_rcrc.c,378 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,379 :: 		}
L_setSetPoint52:
;circuito_rcrc.c,380 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,381 :: 		}
L_setSetPoint51:
;circuito_rcrc.c,383 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setSetPoint53
;circuito_rcrc.c,384 :: 		calculoLcd();
	CALL       _calculoLcd+0
;circuito_rcrc.c,385 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,386 :: 		}
L_setSetPoint53:
;circuito_rcrc.c,387 :: 		}
L_end_setSetPoint:
	RETURN
; end of _setSetPoint

_calculoLcd:

;circuito_rcrc.c,389 :: 		void calculoLcd() {
;circuito_rcrc.c,393 :: 		unidadeLcd = 0x00;
	CLRF       calculoLcd_unidadeLcd_L0+0
;circuito_rcrc.c,396 :: 		dezenaLcd = (((tensaoDesejada / 10) % 10) + '0');
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
;circuito_rcrc.c,397 :: 		unidadeLcd = ((tensaoDesejada % 10) + '0');
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
;circuito_rcrc.c,399 :: 		Lcd_Chr(2, 12, dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,400 :: 		Lcd_Chr(2, 13, '.');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,401 :: 		Lcd_Chr(2, 14, unidadeLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       calculoLcd_unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,403 :: 		}
L_end_calculoLcd:
	RETURN
; end of _calculoLcd

_filtrarLeitura:

;circuito_rcrc.c,405 :: 		int filtrarLeitura() {
;circuito_rcrc.c,406 :: 		int somatorio = 0, i;
	CLRF       filtrarLeitura_somatorio_L0+0
	CLRF       filtrarLeitura_somatorio_L0+1
;circuito_rcrc.c,410 :: 		index++;
	INCF       filtrarLeitura_index_L0+0, 1
;circuito_rcrc.c,411 :: 		if (index > 7) index = 0;
	MOVF       filtrarLeitura_index_L0+0, 0
	SUBLW      7
	BTFSC      STATUS+0, 0
	GOTO       L_filtrarLeitura54
	CLRF       filtrarLeitura_index_L0+0
L_filtrarLeitura54:
;circuito_rcrc.c,413 :: 		leituras[index] = ADC_Get_Sample(0);
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
;circuito_rcrc.c,415 :: 		for (i = 0; i < 8; i++) {
	CLRF       filtrarLeitura_i_L0+0
	CLRF       filtrarLeitura_i_L0+1
L_filtrarLeitura55:
	MOVLW      128
	XORWF      filtrarLeitura_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__filtrarLeitura76
	MOVLW      8
	SUBWF      filtrarLeitura_i_L0+0, 0
L__filtrarLeitura76:
	BTFSC      STATUS+0, 0
	GOTO       L_filtrarLeitura56
;circuito_rcrc.c,416 :: 		somatorio += leituras[i];
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
;circuito_rcrc.c,415 :: 		for (i = 0; i < 8; i++) {
	INCF       filtrarLeitura_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       filtrarLeitura_i_L0+1, 1
;circuito_rcrc.c,417 :: 		}
	GOTO       L_filtrarLeitura55
L_filtrarLeitura56:
;circuito_rcrc.c,419 :: 		return (somatorio >> 3);
	MOVLW      3
	MOVWF      R2+0
	MOVF       filtrarLeitura_somatorio_L0+0, 0
	MOVWF      R0+0
	MOVF       filtrarLeitura_somatorio_L0+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__filtrarLeitura77:
	BTFSC      STATUS+0, 2
	GOTO       L__filtrarLeitura78
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__filtrarLeitura77
L__filtrarLeitura78:
;circuito_rcrc.c,421 :: 		}
L_end_filtrarLeitura:
	RETURN
; end of _filtrarLeitura

_enviarDadosSerial:

;circuito_rcrc.c,424 :: 		void enviarDadosSerial(int *leituraAdcPtr) {
;circuito_rcrc.c,429 :: 		_centenaLeitura = (((*leituraAdcPtr / 100) % 10) + '0');
	MOVF       FARG_enviarDadosSerial_leituraAdcPtr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
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
	MOVWF      FARG_UART1_Write_data_+0
;circuito_rcrc.c,430 :: 		_dezenaLeitura = (((*leituraAdcPtr / 10) % 10) + '0');
	MOVF       FARG_enviarDadosSerial_leituraAdcPtr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
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
	MOVWF      enviarDadosSerial__dezenaLeitura_L0+0
;circuito_rcrc.c,434 :: 		UART1_Write(_centenaLeitura);
	CALL       _UART1_Write+0
;circuito_rcrc.c,435 :: 		UART1_Write(_dezenaLeitura);
	MOVF       enviarDadosSerial__dezenaLeitura_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;circuito_rcrc.c,436 :: 		UART1_Write(_dezenaLeitura);
	MOVF       enviarDadosSerial__dezenaLeitura_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;circuito_rcrc.c,437 :: 		UART1_Write(';');
	MOVLW      59
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;circuito_rcrc.c,438 :: 		}
L_end_enviarDadosSerial:
	RETURN
; end of _enviarDadosSerial


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;circuito_rcrc.c,72 :: 		void interrupt() {
;circuito_rcrc.c,75 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;circuito_rcrc.c,76 :: 		auxiliarContagemTimer0++;
	INCF       _auxiliarContagemTimer0+0, 1
;circuito_rcrc.c,79 :: 		if (auxiliarContagemTimer0 == 10) {
	MOVF       _auxiliarContagemTimer0+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;circuito_rcrc.c,80 :: 		acoesACadaCemMs();
	CALL       _acoesACadaCemMs+0
;circuito_rcrc.c,81 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,82 :: 		auxiliarContagemTimer0 = 1;
	MOVLW      1
	MOVWF      _auxiliarContagemTimer0+0
;circuito_rcrc.c,83 :: 		}
L_interrupt1:
;circuito_rcrc.c,84 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;circuito_rcrc.c,85 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,86 :: 		}
L_interrupt0:
;circuito_rcrc.c,88 :: 		}
L_end_interrupt:
L__interrupt51:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;circuito_rcrc.c,92 :: 		void main() {
;circuito_rcrc.c,94 :: 		configurarRegistradores();
	CALL       _configurarRegistradores+0
;circuito_rcrc.c,95 :: 		iniciarLcd();
	CALL       _iniciarLcd+0
;circuito_rcrc.c,96 :: 		iniciarPwm();
	CALL       _iniciarPwm+0
;circuito_rcrc.c,97 :: 		UART1_Init(9600);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;circuito_rcrc.c,98 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
;circuito_rcrc.c,99 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,101 :: 		while(1) {
L_main3:
;circuito_rcrc.c,103 :: 		testarBotoes();
	CALL       _testarBotoes+0
;circuito_rcrc.c,104 :: 		switch(selecaoModo) {
	GOTO       L_main5
;circuito_rcrc.c,105 :: 		case 0:
L_main7:
;circuito_rcrc.c,106 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,107 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,108 :: 		Lcd_Chr (1,6, 'V');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,109 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,110 :: 		Lcd_Chr_Cp ('u');
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,111 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,113 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main8
;circuito_rcrc.c,114 :: 		dentroDoMenuUm = 1;
	BSF        _flagsA+0, 6
;circuito_rcrc.c,115 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,116 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,117 :: 		menuVout();
	CALL       _menuVout+0
;circuito_rcrc.c,118 :: 		}
L_main8:
;circuito_rcrc.c,120 :: 		break;
	GOTO       L_main6
;circuito_rcrc.c,121 :: 		case 1:
L_main9:
;circuito_rcrc.c,122 :: 		Lcd_Chr (1,1, '<');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,123 :: 		Lcd_Chr (1,16, '>');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,124 :: 		Lcd_Chr (1,4, 'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,125 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,126 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,127 :: 		Lcd_Chr_Cp ('g');
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,128 :: 		Lcd_Chr_Cp ('a');
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,130 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main10
;circuito_rcrc.c,131 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,132 :: 		dentroDoMenuDois = 1;
	BSF        _flagsA+0, 7
;circuito_rcrc.c,133 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,134 :: 		menuCargaCoulomb();
	CALL       _menuCargaCoulomb+0
;circuito_rcrc.c,135 :: 		}
L_main10:
;circuito_rcrc.c,137 :: 		break;
	GOTO       L_main6
;circuito_rcrc.c,138 :: 		case 2:
L_main11:
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
;circuito_rcrc.c,141 :: 		Lcd_Chr (1,4, 'E');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,142 :: 		Lcd_Chr_Cp ('l');
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,143 :: 		Lcd_Chr_Cp ('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,144 :: 		Lcd_Chr_Cp ('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,145 :: 		Lcd_Chr_Cp ('r');
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,146 :: 		Lcd_Chr_Cp ('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,147 :: 		Lcd_Chr_Cp ('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,148 :: 		Lcd_Chr_Cp ('s');
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,150 :: 		if (flagEntradaMenu) {
	BTFSS      _flagsA+0, 3
	GOTO       L_main12
;circuito_rcrc.c,151 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,152 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,153 :: 		dentroDoMenuTres = 1;
	BSF        _flagsB+0, 0
;circuito_rcrc.c,154 :: 		menuNumeroEletrons();
	CALL       _menuNumeroEletrons+0
;circuito_rcrc.c,155 :: 		}
L_main12:
;circuito_rcrc.c,157 :: 		break;
	GOTO       L_main6
;circuito_rcrc.c,158 :: 		}
L_main5:
	MOVF       _selecaoModo+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _selecaoModo+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _selecaoModo+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main11
L_main6:
;circuito_rcrc.c,159 :: 		}
	GOTO       L_main3
;circuito_rcrc.c,160 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_configurarRegistradores:

;circuito_rcrc.c,164 :: 		void configurarRegistradores() {
;circuito_rcrc.c,168 :: 		TRISB = 0b11001001;
	MOVLW      201
	MOVWF      TRISB+0
;circuito_rcrc.c,169 :: 		TRISA = 0b00110011;
	MOVLW      51
	MOVWF      TRISA+0
;circuito_rcrc.c,170 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;circuito_rcrc.c,171 :: 		ADCON0 = 0b00000001;
	MOVLW      1
	MOVWF      ADCON0+0
;circuito_rcrc.c,172 :: 		ADCON1 = 0b00001110;
	MOVLW      14
	MOVWF      ADCON1+0
;circuito_rcrc.c,174 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;circuito_rcrc.c,175 :: 		PORTC.F0 = 0;
	BCF        PORTC+0, 0
;circuito_rcrc.c,177 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;circuito_rcrc.c,178 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;circuito_rcrc.c,179 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;circuito_rcrc.c,183 :: 		INTCON = 0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;circuito_rcrc.c,184 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;circuito_rcrc.c,185 :: 		OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
	MOVLW      135
	MOVWF      OPTION_REG+0
;circuito_rcrc.c,203 :: 		}
L_end_configurarRegistradores:
	RETURN
; end of _configurarRegistradores

_iniciarLcd:

;circuito_rcrc.c,205 :: 		void iniciarLcd() {
;circuito_rcrc.c,206 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;circuito_rcrc.c,207 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,208 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,209 :: 		Lcd_Out(1, 2, "Lab Controle 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,210 :: 		Lcd_Out(2, 3, "IFSP - SPO");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_circuito_rcrc+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;circuito_rcrc.c,211 :: 		}
L_end_iniciarLcd:
	RETURN
; end of _iniciarLcd

_iniciarPwm:

;circuito_rcrc.c,213 :: 		void iniciarPwm() {
;circuito_rcrc.c,214 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;circuito_rcrc.c,215 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,216 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;circuito_rcrc.c,217 :: 		}
L_end_iniciarPwm:
	RETURN
; end of _iniciarPwm

_testarBotoes:

;circuito_rcrc.c,219 :: 		void testarBotoes() {
;circuito_rcrc.c,221 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_testarBotoes13
;circuito_rcrc.c,222 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,223 :: 		}
L_testarBotoes13:
;circuito_rcrc.c,225 :: 		if (flagIncremento && botaoIncremento) {
	BTFSS      _flagsA+0, 1
	GOTO       L_testarBotoes16
	BTFSS      PORTB+0, 0
	GOTO       L_testarBotoes16
L__testarBotoes47:
;circuito_rcrc.c,226 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,227 :: 		selecaoModo++;
	INCF       _selecaoModo+0, 1
;circuito_rcrc.c,228 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,229 :: 		}
L_testarBotoes16:
;circuito_rcrc.c,231 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_testarBotoes17
;circuito_rcrc.c,232 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,233 :: 		}
L_testarBotoes17:
;circuito_rcrc.c,235 :: 		if (flagDecremento && botaoDecremento) {
	BTFSS      _flagsA+0, 2
	GOTO       L_testarBotoes20
	BTFSS      PORTB+0, 3
	GOTO       L_testarBotoes20
L__testarBotoes46:
;circuito_rcrc.c,236 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,237 :: 		selecaoModo--;
	DECF       _selecaoModo+0, 1
;circuito_rcrc.c,238 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,239 :: 		}
L_testarBotoes20:
;circuito_rcrc.c,241 :: 		if (selecaoModo < 0) {
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes21
;circuito_rcrc.c,242 :: 		selecaoModo = 2;
	MOVLW      2
	MOVWF      _selecaoModo+0
;circuito_rcrc.c,243 :: 		}
L_testarBotoes21:
;circuito_rcrc.c,244 :: 		if (selecaoModo > 2) {
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _selecaoModo+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_testarBotoes22
;circuito_rcrc.c,245 :: 		selecaoModo = 0;
	CLRF       _selecaoModo+0
;circuito_rcrc.c,246 :: 		}
L_testarBotoes22:
;circuito_rcrc.c,247 :: 		}
L_end_testarBotoes:
	RETURN
; end of _testarBotoes

_acoesACadaCemMs:

;circuito_rcrc.c,249 :: 		void acoesACadaCemMs() {
;circuito_rcrc.c,251 :: 		if (!botaoEnter) {
	BTFSC      PORTB+0, 6
	GOTO       L_acoesACadaCemMs23
;circuito_rcrc.c,252 :: 		flagEntradaMenu = 1;
	BSF        _flagsA+0, 3
;circuito_rcrc.c,253 :: 		flagSaidaMenu = 0;
	BCF        _flagsA+0, 4
;circuito_rcrc.c,254 :: 		} else if (!botaoBack) {
	GOTO       L_acoesACadaCemMs24
L_acoesACadaCemMs23:
	BTFSC      PORTB+0, 7
	GOTO       L_acoesACadaCemMs25
;circuito_rcrc.c,255 :: 		flagSaidaMenu = 1;
	BSF        _flagsA+0, 4
;circuito_rcrc.c,256 :: 		flagEntradaMenu = 0;
	BCF        _flagsA+0, 3
;circuito_rcrc.c,257 :: 		}
L_acoesACadaCemMs25:
L_acoesACadaCemMs24:
;circuito_rcrc.c,258 :: 		}
L_end_acoesACadaCemMs:
	RETURN
; end of _acoesACadaCemMs

_menuVout:

;circuito_rcrc.c,260 :: 		void menuVout() {
;circuito_rcrc.c,262 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,263 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,264 :: 		Lcd_Chr(1, 10, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,265 :: 		Lcd_Chr(2, 2, 'S');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,266 :: 		Lcd_Chr_Cp('e');
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,267 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,268 :: 		Lcd_Chr_Cp('P');
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,269 :: 		Lcd_Chr_Cp('o');
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,270 :: 		Lcd_Chr_Cp('i');
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,271 :: 		Lcd_Chr_Cp('n');
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,272 :: 		Lcd_Chr_Cp('t');
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,273 :: 		Lcd_Chr_Cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;circuito_rcrc.c,274 :: 		Lcd_Chr(2, 15, 'V');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,276 :: 		calculoLcd();
	CALL       _calculoLcd+0
;circuito_rcrc.c,278 :: 		flagCalculoLcd = 1;
	BSF        _flagsA+0, 5
;circuito_rcrc.c,280 :: 		do {
L_menuVout26:
;circuito_rcrc.c,281 :: 		setSetPoint();
	CALL       _setSetPoint+0
;circuito_rcrc.c,284 :: 		valorPWM = (((tensaoDesejada * 4))*255) / 100;
	MOVF       _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _valorPWM+0
;circuito_rcrc.c,286 :: 		PWM1_Set_Duty(valorPWM);
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;circuito_rcrc.c,287 :: 		}  while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuVout26
;circuito_rcrc.c,289 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,290 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,291 :: 		dentroDoMenuUm = 0;
	BCF        _flagsA+0, 6
;circuito_rcrc.c,292 :: 		}
L_end_menuVout:
	RETURN
; end of _menuVout

_menuCargaCoulomb:

;circuito_rcrc.c,294 :: 		void menuCargaCoulomb() {
;circuito_rcrc.c,296 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,297 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,298 :: 		Lcd_Chr(1, 9, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,300 :: 		do {
L_menuCargaCoulomb29:
;circuito_rcrc.c,301 :: 		} while(!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuCargaCoulomb29
;circuito_rcrc.c,303 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,304 :: 		}
L_end_menuCargaCoulomb:
	RETURN
; end of _menuCargaCoulomb

_menuNumeroEletrons:

;circuito_rcrc.c,306 :: 		void menuNumeroEletrons() {
;circuito_rcrc.c,308 :: 		Lcd_Chr (1,1, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,309 :: 		Lcd_Chr (1,16, ' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,310 :: 		Lcd_Chr(1, 12, ':');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,312 :: 		do {
L_menuNumeroEletrons32:
;circuito_rcrc.c,313 :: 		} while (!flagSaidaMenu);
	BTFSS      _flagsA+0, 4
	GOTO       L_menuNumeroEletrons32
;circuito_rcrc.c,315 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;circuito_rcrc.c,316 :: 		dentroDoMenuDois = 0;
	BCF        _flagsA+0, 7
;circuito_rcrc.c,317 :: 		}
L_end_menuNumeroEletrons:
	RETURN
; end of _menuNumeroEletrons

_calculoLcd:

;circuito_rcrc.c,319 :: 		void calculoLcd() {
;circuito_rcrc.c,323 :: 		unidadeLcd = 0x00;
	CLRF       calculoLcd_unidadeLcd_L0+0
;circuito_rcrc.c,326 :: 		dezenaLcd = (((tensaoDesejada / 10) % 10) + '0');
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
;circuito_rcrc.c,327 :: 		unidadeLcd = ((tensaoDesejada % 10) + '0');
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
;circuito_rcrc.c,329 :: 		Lcd_Chr(2, 12, dezenaLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,330 :: 		Lcd_Chr(2, 13, '.');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,331 :: 		Lcd_Chr(2, 14, unidadeLcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       calculoLcd_unidadeLcd_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;circuito_rcrc.c,332 :: 		dentroDoMenuTres = 0;
	BCF        _flagsB+0, 0
;circuito_rcrc.c,334 :: 		}
L_end_calculoLcd:
	RETURN
; end of _calculoLcd

_setSetPoint:

;circuito_rcrc.c,336 :: 		void setSetPoint() {
;circuito_rcrc.c,337 :: 		if (!botaoIncremento) {
	BTFSC      PORTB+0, 0
	GOTO       L_setSetPoint35
;circuito_rcrc.c,338 :: 		flagIncremento = 1;
	BSF        _flagsA+0, 1
;circuito_rcrc.c,339 :: 		}
L_setSetPoint35:
;circuito_rcrc.c,341 :: 		if (botaoIncremento && flagIncremento) {
	BTFSS      PORTB+0, 0
	GOTO       L_setSetPoint38
	BTFSS      _flagsA+0, 1
	GOTO       L_setSetPoint38
L__setSetPoint49:
;circuito_rcrc.c,342 :: 		flagIncremento = 0;
	BCF        _flagsA+0, 1
;circuito_rcrc.c,343 :: 		tensaoDesejada++;
	INCF       _tensaoDesejada+0, 1
;circuito_rcrc.c,344 :: 		if (tensaoDesejada > 25) {
	MOVLW      128
	XORLW      25
	MOVWF      R0+0
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint39
;circuito_rcrc.c,345 :: 		tensaoDesejada = 25;
	MOVLW      25
	MOVWF      _tensaoDesejada+0
;circuito_rcrc.c,346 :: 		}
L_setSetPoint39:
;circuito_rcrc.c,347 :: 		}
L_setSetPoint38:
;circuito_rcrc.c,349 :: 		if (!botaoDecremento) {
	BTFSC      PORTB+0, 3
	GOTO       L_setSetPoint40
;circuito_rcrc.c,350 :: 		flagDecremento = 1;
	BSF        _flagsA+0, 2
;circuito_rcrc.c,351 :: 		}
L_setSetPoint40:
;circuito_rcrc.c,353 :: 		if (botaoDecremento && flagDecremento) {
	BTFSS      PORTB+0, 3
	GOTO       L_setSetPoint43
	BTFSS      _flagsA+0, 2
	GOTO       L_setSetPoint43
L__setSetPoint48:
;circuito_rcrc.c,354 :: 		flagDecremento = 0;
	BCF        _flagsA+0, 2
;circuito_rcrc.c,355 :: 		tensaoDesejada--;
	DECF       _tensaoDesejada+0, 1
;circuito_rcrc.c,356 :: 		if (tensaoDesejada < 0) {
	MOVLW      128
	XORWF      _tensaoDesejada+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setSetPoint44
;circuito_rcrc.c,357 :: 		tensaoDesejada = 0;
	CLRF       _tensaoDesejada+0
;circuito_rcrc.c,358 :: 		}
L_setSetPoint44:
;circuito_rcrc.c,359 :: 		}
L_setSetPoint43:
;circuito_rcrc.c,361 :: 		if (flagCalculoLcd) {
	BTFSS      _flagsA+0, 5
	GOTO       L_setSetPoint45
;circuito_rcrc.c,362 :: 		calculoLcd();
	CALL       _calculoLcd+0
;circuito_rcrc.c,363 :: 		flagCalculoLcd = 0;
	BCF        _flagsA+0, 5
;circuito_rcrc.c,364 :: 		}
L_setSetPoint45:
;circuito_rcrc.c,365 :: 		}
L_end_setSetPoint:
	RETURN
; end of _setSetPoint

#line 1 "C:/Users/Clesio/Documents/N7/controle-rc-malha-fechada-ptbr/codigo-fonte/circuito_rcrc.c"
#line 36 "C:/Users/Clesio/Documents/N7/controle-rc-malha-fechada-ptbr/codigo-fonte/circuito_rcrc.c"
sbit LCD_RS at RA2_bit;
sbit LCD_EN at RA3_bit;
sbit LCD_D4 at RB1_bit;
sbit LCD_D5 at RB2_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

sbit LCD_RS_Direction at TRISA2_bit;
sbit LCD_EN_Direction at TRISA3_bit;
sbit LCD_D4_Direction at TRISB1_bit;
sbit LCD_D5_Direction at TRISB2_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;



char flagsA = 0x00, flagsB = 0x00;
signed char selecaoModo = 0, tensaoDesejada = 0;
unsigned int leituraAdc = 0;
int erroMedidas = 0;
unsigned char auxiliarContagemTimerZero = 1, ciclosControlador = 0;
double valorPwm = 0.0;
double ultimoErro = 0.0;
double ganhoProporcional = 60.0,
 ganhoDerivativo = 10.0,
 ganhoIntegral = 30.0,
 valorIdealAdc = 0.0,
 integral = 0.0;



void configurarRegistradores();
void iniciarLcd();
void iniciarPwm();
void testarBotoes();
void acoesACadaCemMs();
void menuVout();
void menuCargaCoulomb();
void menuNumeroEletrons();
void calculoLcd();
void setSetPoint();



void interrupt() {


 if (TMR0IF_bit) {
 auxiliarContagemTimerZero++;
 if ( flagsA.F6 ) {
  flagsB.F1  = 1;
 }


 if (auxiliarContagemTimerZero == 10) {
 acoesACadaCemMs();

 auxiliarContagemTimerZero = 0;
 }



 TMR0IF_bit = 0;
 TMR0 = 99;
 }

}



void main() {

 configurarRegistradores();
 iniciarLcd();
 iniciarPwm();
 UART1_Init(9600);
 delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);

 while(1) {

 testarBotoes();
 switch(selecaoModo) {
 case 0:
 Lcd_Chr (1,1, '<');
 Lcd_Chr (1,16, '>');
 Lcd_Chr (1,6, 'V');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('u');
 Lcd_Chr_Cp ('t');

 if ( flagsA.F3 ) {
  flagsA.F6  = 1;
  flagsA.F7  = 0;
  flagsB.F0  = 0;
 menuVout();
 }

 break;
 case 1:
 Lcd_Chr (1,1, '<');
 Lcd_Chr (1,16, '>');
 Lcd_Chr (1,4, 'C');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('r');
 Lcd_Chr_Cp ('g');
 Lcd_Chr_Cp ('a');

 if ( flagsA.F3 ) {
  flagsA.F6  = 0;
  flagsA.F7  = 1;
  flagsB.F0  = 0;
 menuCargaCoulomb();
 }

 break;
 case 2:
 Lcd_Chr (1,1, '<');
 Lcd_Chr (1,16, '>');
 Lcd_Chr (1,4, 'E');
 Lcd_Chr_Cp ('l');
 Lcd_Chr_Cp ('e');
 Lcd_Chr_Cp ('t');
 Lcd_Chr_Cp ('r');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('s');

 if ( flagsA.F3 ) {
  flagsA.F6  = 0;
  flagsA.F7  = 0;
  flagsB.F0  = 1;
 menuNumeroEletrons();
 }

 break;
 }
 }
}



void configurarRegistradores() {



 TRISB = 0b11001001;
 TRISA = 0b00110011;
 CMCON = 0x07;
 ADCON0 = 0b00000001;
 ADCON1 = 0b10001110;

 TRISC.F0 = 0;
 PORTC.F0 = 0;

 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;



 INTCON = 0b11100000;
 TMR0 = 99;
 OPTION_REG = 0b10000111;
#line 217 "C:/Users/Clesio/Documents/N7/controle-rc-malha-fechada-ptbr/codigo-fonte/circuito_rcrc.c"
}

void iniciarLcd() {
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 2, "Lab Controle 1");
 Lcd_Out(2, 3, "IFSP - SPO");
}

void iniciarPwm() {
 PWM1_Init(1000);
 PWM1_Set_Duty(0);
 PWM1_Start();
}

void testarBotoes() {

 if (! PORTB.F0 ) {
  flagsA.F1  = 1;
 }

 if ( flagsA.F1  &&  PORTB.F0 ) {
  flagsA.F1  = 0;
 selecaoModo++;
 Lcd_Cmd(_LCD_CLEAR);
 }

 if (! PORTB.F3 ) {
  flagsA.F2  = 1;
 }

 if ( flagsA.F2  &&  PORTB.F3 ) {
  flagsA.F2  = 0;
 selecaoModo--;
 Lcd_Cmd(_LCD_CLEAR);
 }

 if (selecaoModo < 0) {
 selecaoModo = 2;
 }
 if (selecaoModo > 2) {
 selecaoModo = 0;
 }
}

void acoesACadaCemMs() {

 if (! PORTB.F6 ) {
  flagsA.F3  = 1;
  flagsA.F4  = 0;
 } else if (! PORTB.F7 ) {
  flagsA.F4  = 1;
  flagsA.F3  = 0;
 }
}

void menuVout() {

 Lcd_Chr (1,1, ' ');
 Lcd_Chr (1,16, ' ');
 Lcd_Chr(1, 10, ':');
 Lcd_Chr(2, 2, 'S');
 Lcd_Chr_Cp('e');
 Lcd_Chr_Cp('t');
 Lcd_Chr_Cp('P');
 Lcd_Chr_Cp('o');
 Lcd_Chr_Cp('i');
 Lcd_Chr_Cp('n');
 Lcd_Chr_Cp('t');
 Lcd_Chr_Cp(':');
 Lcd_Chr(2, 15, 'V');



  flagsA.F5  = 1;
 do {
 setSetPoint();

 if ( flagsB.F1 ) {
 leituraAdc = ADC_Get_Sample(0);
 valorIdealAdc = (int) tensaoDesejada * 20.4;


 erroMedidas = (valorIdealAdc - leituraAdc);
 ultimoErro = erroMedidas;
 integral += ganhoIntegral * ((int)((erroMedidas - ultimoErro)* 0.010) >> 1);
 if (integral > 511) {
 integral = 0;
 }

 valorPwm = (ganhoProporcional * ((int)erroMedidas >> 2)) + integral;

 if (valorPwm > 255) valorPwm = 255;

 PWM1_Set_Duty(valorPwm);
 ultimoErro = erroMedidas;
  flagsB.F1  = 0;
 }
 } while (! flagsA.F4 );

 Lcd_Cmd(_LCD_CLEAR);
 PWM1_Set_Duty(0);
 tensaoDesejada = 0;
  flagsA.F6  = 0;
}

void menuCargaCoulomb() {

 Lcd_Chr (1,1, ' ');
 Lcd_Chr (1,16, ' ');
 Lcd_Chr(1, 9, ':');

 do {
 } while(! flagsA.F4 );

 Lcd_Cmd(_LCD_CLEAR);
}

void menuNumeroEletrons() {

 Lcd_Chr (1,1, ' ');
 Lcd_Chr (1,16, ' ');
 Lcd_Chr(1, 12, ':');

 do {
 } while (! flagsA.F4 );

 Lcd_Cmd(_LCD_CLEAR);
  flagsA.F7  = 0;
}

void setSetPoint() {
 if (! PORTB.F0 ) {
  flagsA.F1  = 1;
 }

 if ( PORTB.F0  &&  flagsA.F1 ) {
  flagsA.F1  = 0;
 tensaoDesejada++;
 if (tensaoDesejada > 25) {
 tensaoDesejada = 25;
 }
  flagsA.F5  = 1;
 }

 if (! PORTB.F3 ) {
  flagsA.F2  = 1;
 }

 if ( PORTB.F3  &&  flagsA.F2 ) {
  flagsA.F2  = 0;
 tensaoDesejada--;
 if (tensaoDesejada < 0) {
 tensaoDesejada = 0;
 }
  flagsA.F5  = 1;
 }

 if ( flagsA.F5 ) {
 calculoLcd();
  flagsA.F5  = 0;
 }
}

void calculoLcd() {

 char dezenaLcd, unidadeLcd;
 dezenaLcd = 0x00;
 unidadeLcd = 0x00;


 dezenaLcd = (((tensaoDesejada / 10) % 10) + '0');
 unidadeLcd = ((tensaoDesejada % 10) + '0');

 Lcd_Chr(2, 12, dezenaLcd);
 Lcd_Chr(2, 13, '.');
 Lcd_Chr(2, 14, unidadeLcd);

}

// Mapeamento de flags e hardware:
#define limparLcd flagsA.F0
#define flagIncremento flagsA.F1
#define flagDecremento flagsA.F2
#define pinoDebug PORTC.F0
#define botaoIncremento PORTB.F0
#define botaoDecremento PORTB.F3
#define botaoEnter PORTB.F6
#define botaoBack PORTB.F7

// Configuração dos pinos do LCD:
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

// Variaveis globais:
char flagsA = 0x00;
char milharLcd, centenaLcd = 0x00, 
     dezenaLcd = 0x00, unidadeLcd = 0x00;
signed char selecaoModo = 0;
unsigned int leituraAdc = 0;
char auxiliarContagemTimer0 = 0x00;

// Declaração de funções:
void configurarRegistradores();
void iniciarLcd();
void iniciarPwm();
void testarBotoes();

// Função de interrupção:
void interrupt() {

     if (TMR0IF_bit) {
       TMR0IF_bit = 0;
       pinoDebug = !pinoDebug;
     }

}

// Funão principal:
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
              Lcd_Chr (1,4, 'V');
              Lcd_Chr_Cp ('o');
              Lcd_Chr_Cp ('u');
              Lcd_Chr_Cp ('t');
             break;
      case 1:
              Lcd_Chr (1,1, '<');
              Lcd_Chr (1,16, '>');
              Lcd_Chr (1,4, 'C');
              Lcd_Chr_Cp ('a');
              Lcd_Chr_Cp ('r');
              Lcd_Chr_Cp ('g');
              Lcd_Chr_Cp ('a');
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
             break;
    }

  }
}

void configurarRegistradores() {

  // Registradores referentes a IO's:
  
  TRISB = 0b11001001;
  TRISA = 0b00110011;
  CMCON = 0x07;
  ADCON0 = 0b00000001;
  ADCON1 = 0b00001110;
  TRISC.F0 = 0;
  PORTC.F0 = 0;
  
  PORTA = 0x00;
  PORTB = 0x00;
  PORTC = 0x00;
  
  // Registradores referentes aos times:

  INTCON = 0b11100000;
  TMR0 = 0x00;
  OPTION_REG = 0b10000000; // Ultimos 3 bits setam o prescaler:
  /*
                                    000      1 : 2
                                    001      1 : 4
                                    010      1 : 8
                                    011      1 : 16
                                    100      1 : 32
                                    101      1 : 64
                                    110      1 : 128
                                    111      1 : 256

                      Equação tempo de estouro:
               --------------------------------------------
              | Tovf = (256 - TMR0) * prescaler * 4/fosc   |
               --------------------------------------------
  */
  
  
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

  if (!botaoIncremento) {
    flagIncremento = 1;
  }
  
  if (flagIncremento && botaoIncremento) {
    flagIncremento = 0;
    selecaoModo++;
    Lcd_Cmd(_LCD_CLEAR);
  }
  
  if (!botaoDecremento) {
    flagDecremento = 1;
  }
  
  if (flagDecremento && botaoDecremento) {
    flagDecremento = 0;
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
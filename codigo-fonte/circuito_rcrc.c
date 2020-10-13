/*
  **projeto open-source**

  Projeto da disciplina de laboratório de sistemas de controle (IFSP-SPO)
  ministrada de forma excepcionalmente remota devido à pandemia de Covid-19
  durante o ano de 2020.

  uC: PIC 16f876A
  XTAL: 16MHz
  IDE: MikroC Pro for PIC v.7.6.0

  Iniciado em 23/09/2020.
  Data da última atualização: 28/09/2020
*/

// ============================================================================
// Mapeamento de flags e hardware:
#define limparLcd flagsA.F0
#define flagIncremento flagsA.F1
#define flagDecremento flagsA.F2
#define flagEntradaMenu flagsA.F3
#define flagSaidaMenu flagsA.F4
#define flagCalculoLcd flagsA.F5
#define dentroDoMenuUm flagsA.F6
#define dentroDoMenuDois flagsA.F7
#define dentroDoMenuTres flagsB.F0
#define flagCalculoControlador flagsB.F1
#define pinoDebug PORTC.F0
#define botaoIncremento PORTB.F0
#define botaoDecremento PORTB.F3
#define botaoEnter PORTB.F6
#define botaoBack PORTB.F7

// ============================================================================
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

// ============================================================================
// Variaveis globais:
char flagsA = 0x00, flagsB = 0x00;
signed char selecaoModo = 0, tensaoDesejada = 0;
int leituraAdc = 0, cargaDesejada = 0;
double numeroEletrons = 0;
double erroMedidas = 0.0;
unsigned char auxiliarContagemTimerZero = 0, ciclosControlador = 0;
double valorPwm = 0.0;
double ultimoErro = 0.0;
double ganhoProporcional = 3.75918846489949,  // 60
       ganhoDerivativo = 0.138568283962685,   // 0.250
       ganhoIntegral = 9.57720983847429,
       valorIdealAdc = 0.0,
       integral = 0.0,
       derivada = 0.0;

// ============================================================================
// Declaração de funções:
void configurarRegistradores();
void iniciarLcd();
void iniciarPwm();
void testarBotoes();
void acoesACadaCemMs();
void menuVout();
void menuCargaCoulomb();
void menuNumeroEletrons();
void calculoLcd(char modo);
void setSetPoint();
void enviarDadosSerial(int *leituraAdcPtr);
int filtrarLeitura();
void setCarga();
void calcularPid();
void setNumeroEletrons();

// ============================================================================
// Função de interrupção:
void interrupt() {

     // Este laço é validado a cada 10ms
     if (TMR0IF_bit) {
       auxiliarContagemTimerZero++;
       if (dentroDoMenuUm || dentroDoMenuDois || dentroDoMenuTres) {
         flagCalculoControlador = 1;
       }

       // Este laço é validado a cada 100ms
       if (auxiliarContagemTimerZero == 10) {
         acoesACadaCemMs();

         auxiliarContagemTimerZero = 0;
       }



       TMR0IF_bit = 0;
       TMR0 = 99;
     }

}

// ============================================================================
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
        Lcd_Chr (1,6, 'V');
        Lcd_Chr_Cp ('o');
        Lcd_Chr_Cp ('u');
        Lcd_Chr_Cp ('t');

        if (flagEntradaMenu) {
          dentroDoMenuUm = 1;
          dentroDoMenuDois = 0;
          dentroDoMenuTres = 0;
          menuVout();
        }

        break;
      case 1:
        Lcd_Chr (1,1, '<');
        Lcd_Chr (1,16, '>');
        Lcd_Chr (1, 6, 'C');
        Lcd_Chr_Cp ('a');
        Lcd_Chr_Cp ('r');
        Lcd_Chr_Cp ('g');
        Lcd_Chr_Cp ('a');

        if (flagEntradaMenu) {
          dentroDoMenuUm = 0;
          dentroDoMenuDois = 1;
          dentroDoMenuTres = 0;
          menuCargaCoulomb();
        }

        break;
      case 2:
        Lcd_Chr (1, 1, '<');
        Lcd_Chr (1, 16, '>');
        Lcd_Chr (1, 4, 'E');
        Lcd_Chr_Cp ('l');
        Lcd_Chr_Cp ('e');
        Lcd_Chr_Cp ('t');
        Lcd_Chr_Cp ('r');
        Lcd_Chr_Cp ('o');
        Lcd_Chr_Cp ('n');
        Lcd_Chr_Cp ('s');

        if (flagEntradaMenu) {
          dentroDoMenuUm = 0;
          dentroDoMenuDois = 0;
          dentroDoMenuTres = 1;
          menuNumeroEletrons();
        }

        break;
    }
  }
}

// ============================================================================
// Desenvolvimento de funções auxiliares
void configurarRegistradores() {

  // Registradores referentes a IO's:

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

  // Registradores referentes aos times:

  INTCON = 0b11100000;
  TMR0 = 99;
  OPTION_REG = 0b10000111; // Ultimos 3 bits setam o prescaler:
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

void acoesACadaCemMs() {

  if (!botaoEnter) {
    flagEntradaMenu = 1;
    flagSaidaMenu = 0;
  } else if (!botaoBack) {
    flagSaidaMenu = 1;
    flagEntradaMenu = 0;
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

  flagCalculoLcd = 1;
  do {
    setSetPoint();

    if (flagCalculoControlador) {
      calcularPid();
      flagCalculoControlador = 0;
    }
  }  while (!flagSaidaMenu);

  Lcd_Cmd(_LCD_CLEAR);
  PWM1_Set_Duty(0);
  tensaoDesejada = 0;
  dentroDoMenuUm = 0;
}

void menuCargaCoulomb() {
  Lcd_Chr (1,1, ' ');
  Lcd_Chr (1,16, ' ');
  Lcd_Chr(1, 11, ':');
  Lcd_Chr(2, 6, 'u');
  Lcd_Chr_Cp('C');
  Lcd_Chr(2, 9, '=');
  Lcd_Chr(2, 14, 'V');

  flagCalculoLcd = 1;
  // Q = C*V -> Qmax = 250uC
  do {
     setCarga();
     if (flagCalculoControlador) {
      calcularPid();
      flagCalculoControlador = 0;
    }
  } while(!flagSaidaMenu);

  Lcd_Cmd(_LCD_CLEAR);
  PWM1_Set_Duty(0);
  cargaDesejada = 0;
  tensaoDesejada = 0;
  dentroDoMenuDois = 0;
}

void menuNumeroEletrons() {
  Lcd_Chr (1,1, ' ');
  Lcd_Chr (1,16, ' ');
  Lcd_Chr(1, 12, ':');
  Lcd_Chr(2, 10, '=');
  Lcd_Chr(2, 15, 'V');
  
  flagCalculoLcd = 1;
  // Carga elétron: 1,6E-19 C
  do {
  // Numero de elétrons incrementado a cada passo: 6.25x10^13
  // Numero de passos: 25
  // Total de elétrons: 1.5625x10^15
    setNumeroEletrons();
    if (flagCalculoControlador) {
      calcularPid();
      flagCalculoControlador = 0;
    }


  } while (!flagSaidaMenu);

  Lcd_Cmd(_LCD_CLEAR);
  PWM1_Set_Duty(0);
  dentroDoMenuDois = 0;
  tensaoDesejada = 0;
}

void setSetPoint() {

  if (!botaoIncremento) {
      flagIncremento = 1;
    }

    if (botaoIncremento && flagIncremento) {
      flagIncremento = 0;
      tensaoDesejada++;
      if (tensaoDesejada > 50) {
        tensaoDesejada = 50;
      }
      flagCalculoLcd = 1;
    }

    if (!botaoDecremento) {
      flagDecremento = 1;
    }

    if (botaoDecremento && flagDecremento) {
       flagDecremento = 0;
       tensaoDesejada--;
       if (tensaoDesejada < 0) {
         tensaoDesejada = 0;
       }
       flagCalculoLcd = 1;
    }

    if (flagCalculoLcd) {
      calculoLcd('V');
      flagCalculoLcd = 0;
    }
}

void setCarga() {
  if (!botaoIncremento) {
    flagIncremento = 1;
  }

  if (botaoIncremento && flagIncremento) {
    flagIncremento = 0;
    cargaDesejada += 10;
    flagCalculoLcd = 1;
    if (cargaDesejada > 250) cargaDesejada = 250;
    tensaoDesejada = cargaDesejada / 10;
  }

  if (!botaoDecremento) {
    flagDecremento = 1;
  }

  if (botaoDecremento && flagDecremento) {
    flagDecremento = 0;
    cargaDesejada -= 10;
    flagCalculoLcd = 1;
    if (cargaDesejada < 0) cargaDesejada = 0;
    tensaoDesejada = cargaDesejada / 10;
  }

  if (flagCalculoLcd) {
    flagCalculoLcd = 0;
    calculoLcd('C');
  }

}

void setNumeroEletrons() {
  if (!botaoIncremento) {
    flagIncremento = 1;
  }
  
  if (!botaoDecremento) {
    flagDecremento = 1;
  }

  if (botaoIncremento && flagIncremento) {
    flagIncremento = 0;
    tensaoDesejada++;
    if (tensaoDesejada > 25)
      tensaoDesejada = 25;
    flagCalculoLcd = 1;
  }
  
  if (botaoDecremento && flagDecremento) {
    flagDecremento = 0;
    tensaoDesejada--;
    flagCalculoLcd = 1;
  }
  
  if (flagCalculoLcd) {
    flagCalculoLcd = 0;
    calculoLcd('E');
  }
  
}

void calculoLcd(char modo) {

  char _centenaLcd = 0, _dezenaLcd = 0, _unidadeLcd = 0;

  switch (modo) {
    case 'V':
      Lcd_Chr(2, 12, (((tensaoDesejada / 10) % 10) + '0'));
      Lcd_Chr(2, 13, '.');
      Lcd_Chr(2, 14, ((tensaoDesejada % 10) + '0'));
    break;

    case 'C':
      Lcd_Chr(2, 3, ((cargaDesejada / 100) % 10) + '0');
      Lcd_Chr_Cp((((cargaDesejada / 10) % 10) + '0'));
      Lcd_Chr_Cp(((cargaDesejada % 10) + '0'));
      Lcd_Chr(2, 11, (((tensaoDesejada / 10) % 10) + '0'));
      Lcd_Chr_Cp('.');
      Lcd_Chr_Cp(((tensaoDesejada % 10) + '0'));
    break;
    
    case 'E':
      _unidadeLcd = ((tensaoDesejada % 10) + '0');
      _dezenaLcd = ((tensaoDesejada / 10) % 10) + '0';
      
      Lcd_Chr(2, 2, _dezenaLcd);
      Lcd_Chr_Cp(_unidadeLcd);
      Lcd_Chr_Cp('*');
      Lcd_Chr_Cp('6');
      Lcd_Chr_Cp('.');
      Lcd_Chr_Cp('2');
      Lcd_Chr_Cp('5');
      Lcd_Chr(2, 12, _dezenaLcd);
      Lcd_Chr_Cp('.');
      Lcd_Chr_Cp(_unidadeLcd);
    break;
  }


}

int filtrarLeitura() {
  int somatorio = 0, i;
  static int leituras[] = {0, 0, 0, 0, 0, 0, 0, 0};
  static char index = 0;

  index++;
  if (index > 7) index = 0;

  leituras[index] = ADC_Get_Sample(0);

  for (i = 0; i < 8; i++) {
    somatorio += leituras[i];
  }

  return (somatorio >> 3);

}

void calcularPid() {
      leituraAdc = filtrarLeitura();
      // Adequando o valor inputado a um valor AD
      // (1023 / 2) / 25
      valorIdealAdc = (int)tensaoDesejada * 20.46;


      erroMedidas = (valorIdealAdc - leituraAdc);
      integral = integral + ganhoIntegral * ((erroMedidas + ultimoErro) / 2) * 0.010;

      if (integral > 255) integral = 255;     // Anti-Windup
      else if (integral < -255) integral = -255;

      derivada = ganhoDerivativo * (erroMedidas - ultimoErro) / 0.010;

      ultimoErro = erroMedidas;

      valorPwm = (ganhoProporcional * ((int)erroMedidas >> 2)) + integral + derivada;

      if (valorPwm > 255) valorPwm = 255;
      else if (valorPwm < 0) valorPwm = 0;
      PWM1_Set_Duty((char)valorPwm);
}

// Depracated
/*void enviarDadosSerial(int *leituraAdcPtr) {
  static char _unidadeLeitura,_dezenaLeitura,
              _centenaLeitura, _milharLeitura;

  _milharLeitura = (((*leituraAdcPtr / 1000) % 10) + '0');
  _centenaLeitura = (((*leituraAdcPtr / 100) % 10) + '0');
  _dezenaLeitura = (((*leituraAdcPtr / 10) % 10) + '0');
  _unidadeLeitura = ((*leituraAdcPtr % 10) + '0');

  UART1_Write(_milharLeitura);
  UART1_Write(_centenaLeitura);
  UART1_Write(_dezenaLeitura);
  UART1_Write(_dezenaLeitura);
  UART1_Write(';');
}*/

#include <setjmp16.h>

#define TRY do{ jmp_buf ex_buf__; switch( setjmp(ex_buf__) ){ case 0: while(1){
#define EXCEPT(x) break; case x:
#define FINALLY break; } default: {
#define ETRY } } }while(0)
#define THROW(x) longjmp(ex_buf__, x)

#define EXCEPTION_1 (1)
#define EXCEPTION_2 (2)
#define EXCEPTION_3 (3)

#define true 1
#define false 0

//----------------------------------------------- Declaracao de Variaveis Globais e constantes globais  ---------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------

char str_segundo[10], str_minuto[10], str_hora[10];
char segundo, minuto, hora, contagem;

//-----------------------------------------------Final de Declaracao de Variaveis Glbais e constantes globais ---------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------- Definicoes LCD   --------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------

sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB0_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB0_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// --------------------------------------------------------------   Final de Definicoes LCD ---------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------

void interrupt(){
    contagem++;                            //para cada interrpção do TIMER1 incrementa a variável contagem
    TMR1L=0xDC;                            //recarrega o TMR1L;
    TMR1H=0x0B;                            //recarrega o TMR1H;
    PIR1.TMR1IF = 0;                       //limpa o overflow.
   }

char init(){
    char *ok = "OK";
    char *error = "ERROR";

    TRY
       {
                                            //Definicao dos registradores de configuracao de entrada e saida (TRIS) e estado inicial das PORTS        TRISD =1;
        TRISA = 0;
        PORTA = 0;
        
        TRISB = 0;
        TRISB.b6 = 1;
        TRISB.b7 = 1;
        PORTB = 0;
       
        TRISC = 0;
        PORTC= 0;

        TRISD = 0;
        PORTD = 0;

        ADCON1 = 0x0F;                        //configura todos pinos A/D como I/O de uso geral

        /*lcd_init();
        lcd_cmd (_lcd_clear);
        lcd_cmd (_lcd_cursor_off);
        lcd_out (1,1, "Hora:");
        lcd_out (2,1, "Dia:");
        */
        INTCON.GIE=1;                          //habilita interrupção global
        INTCON.PEIE=1;                         //habilita interrupção dos perifericos
        PIE1.TMR1IE=1;                         //habilita interrupção do TIMER1
                                               // TMR1 recebe o valor 62500(65536 - 3036), que em Hexadecimal vale 0x0BDC ---> 3036
        TMR1L=0xDC;                            // byte menos significativo
        TMR1H=0x0B;                            // byte mais significativo
        T1CON=0b00110001;                      // Modo Temporizador, prescaler 1:4, clock interno

        contagem = 0;
        segundo = 0;
        minuto = 0;
        hora = 0;
       }
    
    EXCEPT(EXCEPTION_1)
       {
        return error;
       }
    ETRY;
    return ok;
}

void main(){
    
    char *ok = "OK";
    char *str;
    unsigned short int res;
    
    do{
       str = init();
       res = strncmp(ok, str, 2);
       }while (res != 0);

    while(true)
       {
        if (contagem == 10){
            segundo++;
            contagem = 0;
           }

        if (segundo == 60){
            minuto++;
            segundo = 0;
           }

        if (minuto == 60){
            hora++;
            minuto = 0;
           }
        
        if (hora == 24)
               hora = 0;
        
        PORTD = segundo;
        PORTC = minuto;
        PORTB = hora;
        
        /*
        bytetostr (segundo, str_segundo);
        bytetostr (minuto, str_minuto);
        bytetostr (hora, str_hora);

        lcd_out (1,6, str_hora);
        lcd_chr_cp (':');
        lcd_out_cp (str_minuto);
        lcd_chr_cp (':');
        lcd_out_cp (str_segundo);
        */
        if ((Button (&PORTB, 6, 250, 1)))
            minuto++;
        
        else if ((Button (&PORTB, 7, 250, 1)))
            hora++;
       }
}
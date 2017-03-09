#line 1 "D:/Projetos Sistemas Emabarcados/MICROCHIP/Projetos PIC/Projeto 044 - Binary_Clock/MyProject.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/setjmp16.h"
#line 32 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/setjmp16.h"
typedef volatile char jmp_buf[3];
#line 20 "D:/Projetos Sistemas Emabarcados/MICROCHIP/Projetos PIC/Projeto 044 - Binary_Clock/MyProject.c"
char str_segundo[10], str_minuto[10], str_hora[10];
char segundo, minuto, hora, contagem;







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




void interrupt(){
 contagem++;
 TMR1L=0xDC;
 TMR1H=0x0B;
 PIR1.TMR1IF = 0;
 }

char init(){
 char *ok = "OK";
 char *error = "ERROR";

  do{ jmp_buf ex_buf__; switch( ex_buf__[0] = PCLATH, ex_buf__[1] = PCL+ 2 , ex_buf__[2] = 0  ){ case 0: while(1){ 
 {

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

 ADCON1 = 0x0F;
#line 82 "D:/Projetos Sistemas Emabarcados/MICROCHIP/Projetos PIC/Projeto 044 - Binary_Clock/MyProject.c"
 INTCON.GIE=1;
 INTCON.PEIE=1;
 PIE1.TMR1IE=1;

 TMR1L=0xDC;
 TMR1H=0x0B;
 T1CON=0b00110001;

 contagem = 0;
 segundo = 0;
 minuto = 0;
 hora = 0;
 }

  break; case (1) : 
 {
 return error;
 }
  } } }while(0) ;
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

 while( 1 )
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
#line 150 "D:/Projetos Sistemas Emabarcados/MICROCHIP/Projetos PIC/Projeto 044 - Binary_Clock/MyProject.c"
 if ((Button (&PORTB, 6, 250, 1)))
 minuto++;

 else if ((Button (&PORTB, 7, 250, 1)))
 hora++;
 }
}

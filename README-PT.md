# Relógio Binário

## A proposta

Projeto de um relógio binário, **hardware e software**, que marque horas, minutos e segundos, utilizando um **microcontrolador PIC16F877A**, da Microchip. O relógio binário foi desenvolvido como projeto pessoal, e foi montado em uma placa universal, de acordo com os esquemáticos da pasta Proteus, do mesmo diretório de projeto.

Durante esse README, explicarei o passo a passo para montar um Relógio Binário. :)

## Utilidade

O código foi desenvolvido especificamente para a plataforma PIC. Entretanto, **sendo feitas algumas pequenas modificações de inicalização e configuração de alguns registradores, o projeto pode ser adaptado para outros microcontroladores, de outras fabricantes.**

O projeto foi todo desenvolvido em C, e foram implementadas algumas funções para facilitar o fluxo de código ao longo do projeto, como uma função que imita o 'try; catch' das linguagens orientadas a objetos. Dessa forma, é possível verificar erros, e saber como agir de uma forma bastante inteligente e eficicente.

## Como funciona?

**O relógio começa a marcar a hora a partir do instante 00:00, no momento que é energizado. Para fazer o ajuste da hora desejada, basta usar os push buttons de ajuste de minuto e hora. No momento que o circuito é desenergizado, o relógio perde a hora marcada, pois não há nenhum dispositivo de memória implementado.**

Entretanto, caso seja necessário guardar as configurações de tempo mesmo com o **circuito desenergizado**, pode-se utilizar um **RTC**, e assim fazer apenas a **leitura dos valores do relógio.** Todavia, acredito que fazendo isso perde-se a essência de desenvolver o relógio binário, contador, pensar na lógica de desenvolvimento e em como otimizar o software.

Tipos de arquivos presentes no projeto:

*- O arquivo .c contém o código desenvolvido utilizando C.* </br>
*- O arquivo .asm contém o código traduzido para linaguagem de montagem. (assembly)* </br>
*- O arquivo .hex é o arquivo com formato para ser gravado no microcontrolador, que é traduzido para linguagem de máquina e interpretado.* </br>
*- O arquivo .mccpi é o arquivo que linka todos os arquivos de projeto, criado pelo compilador MikroC, utilizado para desenvolvimento.* </br>
*- Os demais arquivos, são arquivos de configuração criados pelo compilador.* </br>
*- Dentro da pasta /Proteus está o esquemático com o hardware do circuito.*

*Abaixo, tem-se uma imagem do hardware montado no software Proteus.*

![Imgur](http://i.imgur.com/rsIKPXu.png)

Durante a montagem, utilizei LEDs de auto-brilho vermelhos. </br>
Todavia, não recomendo a montagem utilizando LEDs de auto-brilho, pois sua intensidade é fortíssima, e dependendo do ângulo e da distância observadas, machuca e é desconfortável aos olhos. Portanto, dê preferência para utilização de LEDs convencionais.

## O que foi utilizado no projeto?

**Lista de componentes utilizados no projeto:**

1. 1 x Microcontrolador PIC16F877A <br>
2. 1 x Soquete 40 pinos </br>
3. 1 x Regulador de tensão 7805 </br>
4. 3 x Push button </br>
5. 3 x Resistor de 1k ohm </br>
6. 1 x Cristal de 20MHz  </br>
7. 2 x Capacitores de 22pF </br>
8. 1 x Capacitor de 100nF </br>
9. 17 x LEDs </br>
10. 1 x Conector com fios para baterias de 9V
11. 1 x placa universal de

*Abaixo, tem-se uma imagem do circuito montado em uma placa universal.*

![Imgur](http://i.imgur.com/iAL2RE6.jpg)

## Direitos

**O projeto pode ser reproduzido sem problema algum.** </br>
Entretanto, caso isso seja feito, apenas peço para manterem/referenciarem **créditos ao autor**.

Enjoy!

Hollweg


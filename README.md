#Binary Clock

##The purpose

Binary Clock project, **hardware and software**, that counts hours, time, minutes and seconds using the PIC16F877A microcontroller, from Microchip. The Binary Clock was developed as a personal project and it was mounted on an universal soldering board, according with Proteus folder schematics (that I developed).

##Utility

The code was developed specifically to **PIC platform**. However, if some changes were made, mainly in initialization, configuration and some registers, **the project can be adapted to other microcontroller families, from other manufacturers**.

The project was developed in **C** and were implemented some functions to enhance flux code during project, like one function that **mimics the job done by "try catch"**, from object oriented programming languages. In this way, it is possible to verify errors and know how to act in a very smart and intelligent way.
 
##How it works?

The clock starts marking hour from 00:00, in the moment that it's powered. **To adjust time until desired hour and minute you have to use the board push buttons** (in the right side of hour or minute LEDs array). In the moment that the circuit is **de-energized**, the clock **loses its reference** and the actual time because it does not have a memory hardware implemented in board.

However, if you need to store the last marked hour, even with the circuit de-energized, you can use a RTC hardware, and only read its time variables, than display it in the LEDs array. In other way, I think that this kind of "upgrade" is not nice because it makes you miss the essence of build an Binary Clock, since thinking in clock logic, counters, until software otimization.

*- The .c file contains the developed code in C.* </br>
*- The .asm file contains the code translated to assembly* </br>
*- The .hex file is the ready to burn file, containing the code in hexadecimal language.* </br>
*- The .mccpi file is the link between all files in project, created by MikroC compiler (IDE used to software development).* </br>
*- The other files are configuration files, created by compiler.* </br>
*- Inside /Proteus folder it is the project hardware schematic* </br>

Below there is an imagem of the project hardware simulated in Proteus. 

![Imgur](http://i.imgur.com/rsIKPXu.png)

##Which was used in project?

**List of materials**:

1. 1 x PIC16F877A microcontroller <br>
2. 1 x 40 pinos header</br>
3. 1 x 7805 Voltage Regulator </br>
4. 3 x Push button </br>
5. 3 x Resistor 1k ohm </br>
6. 1 x 20MHz Crystal  </br>
7. 2 x 22pF Capacitors </br>
8. 1 x 100nF Capacitors </br>
9. 17 x LEDs </br>
10. 1 x Wired connector to 9V battery </br>
11. 1 x 10x5cm Universal Soldering Board </br>

Below, there is an image of the circuit mounted in an universal soldering board.

![Imgur](http://i.imgur.com/iAL2RE6.jpg)

##Copyrigths

**The project can be reproduced without problem.** </br>
However, I only ask to keep author references. :)


Enjoy!

Hollweg


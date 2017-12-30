# Compiler-fall-1395



Compiler project fall 1395 [University of Kurdistan](http://uok.ac.ir/fa.aspx), with some bugs 😜

# Tools

Download flex and bison from [here](https://sourceforge.net/projects/winflexbison/) and add them to the `Path` variable in windows environment variables.

Download TDM-GCC from [here](http://tdm-gcc.tdragon.net/download).


Use `runner.bat` to generate parser and create parse tree of `input.txt`.

# Guide

   `win_flex  raison.l` generates **lex.yy.c**
   
   `win_bison -d  raison.y` generates **raison.tab.h** and **raison.tab.c**
   
   `gcc -o raison raison.tab.c lex.yy.c` generates the **parser (raison.exe)**
   
   `raison` runs the parser and generates the **output.txt**
   
For any questions leave a message for me in the telegram [@rahmatwaisi](https://t.me/rahmatwaisi)



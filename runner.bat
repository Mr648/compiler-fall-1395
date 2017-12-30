win_flex --verbose raison.l 
win_bison -d raison.y 
gcc -o raison raison.tab.c lex.yy.c  
raison  
pause
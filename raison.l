%option noyywrap

%{
#include<stdio.h>
#include<stdlib.h>
#include "raison.tab.h"
#define YY_DECL int yylex()
int lineNumber = 1;
%}

%%


[\n] {
      lineNumber++;
}

[ \t] ; 

"Program"      {
      return PRGRAM_KW;
}

"While"  {
      return WHILE_KW;
}

"If"     {
      return IF_KW;
}

"For"    {
      return FOR_KW;
}

"Switch"       {
      return SWITCH_KW;
}

"Case"   {
      return CASE_KW;
}

"Default"      {
      return DEFAULT_KW;
}

"Return"       {
      return RETURN_KW;
}

"Break"  {
      return BREAK_KW;
}

"Continue"     {
      return CONTINUE_KW;
}

"Read"   {
      return READ_KW;
}

"Write"  {
      return WRITE_KW;
}

"Else"   {
      return ELSE_KW;
}

"Then"   {
      return THEN_KW;
}

"Integer"      {
      return INTEGER_KW;
}

"Float"  {
      return FLOAT_KW;
}

"Character"    {
      return CHARACTER_KW;
}

"Void"   {
      return VOID_KW;
}

"Exit"      {
      return RAISON_QUIT;
}

"Quit"      {
      return RAISON_QUIT;
}

"["      {
      return LBB; // left box brackets
}

"]"   {
      return RBB;// right box brackets
}

"{"   {
      return LCB; // left curly brackets
}

"}"   {
      return RCB; // right curly brackets
}

"("      {
      return LRB; // left round brackets
}

")"  {
      return RRB; // right round brackets
}

","  {
      return COMMA;
}

";"    {
      return SMC;
}

":"      {
      return COLON;
}

"="      {
      return ASSIGNMENT;
}

"=="     {
      return EQ;
}

"!="     {
      return NE;
}

"<"      {
      return LT;
}

"<="     {
      return LE;
}

">"      {
      return GT;
}

">="     {
      return GE;
}

"!"      {
      return NOT;
}

"+"      {
      return PLUS;
}

"-"      {
      return MINUS;
}

"*"      {
      return MULT;
}

"/"      {
      return DIV;
}

"%"      {
      return REM;
}

"&&"     {
      return SHORT_CIRCUIT_AND;
}

"&"      {
      return AND;
}

"||"     {
      return SHORT_CIRCUIT_OR;
}

"|"      {
      return OR;
}

"\." {
      return DOT;
}

[a-zA-Z]([a-zA-Z0-9_])* {
       return IDENTIFIER;
}

'.' {
      yylval.charval = yytext[0];
      return CHAR_CONSTANT;
}


[0-9]* {
      yylval.intval = atoi(yytext);
      return INTEGER_CONSTANT;
}

[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)? {
      yylval.floatval = atof(yytext);
      return FLOAT_CONSTANT;
}


'.*'|[0-9]*[a-zA-Z]([a-zA-Z0-9_])* {
      return ERROR;
}
      
\"[[:print:]]*\" {
      yylval.strval = yytext;
      return STRING;
}



"//".*  ; // ignore all single line comments
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] // ignore all multyline comments 



%%

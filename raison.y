%{

#include <stdio.h>
#include <stdlib.h>


#define YYSTYPE char *

extern int yylex();
extern int yyparse();


extern FILE* yyin;
extern FILE* yyout;


extern int lineNumber;
extern char* yytext;


void yyerror(const char* errMsg);
%}

%union {
	int intval;
	float floatval;
	char *strval;
	char charval;
}

%token <intval> INTEGER_CONSTANT
%token <floatval> FLOAT_CONSTANT
%token <strval> STRING
%token <charval> CHAR_CONSTANT


%token PRGRAM_KW
%token WHILE_KW
%token IF_KW
%token FOR_KW
%token SWITCH_KW
%token CASE_KW
%token DEFAULT_KW
%token RETURN_KW
%token BREAK_KW
%token CONTINUE_KW
%token READ_KW
%token WRITE_KW
%token ELSE_KW
%token THEN_KW
%token INTEGER_KW
%token FLOAT_KW
%token CHARACTER_KW
%token VOID_KW
%token LBB
%token RBB
%token LCB
%token RCB
%token LRB
%token RRB
%token COMMA
%token SMC
%token COLON
%token ASSIGNMENT
%token EQ
%token NE
%token LT
%token LE
%token GT
%token GE
%token NOT
%token PLUS
%token MINUS
%token MULT
%token DIV
%token REM
%token SHORT_CIRCUIT_AND
%token AND
%token SHORT_CIRCUIT_OR
%token OR
%token DOT
%token DOUBLE_QUOTE
%token SINGLE_QUOTE
%token IDENTIFIER
%token RAISON_QUIT
%token ERROR

%right THEN_KW ELSE_KW
%right ASSIGNMENT
%left AND SHORT_CIRCUIT_OR SHORT_CIRCUIT_AND OR
%left NE EQ
%left LT GT LE GE
%left PLUS MINUS 
%left MULT DEVIDE REM
%left NOT UMINUS


%start program

%%
program: PRGRAM_KW IDENTIFIER LCB field_decl_list method_decl_list RCB	{ fprintf(yyout, "%s\n", "program -> PRGRAM_KW ID { field_decl_list method_decl_list }");}
;

field_decl_list:  					{ fprintf(yyout, "%s\n", "field_decl_list -> epsilon");}
	| field_decl field_decl_list  	{ fprintf(yyout, "%s\n", "field_decl_list -> field_decl field_decl_list");}
;

field_decl: type field_name_list SMC 	{ fprintf(yyout, "%s\n", "field_decl -> type field_name_list ;");}
;

field_name_list: field_name COMMA field_name_list { fprintf(yyout, "%s\n", "field_name_list -> field_name , field_name_list"); }
	| field_name { fprintf(yyout, "%s\n", "field_name_list -> field_name");} 
;

field_name: IDENTIFIER LBB INTEGER_CONSTANT RBB 	{ fprintf(yyout, "%s\n", "field_name -> ID [ INTEGER_CONSTANT ]");}
	| IDENTIFIER   									{ fprintf(yyout, "%s\n", "field_name -> ID"); }
;

method_decl_list:  							{ fprintf(yyout, "%s\n", "method_decl_list -> epsilon"); }
	| method_decl method_decl_list 			{ fprintf(yyout, "%s\n", "method_decl_list -> method_decl method_decl_list");}
;

method_decl: return_type IDENTIFIER LRB formal_parameter_list RRB block { fprintf(yyout, "%s\n", "method_decl -> return_type ID ( formal_parameter_list ) block");}
;

method_call: IDENTIFIER LRB actual_parameters RRB   { fprintf(yyout, "%s\n", "method_call -> ID ( actual_parameters )");}
;

actual_parameters:  			{ fprintf(yyout, "%s\n", "actual_parameters -> epsilon");}
	|actual_parameter_list 		{ fprintf(yyout, "%s\n", "actual_parameters -> actual_parameter_list");}
;

actual_parameter_list: expression COMMA actual_parameter_list 	{ fprintf(yyout, "%s\n", "actual_parameter_list -> expression , actual_parameter_list");}
	|expression 												{ fprintf(yyout, "%s\n", "actual_parameter_list -> expression");}
;

formal_parameter_list:  { fprintf(yyout, "%s\n", "formal_parameter_list -> epsilon");}
	|argument_list   	{ fprintf(yyout, "%s\n", "formal_parameter_list -> argument_list"); }
;

argument_list: type IDENTIFIER COMMA argument_list  		{ fprintf(yyout, "%s\n", "argument_list -> type ID , argument_list");}
	| type IDENTIFIER   									{ fprintf(yyout, "%s\n", "argument_list -> type ID");}
;

type: INTEGER_KW 	 { fprintf(yyout, "%s\n", "type -> INTEGER_KW");}
	| FLOAT_KW   	 { fprintf(yyout, "%s\n", "type -> FLOAT_KW");}
	| CHARACTER_KW   { fprintf(yyout, "%s\n", "constant -> CHAR_CONSTANT");}
;

constant: INTEGER_CONSTANT  	{ fprintf(yyout, "%s\n", "constant -> INTEGER_CONSTANT");}
	| FLOAT_CONSTANT   			{ fprintf(yyout, "%s\n", "constant -> FLOAT_CONSTANT");}
	| CHAR_CONSTANT     		{ fprintf(yyout, "%s\n", "constant -> CHAR_CONSTANT");}
;

return_type: type   	{ fprintf(yyout, "%s\n", "return_type -> type");}
	| VOID_KW   		{ fprintf(yyout, "%s\n", "return_type -> VOID_KW");}

;

return_expression:  	{ fprintf(yyout, "%s\n", "return_expression -> epsilon");}
	| expression   		{ fprintf(yyout, "%s\n", "return_expression -> expression");}

;

block: LCB var_decl_list statement_list RCB  { fprintf(yyout, "%s\n", "block -> { var_decl_list statement_list }");}
;

var_decl_list: 					{ fprintf(yyout, "%s\n", "var_decl_list -> epsilon"); }
	| var_decl var_decl_list  	{ fprintf(yyout, "%s\n", "var_decl_list -> var_decl var_decl_list");}
;

var_decl: type id_list SMC 		{ fprintf(yyout, "%s\n", "var_decl -> type id_list ;");}

;

id_list: IDENTIFIER COMMA id_list   { fprintf(yyout, "%s\n", "id_list -> ID , id_list");}
	| IDENTIFIER   					{ fprintf(yyout, "%s\n", "id_list -> ID");}
;

statement_list:  				 { fprintf(yyout, "%s\n", "statement_list -> epsilon");}
	| statement statement_list    { fprintf(yyout, "%s\n", "statement_list -> statement statement_list");}
;

statement: assignment SMC  													{ fprintf(yyout, "%s\n", "statement -> assignment ;");}
	| method_call SMC    													{ fprintf(yyout, "%s\n", "statement -> method_decl ;");}
	| IF_KW LRB expression RRB THEN_KW block SMC  							{ fprintf(yyout, "%s\n", "statement -> IF_KW ( expression ) THEN_KW block ;");}
	| IF_KW LRB expression RRB THEN_KW block ELSE_KW block SMC   			{ fprintf(yyout, "%s\n", "statement -> IF_KW ( expression ) THEN_KW block ELSE_KW block ; ");}
	| WHILE_KW LRB expression RRB block SMC 								{ fprintf(yyout, "%s\n", "statement -> WHILE_KW ( expression ) block ;");}
	| FOR_KW LRB assignment SMC expression SMC assignment LRB block SMC  	{ fprintf(yyout, "%s\n", "statement -> FOR_KW ( assignment ; expression ; assignment ) block ;");}
	| SWITCH_KW LRB IDENTIFIER RRB LCB case_statements RCB SMC 				{ fprintf(yyout, "%s\n", "statement -> SWITCH_KW ( ID ) { case_statements } ;");}
	| RETURN_KW return_expression SMC    									{ fprintf(yyout, "%s\n", "statement -> RETURN_KW return_expression ; ");}
	| BREAK_KW SMC  														{ fprintf(yyout, "%s\n", "statement -> BREAK_KW ;");}
	| CONTINUE_KW SMC   													{ fprintf(yyout, "%s\n", "statement -> CONTINUE_KW ;");}
	| block    								 								{ fprintf(yyout, "%s\n", "statement -> block");}
	| READ_KW LRB IDENTIFIER LRB SMC 										{ fprintf(yyout, "%s\n", "statement -> READ_KW ( ID ) ;  ");}
	| WRITE_KW LRB write_parameter RRB SMC   								{ fprintf(yyout, "%s\n", "statement -> WRITE_KW ( write_parameter ) ;");}
	| SMC  																	{ fprintf(yyout, "%s\n", "statement -> ;");}
;

case_statements: 											{ fprintf(yyout, "%s\n", "case_statements -> epsilon");}
	| CASE_KW constant COLON statement case_statements 		{ fprintf(yyout, "%s\n", "case_statements -> CASE_KW constant : statement case_statements");}
	| DEFAULT_KW COLON statement  							{ fprintf(yyout, "%s\n", "case_statements -> DEFAULT_KW : statement");}
;

write_parameter: expression  { fprintf(yyout, "%s\n", "write_parameter -> expression");}
	| STRING   				 { fprintf(yyout, "%s\n", "write_parameter -> STRING");}
;

assignment: location ASSIGNMENT expression   { fprintf(yyout, "%s\n", "assignment -> location = expression");}
	| location  							 { fprintf(yyout, "%s\n", "assignment -> location");}
;

location: IDENTIFIER  					 { fprintf(yyout, "%s\n", "location -> ID"); }
	| IDENTIFIER LBB expression RBB 	 { fprintf(yyout, "%s\n", "ID [ expression ]"); }
;

expression: location  				{ fprintf(yyout, "%s\n", "expression -> location");}
	| constant  					{ fprintf(yyout, "%s\n", "expression -> constant");}
	| LCB expression RCB    		{ fprintf(yyout, "%s\n", "expression -> { expression }");}
	| method_call  					{ fprintf(yyout, "%s\n", "expression -> method_call"); } 
	| operational_expression 		{ fprintf(yyout, "%s\n", "expression -> operational_expression");}
;

operational_expression: expression LT expression  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression LE expression  			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression GT expression   			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression GE expression    			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression EQ expression   			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression NE expression			 	 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression AND expression			 	 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression OR expression				 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression SHORT_CIRCUIT_AND expression	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression SHORT_CIRCUIT_OR expression	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression PLUS expression			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression MINUS expression  			 	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression DIV expression			     	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| expression REM expression			     	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| MINUS expression  %prec UMINUS	          { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
	| NOT expression			             	  { fprintf(yyout, "%s\n", "operational_expression -> expression + expression");}
;

%%

int main() {
	yyin = fopen("input.txt" , "r");
	yyout = fopen("ouput.txt" , "w");

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* errMsg) {
	fprintf(yyout, "Error in line: %d\n\tMessage: %s\n\tYYTEXT: %s\n", lineNumber, errMsg, yytext );
	exit(1);
}


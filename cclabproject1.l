
%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}
%%
"->" return EQUAL;
"|" return DELIMIT;
":D" return SCOMMENT;
"(:" return BCOMMENTS;
":)" return BCOMMENTSE;
"decl num" return INTEGER;
"decl alph" return CHARACTER;
"decl dec" return FLOATER;
"decl lrg" return DOUBLER;
[0-9] {yylval.val = atof(yytext); return NUM;}
"\t" return TAB;
. {yylval.a = yytext; return LETTER;}
"\n" return NL;


%%

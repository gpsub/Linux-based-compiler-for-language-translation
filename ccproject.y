%{
void yyerror(char *);
int yylex(void);
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
%}
%token PLUS MINUS NL MUL DIV RB LB POW EQUAL LETTER TAB SCOMMENT BCOMMENTS BCOMMENTSE DELIMIT INTEGER CHARACTER FLOATER DOUBLER
%token <val> NUM
%token <val> LETTER
%type <val> E

%left EQUAL
%left PLUS MINUS
%left MUL DIV
%right POW
%union
{
	int val;
	char *a;
}
%%
PGM : PGM EQUAL  {writestofile("=");}
    | PGM LETTER {writestofile($2);}
    | PGM E {writestofile($2);}
    | PGM NL {writestofile("\n");}
    | PGM TAB {writestofile("      ");}
    | PGM DOUBLER {writestofile("double");}
    | PGM FLOATER {writestofile("float");}
    | PGM CHARACTER {writestofile("char");}
    | PGM INTEGER {writestofile("int");}
    | PGM DELIMIT {writestofile(";");}
    | PGM SCOMMENT {writestofile("//");}
    | PGM BCOMMENTS {writestofile("\\*");}
    | PGM BCOMMENTSE {writestofile("*\\");}

|
;

E : E PLUS E {$$ = $1 + $3;}
  | NUM MINUS NUM {$$ = $1 - $3;}
  | E DIV E {$$ = $1/$3;}
  | E MUL E {$$ = $1 * $3;}
  | NUM {$$ = $1;}
  | LB E RB {$$ = $2;}
  | E POW E {$$ = power($1,$3);}
  
;
%%
void yyerror(char *s)
{
	printf("%s \n", s);
}
int main()
{
	
	
	yyparse();
	
	return 0;
}
int power(int a, int b)
{
	int sum =1;
	for(int i=1;i<=b;i++)
	{
		sum = sum*a;
	}
	return(sum);
}


void writectofile(char a)
{
	FILE *fptr;
	fptr = fopen("testproject.txt","a");
	if(fptr==NULL)
	{
		printf("exit");
		exit(1);
	}
	fprintf(fptr,"%c",a);
	fclose(fptr);

}
void writestofile(char a[])
{
	FILE *fptr;
 	fptr = fopen("testproject1.txt","a");
 	if(fptr==NULL)
 	{
 		printf("exit");
		exit(1);
	}
	if(!(strcmp(a,"\n")))
	{
		fprintf(fptr,"\n");
	}
	else
	{
		fprintf(fptr,"%s",a);
	}
	fclose(fptr);
}

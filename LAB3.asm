*********************************
*
* Name: Luke Schaefer
* ID: 18186970
* Date: 10/4/2022
* Lab3
*
* Program description: calculate the sqaure pyramid number of integer N
*	N is a 1-byte constant
*	RESULT is a 4-byte variable
*	TOP is a 2-byte variable
*	I is a 2-byte variable
*	J is a 2-byte variable
*	SQR is a 4-byte variable
*
*	RESULT = 1^2+2^2+3^2+4^2...+N^2
*	1<=N<=254
*
* Pseudo Code
*
* const int n = 254;
* unsigned int result;
* unsigned int i;
* unsigned int j;
* unsigned int topEnd;
* unsigned int sqr;
* 
* 	result=0;
*	j=n;
*	while(j>0){
*
* 		i=1;
*   		topEnd=2*j;
*		sqr=0;
* 		while(i<topEnd){
* 			sqr+=i;
* 			i+=2;
*		}
*		result+=sqr;
*		j--;
* 	}
**********************************

	ORG	$B000
N	FCB	254		const int n=254
	
	ORG	$B010
RESULT	RMB	4	unsigned int result;
I	RMB	2		unsigned int i;
J	RMB	2		unsigned int j;
TOP	RMB	2		unsigned int topEnd;
SQR	RMB	4		unsigned int sqr;

	ORG	$C000
	CLR	RESULT	result=0;
	CLR 	RESULT+1
	CLR 	RESULT+2
	CLR	RESULT+3

	CLR	SQR		//process of making sqr a 4 byte variable
	CLR	SQR+1

	CLR	J		j=N;
	CLR	J+1
	CLRA
	CLRB
	ADDB	N
	STD 	J

WHILE1	LDD J		while(j>0){
	CMPB	#0
	BLS	ENDWHILE1

	CLR	I		i=1;
	CLR	I+1
	CLRA
	CLRB
	INCB
	STD	I
	 
	CLR	TOP		topEnd=2*j;
	CLR	TOP+1
	CLRA
	CLRB
	ADDD	J		
    	ADDD	J
    	STD	TOP

	CLR	SQR+2		sqr=0;
	CLR	SQR+3
    
WHILE2	LDD	I	while(i<topEnd){
	CMPD	TOP
	BHS	ENDWHILE2

	LDD 	SQR+2		sqr+=i;			
	ADDD	I
	STD	SQR+2

	LDD	I		i+=2;
	ADDD	#2
	STD	I
	BRA	WHILE2	}	
ENDWHILE2
	
	CLRB			result+=sqr;
	INCB
	INCB
	INCB
	INCB

	LDX	#RESULT+3
	LDY	#SQR+3
	CLC

DO	LDAA	0,X
	ADCA	0,Y
	STAA	0,X
	DEX
	DEY
	DECB
UNTIL	BNE	DO

	LDD	J		j--;
	DECB
	STD	J
	BRA	WHILE1	}
ENDWHILE1	STOP
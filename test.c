#include<stdio.h>
#include<limits.h>
//#include<bits/libc-header-start.h>
int main()
{
	int x = 2019101050%100;
	int a = (-1)*(x);
	unsigned int b = (unsigned int ) a ;
	unsigned int c = UINT_MAX-x ;
	int d = ( int ) c ;
	int p = 65490+x;
	short int e = ( short int ) p ;
	unsigned short f = (unsigned short ) a ;
	printf( "%d %u %u %d %hi %hu\n" ,a,b,c,d,e,f);
	return 0;
}

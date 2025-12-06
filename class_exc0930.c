#include <stdio.h>
#include <math.h>

int main(){
	#define _MATH_H
	int num = 8;
	int squareRoot = sqrt(num);

	#ifdef _MATH_H
	printf("%d", squareRoot);

	#else
	exit(EXIT_FAILURE);
	
	return 0;

	#endif
}

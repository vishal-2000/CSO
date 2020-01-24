#include <stdio.h> 
//using namespace std; 
  
// GCD function to compute the greatest 
// divisor among a and b 
int gcd(int a, int b) 
{ 
    if ((a % b) == 0) 
        return b; 
    return gcd(b, a % b); 
} 
  
// Returns first number whose factorial 
// divides x. 
int firstFactorialDivisibleNumber(int x) 
{ 
    int i = 1; // Result 
    int new_x = x; 
  
    for (i = 1; i < x; i++) { 
        // Remove common factors 
        new_x /= gcd(i, new_x); 
  
        // We found first i. 
        if (new_x == 1) 
            break; 
    } 
    return i; 
} 
  
// Driver code 
int main(void) 
{ 
    int x = 16; 
    printf(firstFactorialDivisibleNumber(x)); 
    return 0; 
} 

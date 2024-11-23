#include <iostream>
#include "main.cuh" 

int main() {
  int a = 10;
  int b = 5;
  int result = addGPU(a, b);
  std::cout << a << " + " << b << " = " << result << std::endl;
  return 0;
}
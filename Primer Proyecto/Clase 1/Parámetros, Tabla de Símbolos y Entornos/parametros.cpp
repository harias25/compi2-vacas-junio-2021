#include <stdio.h>
#include <string>
#include "iostream"

using namespace std;

void noCambia(int x){
    cout << "No deberia cambiar: ";
    x = 10;
}

void debeCambiar(int *x){
    cout << "Deberia cambiar: ";
    *x = 30;
}

void pruebaString(string *s){
    cout << *s;
}

int main()
{
    int x = 20;
    cout << x << endl;
    
    noCambia(x);
    cout << x << endl;
    
    debeCambiar(&x);
    cout << x << endl;
    
    string prueba = "Hola";
    pruebaString(&prueba);
    
    return 0;
}

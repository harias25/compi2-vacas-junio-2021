using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Irony.Ast;
using Irony.Parsing;

namespace ProyectoIronyCS.sol.com.analizador
{
    class Sintactico
    {

        public void analizar(String cadena)
        {
            Gramatica gramatica = new Gramatica();
            LanguageData lenguaje = new LanguageData(gramatica);
            Parser parser = new Parser(lenguaje);
            ParseTree arbol = parser.Parse(cadena);
            ParseTreeNode raiz = arbol.Root;

            instrucciones(raiz.ChildNodes.ElementAt(0));

        }

        public void instrucciones(ParseTreeNode actual)
        {
            if (actual.ChildNodes.Count == 2)
            {
                instruccion(actual.ChildNodes.ElementAt(0));
                instrucciones(actual.ChildNodes.ElementAt(1));
            }
            else
            {
                instruccion(actual.ChildNodes.ElementAt(0));
            }
        }

        public void instruccion(ParseTreeNode actual)
        {
            System.Diagnostics.Debug.WriteLine("El valor de la expresion es: " + expresion(actual.ChildNodes.ElementAt(2)));
        }

        public double expresion(ParseTreeNode actual)
        {
            if (actual.ChildNodes.Count == 3)
            {
                string tokenOperador = actual.ChildNodes.ElementAt(1).ToString().Split(' ')[0];
                switch (tokenOperador)
                {
                    case "+":
                        return expresion(actual.ChildNodes.ElementAt(0)) + expresion(actual.ChildNodes.ElementAt(2));
                    case "-":
                        return expresion(actual.ChildNodes.ElementAt(0)) - expresion(actual.ChildNodes.ElementAt(2));
                    case "*":
                        return expresion(actual.ChildNodes.ElementAt(0)) * expresion(actual.ChildNodes.ElementAt(2));
                    case "/":
                        return expresion(actual.ChildNodes.ElementAt(0)) / expresion(actual.ChildNodes.ElementAt(2));
                    default:
                        return expresion(actual.ChildNodes.ElementAt(1));
                }

            }
            else if (actual.ChildNodes.Count == 2)
            {
                return -1 * expresion(actual.ChildNodes.ElementAt(1));
            }
            else
            {
                return Double.Parse(actual.ChildNodes.ElementAt(0).ToString().Split(' ')[0]);
            }
        }
    }
}
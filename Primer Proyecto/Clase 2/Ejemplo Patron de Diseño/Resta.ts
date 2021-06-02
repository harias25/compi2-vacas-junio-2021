import { Expression } from "./Expresion";

export class Resta implements Expression{

    obtenerResultado(valor1:number, valor2:number): number {
        return valor1 - valor2;
    }

}
import { Expression } from "./Expresion";

export class Suma implements Expression{

    obtenerResultado(valor1:number, valor2:number): number {
        return valor1 + valor2;
    }

}
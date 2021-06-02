import { Expresion } from "../Interfaces/Expresion";
import { AST } from "./AST";
import { Entorno } from "./Entorno";
import { Tipo } from "./Tipo";

export class Simbolo implements Expresion {
    public indentificador: string;
    private valor: any;
    private tipo: Tipo;
    linea: number;
    columna: number;

    constructor(tipo:Tipo, id:string, linea:number, columna:number){
        this.indentificador = id;
        this.linea = linea;
        this.columna = columna;
        this.tipo = tipo;
    }

    getTipo(ent: Entorno, arbol: AST): Tipo {
        throw new Error("Method not implemented.");
    }
    getValorImplicito(ent: Entorno, arbol: AST) {
        throw new Error("Method not implemented.");
    }
    
}

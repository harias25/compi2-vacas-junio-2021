import { AST } from "./AST/AST";
import { Entorno } from "./AST/Entorno";
import { Simbolo } from "./AST/Simbolo";
import { Tipo } from "./AST/Tipo";
import { Atributo } from "./Expresiones/Atributo";
import { Objeto } from "./Expresiones/Objeto";
import { Instruccion } from "./Interfaces/Instruccion";

const gramatica = require('./Gramatica/gramatica');

function ejecutarCodigo(entrada:string){
    //traigo todas las raices
    const objetos = gramatica.parse(entrada);
    const entornoGlobal:Entorno = new Entorno(null);
    //recorro todas las raices  RECURSIVA
    objetos.forEach((element:Objeto) => {
        
        //inicializando los entornos del objeto
        const entornoObjeto:Entorno = new Entorno(null);
        if(element.listaAtributos.length>0){
            element.listaAtributos.forEach((atributo:Atributo) => {
                const simbolo:Simbolo = new Simbolo(Tipo.ATRIBUTO,atributo.identificador,atributo.linea,atributo.columna,atributo.valor);
                entornoObjeto.agregar(simbolo.indentificador,simbolo);
            }
            )
        }
        element.entorno = entornoObjeto;
        const simbolo:Simbolo = new Simbolo(Tipo.STRUCT,element.identificador,element.linea,element.columna,element);
        entornoGlobal.agregar(simbolo.indentificador, simbolo);
    })


    


    //const ast:AST = new AST(instrucciones);

    

    //instrucciones.forEach((element:Instruccion) => {
    //    element.ejecutar(entornoGlobal,ast);
    //});
}

ejecutarCodigo(`
    print(1);
    print(true);
    print("hola mundo");
`);
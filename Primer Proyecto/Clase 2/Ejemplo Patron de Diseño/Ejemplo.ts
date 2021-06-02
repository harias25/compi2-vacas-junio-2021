import { Expression } from "./Expresion";
import { Resta } from "./Resta";
import { Suma } from "./Suma";

const suma:Expression = new Suma();
console.log(suma.obtenerResultado(1,2));

const resta:Expression = new Resta();
console.log(resta.obtenerResultado(1,2));
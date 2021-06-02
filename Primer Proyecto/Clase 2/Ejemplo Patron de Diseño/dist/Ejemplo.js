"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Resta_1 = require("./Resta");
const Suma_1 = require("./Suma");
const suma = new Suma_1.Suma();
console.log(suma.obtenerResultado(1, 2));
const resta = new Resta_1.Resta();
console.log(resta.obtenerResultado(1, 2));

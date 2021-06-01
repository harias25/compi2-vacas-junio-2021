function fun1(a: number){
    let b : string = "Hola";
    if(a >= 10){
        b = "Que tal";
    }else{
        b = "Adios";
    }
    console.log(b);
}

function fun2(s: string){
    s = "Segunda Funcion";
    if(true){
        let a: number = 10;
        console.log(a);
        if(true){
            let a: number = 9;
            console.log(a);
            if(true){
                let a: number = 8;
                console.log(a);
            }
            console.log(a);
        }
        console.log(a);
    }
    console.log(a);
}

let a: number = 11;
fun1(a);
fun2("Que tal");
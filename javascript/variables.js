var i = 5;
console.log(i);

if (true) {
    i = 6;
}

console.log(i); //6

var j = 10; 

if (true) {
    var j = 20;
}

console.log(j); // 20 , because var respects funtion block

function varJ() {
    var j = 30;
    console.log(j); //30
}

function overrideJ() {
    j = 40;
}

varJ();
console.log(j); //20
overrideJ();
console.log(j); //40


let x = 5;

if (true) {
    x = 10;
}

console.log(x); //10

if (true) {
    let x = 30;
}
console.log(x); //10, respects block scope
]
let str1 = 'Hello World!';
let str2 = 'Welcome';

console.log(str1.length);
console.log(str1.charAt(0));
console.log(str1.charAt(11));
console.log(str1[2]);

console.log(str1.indexOf('H'));
console.log(str1.indexOf('e'));
console.log(str1.indexOf('l'));
console.log(str1.lastIndexOf('l'));
console.log(str1.lastIndexOf(' '));
console.log(str1.lastIndexOf('Z'));
console.log(str1.indexOf('l', 4)); //it search for the letter/world from the mentioned index
console.log(str1.lastIndexOf('l', 2));


console.log(str1.slice(0, 5));
console.log(str1.slice(10));
console.log(str1.slice(6));
console.log(str1.substring(6));
console.log(str1.slice(-12));
console.log(str1.substring(-9));

console.log(str1.slice(0, 5));
console.log(str1.slice(5, 0));
console.log(str1.substring(5, 0));

console.log(str1.slice(-1, -12));
console.log(str1.substring(-1, 5));

console.log(str1.split(' '));
console.log(str1.split('', 5));
console.log(str1.split('', 2));

console.log(str1.includes('z'));
console.log(str1.includes('h'));
console.log(str1.includes('H', 0));

console.log(str1.startsWith('H'));
console.log(str1.startsWith(' ', 5));

console.log(str1.endsWith('!'));
console.log(str1.endsWith('d!', 12));

let str3 = str1.concat(' ', str2, ' To The ', 'Js ', 'Learning');
console.log(str3);
console.log(str3.repeat(3));

let str4 = '            Hello James                ';
console.log(str4);

// console.log(str4.trimEnd());
// console.log(str4.trimStart());

console.log(str4.trim());

let originalString = 'abc';
console.log(originalString.padStart(10, '001'));
console.log(originalString.padEnd(10, 'abx'));

console.log('b'.localeCompare('a'));
console.log('a'.localeCompare('b'));
console.log('a'.localeCompare('a'));
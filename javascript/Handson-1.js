//Remove duplicates
const numbers = [1, 2, 2, 3, 4, 4, 5];

let uniqueNumbers = new Set(numbers);
console.log(uniqueNumbers);

let uniqueNumbersArr = Array.from(uniqueNumbers);
console.log(uniqueNumbersArr);

//filtering unique users
const users = [
    { id: 1, name: "A" },
    { id: 2, name: "B" },
    { id: 1, name: "A" }
];

let uniqueUsers = new Set();
uniqueUsers = users.filter(user => {
    if (uniqueUsers.has(user.id)) {
        return false;
    }
    uniqueUsers.add(user.id);
    return true;
})

console.log(uniqueUsers);


//Occurances of word
const text = "apple banana apple mango banana apple";
let textArr = text.split(' ');
let occuranceMap = new Map();
textArr.forEach(item => {
    if (!occuranceMap.has(item)) {
        occuranceMap.set(item, 1);
        return;
    }
    occuranceMap.set(item , occuranceMap.get(item) + 1);
});

console.log(occuranceMap);
let mySet = new Set([1, 2, 1, 3, 5]);
console.log(mySet);
console.log(mySet.has(1));
console.log(mySet.has(4));

console.log(mySet.size);
console.log(mySet.delete(4));
console.log(mySet);

mySet.clear();
mySet.add(5);
console.log(mySet);


let myMap = new Map([
    ['Id', 'Test 123'],
    ['age', 12],
    [1, 1], 
    [2, 4],
    [3, 9]
]);

console.log(myMap);

myMap.set(4, 16);
console.log(myMap);
console.log(myMap.has(5));
console.log(myMap.get(4));
console.log(myMap.size);
console.log(myMap.keys());
console.log(myMap.values());

let arrMap = Array.from(myMap);
console.log(arrMap);
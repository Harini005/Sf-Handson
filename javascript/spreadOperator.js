let arr1 = ['a', 'b', 'c'];
let arr2 = ['d', 'e', 'f'];

let arr3 = [...arr1, ...arr2];
console.log(arr3);

let arr4 = [arr1, ...arr2];
console.log(arr4);

//Expanding Strings
let str1 = 'Hello World !';
let str1Arr = [...str1];
console.log(str1Arr);

let str1ArrayString = str1.split('');
console.log(str1ArrayString);

//Combining Objects
let obj1 = { 'salesforce' : 'fullStack'};
let obj2 = { 'JavaScript': 'fullStack' };
let obj3 = { 'JavaScript': 'WebDev' };
let combinedObj = { ...obj1, ...obj2, ...obj3 };
console.log(combinedObj);

const user = { name: "John", age: 25 };
const address = { city: "New York", country: "USA" };

let userInfo = { ...user, ...address };
console.log(userInfo);

//Change the User Age without changing the original object.
const userDetails = { name: "Sara", age: 30, city: "London" };

let updatedUserDetails = { ...userDetails };
updatedUserDetails.age = 40;

console.log(userDetails);
console.log(updatedUserDetails);

//Adding additional details
let product = { id: 101, name: "Laptop", price: 1200 };

product['category'] = 'Device';
console.log(product);

product = { ...product, ...{ 'available': true } };
console.log(product);

product = { ...product, ...{ 'quantity': 4 } };
console.log(product);

//remove salary from the Object
const employee = { id: 1, name: "Mike", salary: 5000 };
let { salary, ...employeeDetails } = employee;
let employeeDetailsObj = { ...employeeDetails };
console.log(employeeDetailsObj);

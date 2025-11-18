let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
arr.forEach(item => {
    if (item % 2 == 0) {
        console.log(`${item} is even number`);
        return;
    }
    console.log(`${item} is odd number`);
})

console.log(arr.length);

let mappedArr = arr.map((item, index, arr) => {
    return item + index * arr[index];
});
console.log(mappedArr);

const users = [
    {
        id: 1,
        name: "Alice",
        age: 28,
        address: {
            city: "New York",
            zip: "10001"
        },
        hobbies: ["reading", "cycling"],
        isActive: true
    },
    {
        id: 2,
        name: "Bob",
        age: 35,
        address: {
            city: "Los Angeles",
            zip: "90001"
        },
        hobbies: ["gaming", "hiking"],
        isActive: false
    },
    {
        id: 3,
        name: "Charlie",
        age: 22,
        address: {
            city: "Chicago",
            zip: "60601"
        },
        hobbies: ["music", "traveling", "photography"],
        isActive: true
    },
    {
        id: 4,
        name: "Diana",
        age: 40,
        address: {
            city: "Miami",
            zip: "33101"
        },
        hobbies: [],
        isActive: true
    }
];

let nameArray = users.map(item => {
    return item['name'];
});
console.log(nameArray);

let cityAndHobbiesCountArr = users.map(item => {
    return { name: item['name'], city: item['address'].city, hobbiesCount: item['hobbies'].length };
})
console.log(cityAndHobbiesCountArr);

let activeUsers = users.filter(item => {
    return item.isActive;
});
console.log(activeUsers);

const orders = [
    {
        orderId: 101,
        customer: "Alice",
        items: [
            { product: "Laptop", price: 1200, quantity: 1 },
            { product: "Mouse", price: 40, quantity: 2 }
        ],
        discount: 0.1 // 10%
    },
    {
        orderId: 102,
        customer: "Bob",
        items: [
            { product: "Monitor", price: 300, quantity: 2 },
            { product: "Keyboard", price: 80, quantity: 1 }
        ],
        discount: 0.05 // 5%
    },
    {
        orderId: 103,
        customer: "Charlie",
        items: [
            { product: "Phone", price: 800, quantity: 1 },
            { product: "Headphones", price: 150, quantity: 2 }
        ],
        discount: 0.2 // 20%
    }
];

let discountedArr = orders.map(item => {
    return {
        orderId: item.orderId,
        customer: item.customer,
        totalAmount: item.items.reduce((acc, order) => {
            return acc + order['price'] * order['quantity'];
        }, 0)
    }
});
console.log(discountedArr);

let quantityShipped = orders.map(item => {
    return {
        [item['customer']]: item.items.reduce((acc, item) => {
            return acc + item.quantity;
        }, 0)
    }
})
console.log(quantityShipped);

let highOrderedValues = orders.map(item => {
    return {
        orderId: item.orderId,
        customer: item.customer,
        totalAmount: item.items.reduce((acc, order) => {
            return acc + order['price'] * order['quantity'];
        }, 0)
    }
}).filter(item => { return item.totalAmount > 800 });
console.log(highOrderedValues);


let reducedValue = arr.reduce((acc, item) => {
    return acc + item;
}, 10);
console.log(reducedValue);

let fruits = ['apple', 'banana', 'cherry', 'grapes', 'oranges'];
let quote = `Here are the healthy fruit items : ${fruits.join('-')}`;
console.log(quote);

/**
 * Give discount to first 3 members in the queue
 */

let peopleInQueue = [
    {
        customer: 'Alice',
        total: 100
    },
    {
        customer: 'Bob',
        total: 200
    },
    {
        customer: 'Jack',
        total: 100
    },
    {
        customer: 'Jill',
        total: 300
    },
    {
        customer: 'Andrew',
        total: 100
    },
    {
        customer: 'Stella',
        total: 500
    },
];

let discountArr = peopleInQueue.slice(0, 3).map(item => {
    return { [item.customer]: item.total - item.total * 0.1 };
});
console.log(discountArr);
console.log(peopleInQueue);

/**
 * Give discount to first 3 members in the queue
 */

let discountToLast3 = peopleInQueue.slice(-3).map(item => {
    return { [item.customer]: item.total - item.total * 0.1 };
})
console.log(discountToLast3);

let charArr = ['h', 'a', 'r', 'i', 'n'];
let sortedArr = charArr.sort();
console.log(sortedArr);

let numArr = [2, 1, 150, 250, 350, 3, 6];
let numSortedArr = numArr.sort(); //sorts with first integer of the number
console.log(numSortedArr);

let ascSortedArr = numArr.sort((a, b) => a - b);
console.log(ascSortedArr);

let descSortedArr = numArr.sort((a, b) => b - a);
console.log(descSortedArr);

let concatedArr = charArr.concat(numArr);
console.log(concatedArr);

let newArr = Array(5);
console.log(newArr);

let filledNewArr = newArr.fill(0, 0, 5);
console.log(filledNewArr);

let namesArr = ['Stephan', 'damon', 'klaus', 'Ellijah', 'Elena', 'jeremy'];
console.log(namesArr.includes('Stephan'));
console.log(namesArr.includes('Damon')); //includes is case sensitive

let reversedNamesArr = namesArr.reverse();
console.log(reversedNamesArr);
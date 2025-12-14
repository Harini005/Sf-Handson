import { LightningElement } from 'lwc';

export default class RandomQuoteGenerator extends LightningElement {
    selectedquote;
    quotes = [
        "The best way to get started is to quit talking and begin doing. – Walt Disney",
        "Don’t let yesterday take up too much of today. – Will Rogers",
        "It’s not whether you get knocked down, it’s whether you get up. – Vince Lombardi",
        "If you are working on something exciting, it will keep you motivated. – Steve Jobs",
        "Success is not in what you have, but who you are. – Bo Bennett",
        "Your limitation—it’s only your imagination.",
        "Push yourself, because no one else is going to do it for you.",
        "Great things never come from comfort zones.",
        "Dream it. Wish it. Do it.",
        "Success doesn’t just find you. You have to go out and get it.",
        "The harder you work for something, the greater you’ll feel when you achieve it.",
        "Don’t watch the clock; do what it does. Keep going. – Sam Levenson",
        "Keep your face always toward the sunshine—and shadows will fall behind you. – Walt Whitman",
        "Opportunities don't happen, you create them. – Chris Grosser",
        "Act as if what you do makes a difference. It does. – William James"
    ];

    connectedCallback() {
        this.generateRandomQuote();
        setInterval(() => { this.generateRandomQuote() }, 10000);
    }

    generateQuote(event) {
        this.generateRandomQuote();
    }

    generateRandomQuote() {
        let idx = Math.floor(Math.random() * this.quotes.length);
        this.selectedquote = this.quotes[idx];
    }

}
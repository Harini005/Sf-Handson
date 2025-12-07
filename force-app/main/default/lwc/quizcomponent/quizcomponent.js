import { LightningElement } from 'lwc';
import CONFIRMATION_SCREEN from './confirmationScreen.html';
import SCREEN from './quizcomponent.html';
import RESULT_SCREEN from './resultScreen.html';

export default class Quizcomponent extends LightningElement {
    i = 0;
    results = {};
    answersResultsArr = {};
    showResultScreen = false;
    displayConfirmation = false;
    isPreviousEnabled = false;
    displayScreen = true;
    optionsSelected = {};
    reviewOptions = [];
    correctAnswers = [];
    questions = [
        {
            'id': 1,
            'question': "What's the annotation used to invoke an Apex method imperatively from LWC?",
            'options': ['@future', '@isTest', '@AuraEnabled', '@cacheable'],
            'answer': '@AuraEnabled'
        },
        {
            'id': 2,
            'question': "What's the annotation used to wire an Apex method to a property or function inLWC?",
            'options': ['@future', '@AuraEnabled', '@AuraEnabled(cacheable=true)'],
            'answer': '@AuraEnabled(cacheable=true)'
        },
        {
            'id': 3,
            'question': "Can we have a css file in the LWC resource bundle?",
            'options': ['Yes', 'No'],
            'answer': 'Yes'
        },
        {
            'id': 4,
            'question': "What are the maximum no of components that we can include in an LWC",
            'options': ['9', '25', '100', 'No limit'],
            'answer': 'No limit'
        }
    ]

    get question() {
        return this.questions[this.i];
    }

    get previousButton() {
        return (this.i > 0) ? true : false;
    }

    get nextButton() {
        return (this.i < this.questions.length - 1) ? true : false;
    }

    get submitButton() {
        return (Number(this.i) == Number(this.questions.length - 1)) ? true : false;
    }

    render() {
        return (this.displayConfirmation && !this.showResultScreen) ? CONFIRMATION_SCREEN : ((!this.showResultScreen) ? SCREEN : RESULT_SCREEN);
    }

    buttonHandler(event) {
        let { label } = event.target;

        if (label === 'Next') {
            this.i = (this.i < this.questions.length) ? this.i + 1 : this.i;
            console.log(this.i);
        }

        if (label === 'Previous') {
            this.i = (this.i > 0) ? this.i - 1 : this.i;
            console.log(this.i);
        }

        if (label === 'Submit') {
            this.displayConfirmation = true;
        }
    }

    optionHandler(event) {
        let { name, label } = event.target;
        this.optionsSelected = { ...this.optionsSelected, ...{ [name]: label } };
        console.log(this.optionsSelected);
    }

    backToTest(event) {
        this.displayConfirmation = false;
    }

    Review(event) {
        this.displayScreen = false;
        this.reviewOptions = this.questions.map(item => {
            if (this.optionsSelected[item.id]) {
                return `${item.id} : ${this.optionsSelected[item.id]}`
            }

            return `${item.id} : - `;
        })
    }

    submitTest(event) {
        this.correctAnswers = this.questions.filter(item => {
            if (item.answer == this.optionsSelected[item.id]) {
                return item;
            }
        })
        this.results['score'] = (this.correctAnswers.length / this.questions.length ) * 100;
        this.results['scoreColor'] = (this.results['score'] >= 75) ? 'slds-text-color_success' : 'slds-text-color_destructive';
        this.answersResultsArr['unAswered'] = this.questions.length - Object.keys(this.optionsSelected).length;
        this.answersResultsArr['answered'] = Object.keys(this.optionsSelected).length;
        this.answersResultsArr['correctAnswers'] = this.correctAnswers.length;
        this.answersResultsArr['incorrectAnswers'] = this.questions.length - this.correctAnswers.length;
        this.showResultScreen = true;
    }


}
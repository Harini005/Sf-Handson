import { LightningElement } from 'lwc';

export default class GetterDemo extends LightningElement {
    ipProvided;
    buttonClicked;
    captureInput(event) {
        this.ipProvided = event.target.value;
    }

    buttonHandler(event) {
        this.buttonClicked = event.target.label;
    }

    get displayMessage() {
        return this.ipProvided != undefined> 0 ? true : false ;
    }

    get message() {
        return this.buttonClicked == 'Capitals' ? this.ipProvided.toUpperCase() : ((this.ipProvided != undefined && this.buttonClicked == 'Smalls') ? this.ipProvided.toLowerCase(): '');
    }
}
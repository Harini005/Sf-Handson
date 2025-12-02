import { LightningElement } from 'lwc';

export default class CrossNamespace extends LightningElement {

    connectedCallback() {
        console.log(window.history);
    }
}
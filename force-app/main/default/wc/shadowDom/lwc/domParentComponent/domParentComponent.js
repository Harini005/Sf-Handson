import { LightningElement } from 'lwc';

export default class DomParentComponent extends LightningElement {
    buttonHandler(event) {
        let pTags = Array.from(this.template.querySelectorAll('p'));
        console.log(pTags);
    }
}


import { LightningElement } from 'lwc';

export default class TextContentDemo extends LightningElement {
    buttonHandler(event) {
        let pTag = this.template.querySelector('p');
        pTag.innerHTML = '<b>This is Another Text</b>';


    }
}
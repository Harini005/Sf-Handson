import { LightningElement } from 'lwc';

export default class CreateElement extends LightningElement {
    selectedValue;
    options = [
        { label: 'checkBox', value: 'checkBox' },
        { label: 'input', value: 'input' },
        { label: 'radio', value: 'radio' }
    ]


    inputHandler(event) {
        this.selectedValue = event.target.value;
        let ipTag = document.createElement('input');
        ipTag.setAttribute('type', this.selectedValue);
        ipTag.setAttribute('class', 'slds-input');

        this.template.querySelector('div').append(ipTag);


       
        
    }
}
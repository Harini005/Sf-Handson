import { LightningElement } from 'lwc';

export default class ClassListDemo extends LightningElement {
    
    buttonHandler(event) {
        let inputs = Array.from(this.template.querySelectorAll('lightning-input'));
        let pTag = this.template.querySelector('p');
        inputs.forEach(item => {
            if (item.checked) {
                pTag.classList.add(item.name);
            }

            else {
                if (pTag.classList.contains(item.name)) {
                    pTag.classList.remove(item.name);
                }
            }
        })
    }
}
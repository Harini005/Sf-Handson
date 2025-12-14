import { LightningElement } from 'lwc';

export default class DatasetDemo extends LightningElement {
    fruits = ['Apple', 'Banana', 'Grapes'];

    buttonHandler(event) {
        let divArr = Array.from(this.template.querySelectorAll('div'));
        divArr.forEach(item => {
            console.log(item.dataset.fruit);
        })
    }
}
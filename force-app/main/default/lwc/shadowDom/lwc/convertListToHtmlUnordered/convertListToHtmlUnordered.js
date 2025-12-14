import { LightningElement } from 'lwc';

export default class ConvertListToHtmlUnordered extends LightningElement {
    buttonHandler(evt) {
        let collection = this.refs.arrayVal.value;

        let arrayOfStrngs = collection.split(';');
        console.log(arrayOfStrngs);

        if (arrayOfStrngs.length == 0) {
            return;
        }

        let ulTag = document.createElement('ol');
        arrayOfStrngs.forEach(item => {
            let createEle = document.createElement('li');
            createEle.innerHTML = `<b>${item}</b>`;
            ulTag.appendChild(createEle);
        })

        this.template.querySelector('div').appendChild(ulTag);
    }
}
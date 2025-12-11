import { LightningElement } from 'lwc';

export default class CreateElement extends LightningElement {
    buttonHandler(event) {
        let liTag = document.createElement('li');
        liTag.textContent = this.refs.skills.value;

        this.template.querySelector('ul').appendChild(liTag);
    }

    styleHandler(event) {
        let pTag = this.template.querySelector('p');
        if (pTag.hasAttribute('style')) {
            pTag.removeAttribute('style');
            return;
        }
        let pAttr = document.createAttribute('style');
        pAttr.value = 'color:white ; background-color : black';

        pTag.setAttributeNode(pAttr);

        let anotherPTag = this.template.querySelector('.another');
        anotherPTag.setAttribute('style', 'color:red; background-color:whiteGhost');

    }
}
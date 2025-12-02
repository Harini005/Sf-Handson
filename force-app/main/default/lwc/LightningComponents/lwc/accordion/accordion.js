import { LightningElement } from 'lwc';
import { log } from 'lightning/logger';

export default class Accordion extends LightningElement {
    activeSections = [];
    manual = true;
    captureHeaders(event) {
        this.manual = true;
        let { openSections } = event.detail;
        this.activeSections = [...this.activeSections, ...openSections];
        this.manual = openSections == '' ? false : true;
        log(this.manual);
    }


    buttonHandler(event) {
        let { label } = event.target.dataset;
        if (this.activeSections.includes(label)) {
            this.activeSections = this.activeSections.filter(item => item != label);
        }
    }

    clickHandler(event) {
        let { label } = event.target.dataset;
        if (this.activeSections.includes(label) && !this.manual) {
            this.activeSections = this.activeSections.filter(item => item != label);
        }
    }
}
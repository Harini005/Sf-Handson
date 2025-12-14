import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    ip = 'Apex';
    changeHandler(event) {
        this.ip = event.target.value; 
    }
}
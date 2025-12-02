import { LightningElement } from 'lwc';
import URL_CLASS from '@salesforce/apex/URLClass.getRequestUrl';

export default class URLClassDemo extends LightningElement {
    currentPageRef;
    connectedCallback() {
        URL_CLASS()
            .then(result => {
                console.log(result);
                this.currentPageRef = result;
            })
            .catch(error => {
                console.error(error);
        })
    }
}
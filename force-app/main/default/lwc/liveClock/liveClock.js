import { LightningElement } from 'lwc';

export default class LiveClock extends LightningElement {
    dateTime;
    connectedCallback() {
        this.updateTime();
        setInterval(() => {
            this.updateTime();
        }, 1000);
    }

    updateTime() {
        const now = new Date();
        this.dateTime = now.toLocaleTimeString();
    }

   
}
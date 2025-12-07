import { LightningElement, track } from 'lwc';

export default class TrackWithNonPrimitive extends LightningElement {
    isDisabled = false;
    info = {
        name: 'John',
        location: 'Singapore',
        company : 'Salesforce'
    }

    buttonLabel = 'Edit';

    buttonHandler(event) {
        let { label } = event.target;
        if (label === 'Edit') {
            this.buttonLabel = 'Save';
           
        }
        else {
            this.buttonLabel = 'Edit';
        }

        this.isDisabled = !this.isDisabled;
    }

    trackChanges(event) {
        let { label, value } = event.target;
        this.info = { ...this.info, [label.toLowerCase()]: value };
        console.log(JSON.stringify(this.info));
    }

}
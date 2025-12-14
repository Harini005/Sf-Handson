import { LightningElement } from 'lwc';

export default class ParentCompositionDemo extends LightningElement {
    showChild = false;
    buttonHandler() {
        this.showChild = !this.showChild;
    }

    get buttonLabel() {
        return this.showChild ? 'Close Child' : 'Open Child';
    }
}
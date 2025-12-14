import { LightningElement } from 'lwc';

export default class ColorGenerator extends LightningElement {
    colorChanges = { 'Red': 0, 'Blue': 0, 'Green': 0 };
    handleSlider(event) {
        
        this.colorChanges[event.target.label] = event.target.value;
        const red = Number(this.colorChanges.Red);
        const green = Number(this.colorChanges.Green);
        const blue = Number(this.colorChanges.Blue);
        this.template.querySelector('.box').style.backgroundColor =
            "rgb(" + red + ", " + green + ", " + blue + ")";
        
    }

}
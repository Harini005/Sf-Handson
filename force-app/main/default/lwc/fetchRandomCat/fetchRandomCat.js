import { LightningElement } from 'lwc';

export default class FetchRandomCat extends LightningElement {
    endpoint = 'https://api.some-random-api.com/img/pikachu';
    image;
    connectedCallback() {
        this.fetchRandomImg();
    }


    refreshHandler() {
        this.fetchRandomImg();
    }

    async fetchRandomImg() {
        this.image = '';
        let response = await fetch(this.endpoint, { method: 'Get' })
        if (response.ok && response.status == 200) {
            let result = await response.json();
            this.image = result.link;
        }
    }
}
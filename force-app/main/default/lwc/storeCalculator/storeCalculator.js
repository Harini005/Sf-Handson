import { LightningElement } from 'lwc';

export default class StoreCalculator extends LightningElement {
    prodArr = [];
    value;
    total = 0;
    connectedCallback() {

        this.prodArr = [
            {
                'id': 1,
                'productName': '',
                'productPrice': '',
                'productavailable': ''
            }
        ]
    }

    captureDetails(event) {
        let { name, value } = event.target
        this.prodArr.forEach(item => {
            if (item.id == event.target.dataset.id) {
                item[name] = value;
            }
        })
    }

    addRows() {
        this.prodArr = [...this.prodArr, ...this.rowTemplate()];
    }

    rowTemplate() {
        return [
            {
                'id': this.prodArr.length + 1,
                'productName': '',
                'productPrice': '',
                'productavailable': ''
            }
        ]
    }

    buttonHandler() {

        console.log('Inside Button Handler');
        this.value = this.prodArr.reduce((acc, item) => {
          return  acc + Number(item['productavailable']) * Number(item['productPrice']) 
        }, 0);
    }

} 
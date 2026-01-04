import { LightningElement, wire } from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryChildWithParent extends LightningElement {
    records = [];
    val;

    @wire(graphql, {
        query: gql`
            query getData{
                uiapi{
                    query{
                        Contact{
                            edges{
                                node{
                                    Id
                                    Name{value}
                                    Account{
                                        Industry{value} 
                                    }
                                }
                            }
                        }
                    } 
                }
            }
        `
    })
    getRecords({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Contact.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get getContacts() {
        let dataArr = [];
        this.records.forEach(item => {
            dataArr = [...dataArr, { label: item.node.Name.value, value: item.node.Id }]
        });
        return dataArr;
    }

    get getOptions() {
        let dataArr = [];
        this.records.forEach(item => {
            dataArr = [...dataArr , {label : item.node.Account.Industry.value , value : item.node.Account.Industry.value}]
        })
        return dataArr;
    }

    getSelectedOption(event) {
        this.val = event.detail.value;
    }

    get getPointOfContacts() {
        let contacts = [];
        if (this.val) {
            this.records.forEach(item => {
                if (item.node.Account.Industry.value == this.val) {
                    contacts = [...contacts , {label : item.node.Name.value , value : item.node.Id}]
                }
            })
        }
        return contacts;
    }
}
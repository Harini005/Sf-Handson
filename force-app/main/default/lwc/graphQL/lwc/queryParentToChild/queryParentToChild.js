import { LightningElement, wire } from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryParentToChild extends LightningElement {
    records = [];
    contactData = [];
    val;
    vlaue;
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Title', fieldName: 'Title' },
        { label: 'Id', fieldName: 'Id' }
    ]
    @wire(graphql, {
        query: gql`
            query getRecords{
                uiapi{
                    query{
                        Account{
                            edges{
                                node{
                                    Id
                                    Name{value}
                                    Contacts{
                                        edges{
                                            node{
                                                Id
                                                Name{value}
                                                Title{value}
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        `
    })
    getData({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Account.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get getAccounts() {
        let arrData = [];
        this.records.forEach(item => {
            arrData = [...arrData, { label: item.node.Name.value, value: item.node.Id }];
        })
        return arrData;
    }

    getSelectedAccount(event) {
        this.val = event.detail.value;
        this.contactData = [];
    }

    get getContacts() {
        this.records.filter(item => item.node.Id == this.val).forEach(item => {
            console.log(item);
            console.log(item.node.Contacts.edges);
            this.contactData = [...this.contactData, item.node.Contacts.edges];
            this.contactData = this.contactData.flat();
            this.vlaue = JSON.stringify(this.contactData);
        })
        return this.contactData;
    }
}
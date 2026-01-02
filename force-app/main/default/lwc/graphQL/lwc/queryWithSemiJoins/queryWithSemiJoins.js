import { LightningElement, wire } from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryWithSemiJoins extends LightningElement {
    records = [];
    columns = [
        { label: "Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name" },
        { label: "Title", fieldName: "Title" },
        {label: "Account Name" , fieldName: "Account"}
    ]
    @wire(graphql, {
        query: gql`
            query getData{
                uiapi{
                    query{
                        Contact(where : {AccountId : {inq : {Account: {Industry:{ne : null}} , ApiName : "Id"}}}){
                           edges{
                                node{
                                    Id
                                    Name{value}
                                    Title{value}
                                    Account{
                                    Name{value}
                                    }
                                }
                            }
                        }
                    }
                }
            }
        `
    })

    getContactData({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Contact.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get contactData() {
        let contacts = this.records.map(item => {
            let contactObj = {
                "Id": item.node.Id,
                "Name": item.node.Name.value,
                "Title": item.node.Title.value,
                "Account" : item.node.Account.Name.value
            }
            return contactObj
        })
        return contacts;
    }
}
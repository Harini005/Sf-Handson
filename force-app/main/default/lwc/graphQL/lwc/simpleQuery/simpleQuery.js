import { LightningElement , wire} from 'lwc';
import { graphql, gql } from 'lightning/graphql';

export default class SimpleQuery extends LightningElement {
    records = [];
    @wire(graphql, {
        query: gql`
            query getAccounts{
                uiapi{
                    query{
                        Account{
                            edges{
                                node{
                                    Id
                                    Name{value}
                                    Industry{value}
                                }
                            }
                        }
                    } 
                }
            }
        `
    })
    getAccountData({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Account.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get recordData() {
        let accountData = this.records.map(item => {
            let accountDataObj = {'Id' : item.node.Id , "Name" : item.node.Name.value , "Industry" : item.node.Industry.value}
            return accountDataObj;
       })
        return accountData;
    }

    columns = [
        { label: 'Id', fieldName: "Id" },
        { label: 'Name', fieldName: "Name" },
        { label: 'Industry', fieldName: "Industry" }
    ];
}
import { LightningElement, wire } from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryWithParentCondition extends LightningElement {
    records = [];
    columns = [
        { label: "Contact Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name" },
        { label: "Account", fieldName: "Account" },
        {label : "Industry" , fieldName : "Industry"}
    ]
    @wire(graphql, {
        query: gql`
            query getRows{
                uiapi{
                    query{
                        Contact(where:{Account : {Industry : {ne: "Agriculture"}}}){
                            edges{
                                node{
                                    Id
                                    Name{value}
                                    Account{
                                        Name{value},
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
    getData({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Contact.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get getRowData() {
        let arrData = [];
        this.records.forEach(item => {
            let arrObj = {
                'Id': item.node.Id,
                'Name': item.node.Name.value,
                "Account": item.node.Account.Name.value,
                "Industry" : item.node.Account.Industry.value
            }
            arrData = [...arrData, arrObj];
        })
        return arrData;
    }
}
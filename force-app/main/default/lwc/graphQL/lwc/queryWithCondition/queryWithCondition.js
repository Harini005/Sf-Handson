import { LightningElement , wire} from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryWithCondition extends LightningElement {
    records = [];
    columns = [
        { label: "Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name" },
        { label: "Industry", fieldName: "Industry" },
        { label: "AnnualRevenue", fieldName: "AnnualRevenue" }
    ];
    @wire(graphql, {
        query: gql`
            query getAccoountData{
                uiapi{
                    query{
                        Account(where: {Industry: {ne : null}, AnnualRevenue : {ne : null}} , orderBy : {CreatedDate : {order : DESC}}){
                            edges{
                                node{
                                    Id
                                    Name{value}
                                    Industry{value, displayValue}
                                    AnnualRevenue{value, displayValue}
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
        if(errors) {
            console.error(errors);
        }
    }

    get accountData() {
        let accounts = this.records.map(item => {
            let accountObj = {
                "Id": item.node.Id,
                "Name": item.node.Name.value,
                "Industry": item.node.Industry.displayValue,
                "AnnualRevenue": item.node.AnnualRevenue.value
            }
            return accountObj;
        })
        return accounts;
    }
}
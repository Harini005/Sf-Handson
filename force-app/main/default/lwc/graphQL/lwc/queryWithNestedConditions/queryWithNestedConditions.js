import { LightningElement, wire } from 'lwc';
import { graphql, gql } from 'lightning/uiGraphQLApi';

export default class QueryWithNestedConditions extends LightningElement {
    records = [];
    val;

    // SELECT Id, Name
    // FROM Opportunity
    // WHERE(Probability = 100 AND StageName = 'Closed Won') OR(Type = 'New Customer' AND ExpectedRevenue > 1000000)
    @wire(graphql, {
        query: gql`
            query getRows{
                uiapi{
                    query{
                        Opportunity(where : {or : [
                        {
                            and : [
                                {Probability : {eq : 100}},
                                {StageName : {eq : "Closed Won"}}
                            ]
                        },
                        {
                            and: [
                              {
                                Type : {eq : "%Uni%"} 
                              }, 
                              {
                                ExpectedRevenue : {gt : 100000}
                              }
                            ]
                        }
                       ]}){
                            edges{
                                node{
                                    Id
                                    Name{value}
                                }
                            }
                        }
                    }
                }
            }
        `
    }) getRows({ data, errors }) {
        if (data) {
            this.records = data.uiapi.query.Opportunity.edges;
        }
        if (errors) {
            console.error(errors);
        }
    }

    get getData() {
        let recordsArr = [];
        this.records.forEach(item => {
            recordsArr = [...recordsArr, {value : item.node.Id , label : item.node.Name.value}]
        })
        return recordsArr;
    }

    selectedValue(event) {
        this.val = event.detail.value;
    }

    get getSelectedValue() {
        return this.val;
    }
}


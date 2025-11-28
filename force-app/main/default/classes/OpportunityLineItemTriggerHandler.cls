public with sharing class OpportunityLineItemTriggerHandler{
    
    
   public static void updateAccount(Map<Id, OpportunityLineItem> newMap , Map<Id, OpportunityLineItem> oldMap){
        Boolean isUpdate = false;
    
        List<OpportunityLineItem> records = new List<OpportunityLineItem>();
        set<Id> oppIds = new set<Id>();
        
        if(trigger.isDelete){
            records.addAll(oldMap.values());
        }
        
        else {
            records.addAll(newMap.values());
        }
        
        if(Trigger.isUpdate){
            isUpdate = true;
        }
        
        for(OpportunityLineItem record : records){
            if(isUpdate && record.OpportunityId != oldMap.get(record.Id).OpportunityId){
                oppIds.add(record.OpportunityId);
                oppIds.add( oldMap.get(record.Id).OpportunityId);
                continue;
            }
            oppIds.add(record.OpportunityId);
        }
        
        if(oppIds.isEmpty()){
            return;
        }
        List<Account> accounts = new List<Account>();
        Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>([SELECT Id, AccountId from Opportunity Where Id IN :oppIds]);
        List<AggregateResult> results = [SELECT Count(Id) records, OpportunityId oppId from OpportunityLineItem Where OpportunityId IN :oppIds Group By OpportunityId]; 

        for(AggregateResult result : results){
            accounts.add(new Account(Id=opportunities.get((Id)result.get('oppId')).AccountId, No_Of_OLI__c = (Integer)result.get('records')));
        }

        update accounts;
    }
}
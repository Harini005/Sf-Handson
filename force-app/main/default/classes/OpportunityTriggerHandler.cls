public with sharing class OpportunityTriggerHandler {
    public Static final TriggerOperation AFTER_DELETE = TriggerOperation.AFTER_DELETE;
    public static void updateAccount(){
        TriggerOperation currentContext = Trigger.operationType;
        Map<Id,Opportunity> newMap = (Map<Id,Opportunity>) Trigger.newMap;
        Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
         List<Account> accounts = new List<Account>();
        Map<Id,Opportunity> currentMap = ((Trigger.operationType == AFTER_DELETE) ? oldMap : newMap);

        List<Id> accountIds = new List<Id>();
        for(Opportunity opp : currentMap.values()){
            if(String.isBlank(opp.AccountId)){
                return;
            }
            if(Trigger.operationType == AFTER_DELETE){
                accountIds.add(opp.AccountId);
                continue;
            }
            if(oldMap.get(opp.Id).StageName != opp.StageName){
                accountIds.add(opp.AccountId);
            }
        }
       
        Map<Id,Account> accountsToOpportunities = new Map<Id,Account>([SELECT Id,(Select Id from Opportunities), closed_Opportunities__c, Open_Opportunities__c FROM Account WHERE Id IN :AccountIds]);
        List<AggregateResult> results = [SELECT count(Id) countRecs, AccountId FROM Opportunity WHERE AccountId IN :accountIds AND (StageName='Closed Won' OR StageName='Closed Lost') GROUP BY AccountId];
        if(results.isEmpty()){
            for(Id accountId : accountsToOpportunities.keySet()){
                if( accountsToOpportunities.get(accountId).Opportunities.size() != accountsToOpportunities.get(accountId).Open_Opportunities__c){
                    accounts.add(new Account(Id=accountId , Open_Opportunities__c = accountsToOpportunities.get(accountId).Opportunities.size()  , Closed_Opportunities__c = 0));
                }
            }
        }

        for(AggregateResult result : results){
            Integer openOpportunities = accountsToOpportunities.get((Id)result.get('ACcountId')).Opportunities?.size();
            accounts.add(new Account(Id=(Id)result.get('ACcountId') , Closed_Opportunities__c = (Integer)result.get('countRecs'), Open_Opportunities__c	= openOpportunities-(Integer)result.get('countRecs')));
        }

        update accounts;
    }
}
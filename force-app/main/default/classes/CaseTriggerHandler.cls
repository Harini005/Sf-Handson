public with sharing class CaseTriggerHandler {

    public static final String NEW_CASE = 'New';
    public static final String WORKING = 'Working';
    public static final String ESCALATED = 'Escalated';

    public static void updateAccount(){
        
        List<Case> cases = (List<Case>) Trigger.new;
        List<Account> accounts = new List<Account>();
        for(Case record : cases){
            if(String.isNotBlank(record.AccountId)){
                accounts.add(new Account(Id=record.AccountId, Latest_Case_Number__c=record.CaseNumber));
            }
        }
        
        update accounts;
        
    }

    public static void updateCasesCountOnAccount(){
        Map<Id, Case> newMap = (Map<Id, Case>) Trigger.newMap;
        Map<Id, Case> oldMap = (Map<Id, Case>) Trigger.oldMap;

        List<Case> records = (oldMap == null) ? newMap.values() : oldMap.values();
        List<Id> accountIds = new List<Id>();
        List<Account> accounts = new List<Account>(); 

        for(Case record : records){
            accountIds.add(record.AccountId);
        }

        if(accountIds.isEmpty()){
            return;
        }

        List<AggregateResult> results = [SELECT count(Id) records , Status status, AccountId accId From Case Where AccountId IN :accountIds Group By AccountId, status];

        for(AggregateResult res : results){
            Account acc = new Account();
            acc.Id = (Id) res.get('accId');
            switch on (string)res.get('status'){
                when 'New'{
                    acc.New_Cases__c = (Integer) res.get('records');
                    return;
                }
                when 'Working'{
                    acc.New_Cases__c = (Integer) res.get('records');
                    return;
                }
                when 'Escalated'{
                    acc.New_Cases__c = (Integer) res.get('records');
                    return;
                }
            }
            accounts.add(acc);
        }

        update accounts;
    }
}
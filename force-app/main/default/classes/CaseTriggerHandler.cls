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
        Map<Id,Account> accounts = new  Map<Id,Account>();
        
        for(Case record : records){
            accountIds.add(record.AccountId);
        }
        
        if(accountIds.isEmpty()){
            return;
        }
        
        List<AggregateResult> results = [SELECT count(Id) records , Status status, AccountId accId From Case Where AccountId IN :accountIds Group By AccountId, status];
        
        for(AggregateResult res : results){
            Id accuontId= (Id) res.get('accId');
            Account acc;
            if(accounts.containsKey(accuontId)){
                acc = accounts.get(accuontId);
            }
            else{
                acc = new Account(Id=accuontId);
            }
            
            switch on (string)res.get('status'){
                when 'New'{
                    acc.New_Cases__c = (Integer) res.get('records');
                    
                }
                when 'Working'{
                    acc.Working_Cases__c = (Integer) res.get('records');
                    
                }
                when 'Escalated'{
                    acc.Escalated_Cases__c = (Integer) res.get('records');
                    
                }
            }
            accounts.put(acc.Id,acc);
            system.debug(accounts);
        }
        
        update accounts.values();
    }
    
    public static void activateAccountContact(){
        List<Case> cases = (List<Case>) Trigger.new;
        
        List<Sobject> relatedIds = new List<Sobject>();
        
        for(Case record :cases){
            if(record.Notify__c){
                if(String.isNotBlank(record.AccountId)){
                    relatedIds.add(new Account(Id=record.AccountId, Active__c = 'Yes'));
                }
                
                if(String.isNotBlank(record.ContactId)){
                    relatedIds.add(new Contact(Id=record.ContactId , Active__c=true));
                }
            }
        }
        
        update relatedIds;
    }
    
    public static void updateAccountRating(){
        Map<Id, case> newMap = (Map<Id, case>) Trigger.newMap;
        Map<Id, Case> oldMap =(Map<Id, Case>)Trigger.oldMap;
        Set<Id> accountIds = new Set<Id>();
        
        for(case record : newMap.values()){
            if(record.status == 'closed' && oldMap.get(record.Id).status != record.status){
                accountIds.add(record.AccountId);
            }
        }
        
        if(accountIds.isEmpty()){
            return;
        }
        
        List<AggregateResult> results = [SELECT AccountId accId, count(Id) recs From Case where status='closed' Group By AccountId];
        List<Account> accRecords = new List<Account>();
        
        for(AggregateResult result : results){
            accRecords.add(
                new Account(Id=(Id)result.get('accId'), Rating = getRating((Integer)result.get('recs')))
                
            );
        }

        update accRecords;
    }
    
    private static String getRating(Integer countOfClosedCases){
        return (countOfClosedCases < 2) ? 'cold' : (countOfClosedCases == 2 ?  'warm' : 'Hot');
    }
}
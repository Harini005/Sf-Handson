public with sharing class CaseTriggerHandler {
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
}
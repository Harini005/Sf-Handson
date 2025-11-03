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
}
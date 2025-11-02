public with sharing class AccountTriggerHandler {
    public static void PreventActiveAccount(){
        List<Account> accounts = (List<Account>) Trigger.old;
        for(Account acc : accounts){
            if( String.isBlank(acc.Active__c)|| acc.Active__c == 'Yes' ){
                acc.addError('OOPS!!! You\'re trying to delete an active account');
            }
        }
    }
    
    public static void preventContactDeletion(){
        List<Account> accounts = (List<Account>) Trigger.old;
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accounts];
        for(Contact cont : contacts){
            cont.AccountId=Null;
        }
        update contacts;
    }
}
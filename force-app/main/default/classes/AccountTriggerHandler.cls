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
    
    public static void createRelatedRecords(){
        System.Savepoint savepoint = Database.setSavepoint();
        
        List<Account> records = (List<Account>) Trigger.new;
        List<sobject> relatedRecords = new List<Sobject>();
        for(Account record : records){
            sobject contact = new Contact();
            contact.put('FirstName', record.Name);
            contact.put('LastName', 'Contact');
            contact.put('AccountId', record.Id);
            contact.put('Email', 'test@mail.com');
            
            sobject opportunity = new Opportunity();
            opportunity.put('Name', record.Name+' Opportunity');
            opportunity.put('StageName', 'Prospecting');
            opportunity.put('CloseDate', System.today().addMonths(1));
            opportunity.put('Amount', 1000);
            opportunity.put('AccountId', record.Id);
            
            relatedRecords.add(contact);
            relatedRecords.add(opportunity);
        }
        
        try{
            insert relatedRecords;
        }
        catch(Exception e){
            Database.rollback(savepoint);
        }
        
    }
}
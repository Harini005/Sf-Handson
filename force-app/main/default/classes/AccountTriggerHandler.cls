public with sharing class AccountTriggerHandler {
    public static final String CLOSED_LOST = 'Closed Lost';
    public static final String CLOSED_WON = 'Closed Won';
    public static final Boolean NOT_VALID = false;
    public static final String ADMIN = 'System Administrator';
    
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
    
    public static void setDescription(){
        Map<Id,Account> newMap = (Map<Id,Account>)Trigger.newMap;
        Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;
        
        for(Account acc : newMap.values()){
            if(acc.Phone != oldMap.get(acc.Id).Phone){
                acc.Description = String.format('Phone is Updated! Old Value : {0} & New Value : {1}', new List<String>{acc.Phone, oldMap.get(acc.Id).Phone});
                    }
                }
            }
            
            public static void syncContactPhone(){
                List<Contact> contacts = [select Id,Phone, Account.Phone From Contact Where AccountId IN :Trigger.new];
                for(Contact con : contacts){
                    if(con.Phone != con.Account.Phone){
                        con.phone = con.Account.Phone;
                    }
                }
                update contacts;
            }
            
            public static void updateOpportunities(){
                Map<Id,Account> newMap = (Map<Id, Account>) Trigger.newMap;
                Map<Id,Account> oldMap = (Map<Id, Account>) Trigger.oldMap;
                List<Id> accountIds = new List<Id>();
                for(Account acc : newMap.values()){
                    if(acc.Active__c == 'No' && oldMap.get(acc.Id).Active__C != newMap.get(acc.Id).Active__c){
                        accountIds.add(acc.Id);
                    }
                }
                
                if(accountIds.isEmpty()){
                    return;
                }
                
                List<Opportunity> opportunities = [SELECT Id, StageName From Opportunity Where AccountId IN :accountIds And StageName != :CLOSED_WON];
                
                for(Opportunity opp : opportunities){
                    opp.StageName = CLOSED_LOST;
                    opp.Closed_Lost_Reason__c = 'Account Deactivated';
                }
                
                update opportunities;
            }
            
            public static void preventAccountUpdates(){
                for(Account acc : (List<Account>) Trigger.new){
                    Date accoutCreatedDate = System.Today()-7;
                    if(acc.Do_Not_Update__c && acc.CreatedDate <= accoutCreatedDate){
                        acc.addError('OOPS! This account can\'t be updated');
                    }
                }
                
            }
            
            public static void preventAccountDeletion(){
                Profile currentUserProfile = [SELECT Id,Name FROM Profile Where Id = :UserInfo.getProfileId()];
                if(currentUserProfile.Name != ADMIN){
                    for(Account acc : (List<Account>) Trigger.old){
                        acc.addError('You are not authorized to delete the record. Contact your System Admin');
                    }
                }
            }
            
            public static void preventAccountDeletionWhenOppsReated(){
                List<Account> accounts = (List<Account>) Trigger.old;
                Map<Id,Account> accountsMap = new Map<Id,Account>([SELECT Id,(Select Id FROM Opportunities),(Select Id From Cases) FROM Account Where Id IN :accounts]);
                for(Account acc : accounts){
                    if(!accountsMap.get(acc.Id).Opportunities?.isEmpty()){
                        acc.addError('Account has Associated Deals');
                    }
                    
                    if(!accountsMap.get(acc.Id).cases?.isEmpty()){
                        acc.addError('Account has Associated Cases');
                    }
                }
            }
            
            public static void sendEmailToAdmin(){
                List<Account> accounts = (List<Account>) Trigger.new;
                List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
                for(Account acc : accounts){
                    Messaging.singleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setSubject('Account Created');
                    message.setHtmlBody('Account has been created!!!! Here are the details : <a href='+URL.getOrgDomainUrl()+'/'+acc.Id+'>'+acc.Id+'</a>');
                    message.setToAddresses(new List<String>{'harinigovindarajan005@gmail.com'});
                    messages.add(message);
                }
                
                List<Messaging.SendEmailResult> results = Messaging.sendEmail(messages);
                for(Messaging.sendEmailResult result : results){
                    if(result.isSuccess()){
                        System.debug('Email Sent Successfully');
                    }
                    if(!result.getErrors().isEmpty()){
                        System.debug('Errors occured');
                    }
                }
            }
            
            public static void preventUpdateFor1Hour(){
                List<Account> accounts = (List<Account>) Trigger.new;
                Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;
                for(Account record : accounts){
                    if(oldMap.get(record.Id).LastModifiedById == UserInfo.getUserId() && oldMap.get(record.Id).LastModifiedDate.addHours(1) >= System.now() && record.hour__c){
                        record.addError('Wait 1 HOur to update ');
                    }
                }
            }
        }
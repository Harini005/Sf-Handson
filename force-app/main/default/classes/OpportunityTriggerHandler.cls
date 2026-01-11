public with sharing class OpportunityTriggerHandler {
    public Static final TriggerOperation AFTER_DELETE = TriggerOperation.AFTER_DELETE;
    public Static final String CLOSED_LOST = 'Closed Lost';
    public Static final String ADMIN = 'System Administrator';
    
    public static void updateAccount(){
        TriggerOperation currentContext = Trigger.operationType;
        Map<Id,Opportunity> newMap = (Map<Id,Opportunity>) Trigger.newMap;
        Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
        List<Account> accounts = new List<Account>();
        Map<Id,Opportunity> currentMap = ((currentContext == AFTER_DELETE) ? oldMap : newMap);
        
        List<Id> accountIds = new List<Id>();
        for(Opportunity opp : currentMap.values()){
            if(String.isBlank(opp.AccountId)){
                return;
            }
            if(currentContext == AFTER_DELETE){
                accountIds.add(opp.AccountId);
                continue;
            }
            if(oldMap == null || (oldMap.get(opp.Id).StageName != opp.StageName)){
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
    
    public static void stageTracker(){
        Map<Id,Opportunity> newMap = (Map<Id,Opportunity>) Trigger.newMap;
        Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
        List<Task> tasks = new List<Task>();
        for(Opportunity opp : newMap.values()){
            if(opp.StageName != oldMap.get(opp.Id).StageName){
                tasks.add(new Task(Subject='Opportunity Stage Changed', WhatId=opp.Id, OwnerId=opp.OwnerId, ActivityDate = System.Today().addDays(3)));
            }
        }
        
        insert tasks;
    }
    
    public static void validateClosedLostReason(){
        Map<Id,Opportunity> oldMap = (Map<Id,Opportunity>) Trigger.oldMap;
        for(Opportunity opp : (List<Opportunity>) Trigger.new){
            if(oldMap.get(opp.Id).StageName != opp.StageName && opp.StageName == CLOSED_LOST && String.isBlank(opp.Closed_Lost_Reason__c)){
                opp.addError('Please Provide Closed Lost Reason');
            }
        }
    }
    
    public static void preventClosedDeal(){
        Profile currentUserProfile = [SELECT Id,Name From Profile Where Id = :UserInfo.getProfileId()];
        if(currentUserProfile.Name != ADMIN){
            for(Opportunity opp : (List<Opportunity>) Trigger.old){
                if(opp.IsClosed){
                    opp.addError('You are not authorized to delete the record. Contact your System Admin');
                }
            }
        }
    }
    
    public static void checkForContact(){
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp : (List<Opportunity>) Trigger.new){
            accountIds.add(opp.AccountId);
        }
        accountIds.remove(null);
        if(accountIds.isEmpty()){
            return;
        }
        
        List<Account> accounts = [SELECT Id, (Select Id From Contacts) From Account Where Id IN :accountIds];
        accountIds.clear();
        for(Account acc : accounts){
            if(acc.Contacts == null || acc.Contacts.isEmpty()){
                accountIds.add(acc.Id);
            }
        }
        
        for(Opportunity opp : (List<Opportunity>)Trigger.new){
            if(accountIds.contains(opp.AccountId)){
                opp.addError('Account doesn\'t associated with the contact');
            }
        }
    }
    
    public static void preventOppCreation(){
        List<Opportunity> opps = (List<Opportunity>) Trigger.new;
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : opps){
            accountIds.add(opp.AccountId);
        }
        
        accountIds.remove(null);
        
        if(accountIds.isEmpty()){
            return;
        }
        
        Map<Id,Account> accounts = new Map<Id,Account>([Select Id, (Select Id From Cases Where CreatedDate >= LAST_N_Days:10 AND isClosed=false) From Account Where Id IN :accountIds]);
        
        for(Opportunity opp : opps){
            if(accounts.containsKey(opp.AccountId) && !accounts.get(opp.AccountId).cases.isEmpty()){
                opp.addError('Can\'t create Opportunity!!!');
            }
        }
    }
    
    public static void updateValuesDealOnAccount(){
        Map<Id,Opportunity> newMap = (Map<Id, Opportunity>)Trigger.newMap;
        Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
        List<Opportunity> oppIds = new List<Opportunity>();
        List<Id> accountIds = new List<Id>();
        List<Account> accountsToUpdate = new List<Account>();
        
        TriggerOperation isDeleteOp = Trigger.operationType;
        if(isDeleteOp == AFTER_DELETE){
            oppIds.addAll(oldMap.values());
        }
        else{
            oppIds.addAll(newMap.values());
        }
        
        for(Opportunity opp : oppIds){
            accountIds.add(opp.AccountId);
        }
        List<Account> accounts = [SELECT Id, (Select Id, Name From  Opportunities Order By Amount Desc Limit 1) From Account Where Id IN :accountIds];
        
        for(Account acc : accounts){
            accountsToUpdate.add(new Account(
                Id= acc.Id ,
                Valued_Deal__c = acc.Opportunities[0].Id
                ));
        }

        update accountsToUpdate;
    }

      public static void validateCloseOpportunitiesOnAccount(){
                List<Opportunity> recordsList = (List<Opportunity>) Trigger.new;
                Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
                Set<Id> accountIds = new Set<Id>();
                
                for(Opportunity record : recordsList){
                    accountIds.add(record.AccountId);
                }
                
                if(accountIds.isEmpty()){
                    return;
                }
                
                Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Close_Opportunities__c from Account Where Id IN :accountIds]);
                
                for(Opportunity record : recordsList){
                    if(accounts.containsKey(record.AccountId) && accounts.get(record.AccountId).Close_Opportunities__c && record.Probability >= 70){
                        if(oldMap == null){
                            record.StageName = 'Closed Won';
                            return;
                        }
                        else if(record.StageName != oldMap.get(record.Id).StageName){
                            record.StageName = 'Closed Won';
                        }
                    }
                }
            }

    public static void updateRatingOnAccount(){
        Map<Id, Opportunity> newMap = (Map<Id, Opportunity>) Trigger.newMap;
        Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
        List<Opportunity> records = (newMap == null) ? oldMap.values() : newMap.values();
        List<Account> accounts = new List<Account>();
        List<AggregateResult> results = [SELECT AccountId accId, Sum(Amount) amount From Opportunity Where Id IN :records Group BY AccountId];

        for(AggregateResult result : results){
            Double amount = (Double)result.get('amount');
            String rating = (amount <= 5000) ? 'Cold' : ((amount >5000 && amount < 100000) ? 'Warm' : 'Hot');
            accounts.add(new Account(Id=(Id)result.get('accId'), Rating= rating));
        }

        update accounts;
    }

    public static void insertContactRoles(){
        Map<Id, Opportunity> newMap = (Map<Id, Opportunity>)Trigger.newMap;
        Map<Id, Opportunity> oldMap = (Map<Id, Opportunity>) Trigger.oldMap;
        Set<Id> accountIds = new Set<Id>();
        Set<Id> oppIds = new Set<Id>();

        for(Opportunity opp : newMap.values()){
            if(String.isNotBlank(opp.Type) && oldMap.get(opp.Id).Type != newMap.get(opp.Id).Type){
                accountIds.add(opp.AccountId);
                oppIds.add(opp.Id);
            }
        }

        accountIds.remove(null);

        if(accountIds.isEmpty()){
            return;
        }

        Map<Id,Account> accounts = new Map<Id, Account>([Select Id,Name, (Select Id From Contacts) From Account Where Id IN :accountIds]);
        List<OpportunityContactRole> contactRoles = new List<OpportunityContactRole>();
        for(Opportunity opp : newMap.values()){
            if(!accounts.containsKey(opp.AccountId)){
                return;
            }
            System.debug(accounts.get(opp.AccountId).Contacts.isEmpty());

            if(accounts.get(opp.AccountId).Contacts.isEmpty()){
                opp.addError('Please add a contact to proceed further');
                return;
            }

            OpportunityContactRole contactRole = new OpportunityContactRole();
            contactRole.OpportunityId = opp.Id;
            contactRole.ContactId = accounts.get(opp.AccountId).contacts[0]?.Id;
            contactRole.Role = 'Decision Maker';
            contactRole.isPrimary = true;

            contactRoles.add(contactRole);
        }

        if(contactRoles.isEmpty()){
            return;
        }

        insert contactRoles;
    }
}
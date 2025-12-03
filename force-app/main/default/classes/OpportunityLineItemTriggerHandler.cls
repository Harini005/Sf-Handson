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
        
        if(accounts.isEmpty()){
            return;
        }
        
        List<AggregateResult> results = [SELECT Count(Id) records, OpportunityId oppId from OpportunityLineItem Where OpportunityId IN :oppIds Group By OpportunityId];
        
        for(AggregateResult result : results){
            accounts.add(new Account(Id=opportunities.get((Id)result.get('oppId')).AccountId, No_Of_OLI__c = (Integer)result.get('records')));
        }
        
        update accounts;
    }
    
    public static void createAsset(){
        Map<Id, OpportunityLineItem> oppLineItems = (Map<Id, OpportunityLineItem>) Trigger.newMap;
        List<Asset> assets = new List<Asset>();
        
        Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>([SELECT Id, AccountId, Account.Name From Opportunity Where Id IN (SELECT OpportunityId From OpportunityLineItem Where Id IN :oppLineItems.values() AND Id!=Null)]);
        
        if(opportunities.isEmpty()){
            return;
        }
        
        for(OpportunityLineItem item : oppLineItems.values()){
            if(String.isBlank(Opportunities.get(item.OpportunityId).AccountId)){
                continue;
            }
            
            assets.add(new Asset(
                Name = opportunities.get(item.opportunityId).Account.Name+ ' Asset' ,
            AccountId =opportunities.get(item.opportunityId).AccountId ,
            Product2Id = item.product2Id
                ));
        }
        
        insert assets;
    }
    
    public static void validateProductFamily(){
        List<OpportunityLineItem> items = (List<OpportunityLineItem>)Trigger.new;
        Set<Id> oppIds = new Set<Id>();
        Set<Id> prodIds = new Set<Id>();
        for(OpportunityLineItem item : items){
            oppIds.add(item.OpportunityId);
            prodIds.add(item.Product2Id);
        }
        
        Map<Id, Opportunity> opps = new Map<Id, Opportunity>([SELECT Id, Product_Family__c From Opportunity Where Id In :oppIds]);
        Map<Id, Product2> prods = new Map<Id, Product2>([SELECT Id, Family From Product2 Where Id In :prodIds]);
        
        for(OpportunityLineItem item : items){
            if(opps.get(item.opportunityId).Product_Family__c != prods.get(item.product2Id).Family ){
                item.addError('MisMatch in Product Family on Deal and Product');
            }
        }
    }
    
    public static void updateHigherItemsOnAccount(){
        Map<Id, OpportunityLineItem> newMap = (Map<Id, OpportunityLineItem>) Trigger.newMap;
        Map<Id, OpportunityLineItem> oldMap = (Map<Id, OpportunityLineItem>) Trigger.oldMap;
        List<OpportunityLineItem> records = (newMap == null )? oldMap.values() : newMap.values();
        List<Account> accounts = new List<Account>();
         Map<Id,Opportunity> opportunities = new Map<Id, Opportunity>();
         String query;
        if(!Trigger.isDelete){
           opportunities.putAll( [Select Id, AccountId From Opportunity Where Id IN (Select OpportunityId From OpportunityLineItem Where Id IN :records And ListPrice >= 50000)]);
            query = 'Select Id, AccountId From Opportunity Where Id IN (Select OpportunityId From OpportunityLineItem Where Id IN :records And ListPrice >= 50000 )Group By OpportunityId';
          
        }
        else{
            opportunities.putAll([Select Id, AccountId From Opportunity Where Id IN (Select OpportunityId From OpportunityLineItem Where Id IN :records And ListPrice >= 50000)]);
            query = 'Select Id, AccountId From Opportunity Where Id IN (Select OpportunityId From OpportunityLineItem Where Id IN :records And ListPrice >= 50000) Group By OpportunityId';

        }

          if(opportunities.isEmpty()){
                return;
            }
        
        List<AggregateResult> results = [SELECT count(Id) con, OpportunityId oppId from OpportunityLineItem WHere OpportunityId IN :opportunities.keySet() AND ListPrice >=50000 Group By OpportunityId];
        
        for(AggregateResult result : results){
            if(String.isBlank(opportunities.get((Id)result.get('oppId')).AccountId)){
                continue;
            }
            accounts.add(new Account(Id=opportunities.get((Id)result.get('oppId')).AccountId , High_Value_Items__c = (Integer) result.get('con')));
        }
        
        if(accounts.isEmpty()){
            return;
        }
        
        update accounts;
        
    }
}
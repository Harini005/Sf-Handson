public with sharing class MarketPlaceTriggerHandler {
    public static final Triggeroperation DELETE_OPERATION = TriggerOperation.AFTER_DELETE;
    public static void updateAccount(){
        List<Market_Place__c> records = new List<Market_Place__c>();
        List<Id> assetIds = new List<Id>();
        if(Trigger.OperationType == DELETE_OPERATION){
            records.addAll((List<Market_Place__c>) Trigger.old);
        }
        else{
            records.addAll((List<Market_Place__c>) Trigger.new);
        }
        
        for(Market_Place__c record : records){
            if(record.Active__c){
                assetIds.add(record.Asset__c);
            }
        }
        
        List<Asset> assets = [SELECT Id,Name, Account.Active_Market_Place__c, AccountId From Asset Where Id IN :assetIds AND AccountId != null];
        Map<Id,Account> accounts = new Map<Id,Account>();
        
        for(Asset record : assets){
            if(!accounts.containsKey(record.AccountId)){
                accounts.put(record.AccountId , new Account(Id=record.AccountId));
            }
            String description = (String.isBlank(accounts.get(record.AccountId).Active_Market_Place__c) ? '' : accounts.get(record.AccountId).Active_Market_Place__c) + ' ' +record.Name;
            accounts.get(record.AccountId).Active_Market_Place__c = description;
        }
        
        update accounts.values();
        
        
    }
}
trigger MarketPlaceTrigger on Market_Place__c (after insert, after update, after delete, after undelete) {
    
    if(Trigger_Invocation__mdt.getInstance('MarketPlaceTrigger').Active__c){
        if(Trigger.isAfter){
            MarketPlaceTriggerHandler.updateAccount();
        }
    }
    
}
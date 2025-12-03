trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete, after undelete, before insert, before delete) {
    if(Trigger_Invocation__mdt.getInstance('OpportunityLineItem').Active__c){
        if(Trigger.isAfter){
            OpportunityLineItemTriggerHandler.updateAccount(Trigger.newMap, Trigger.oldMap);
            if(!Trigger.isDelete){
                OpportunityLineItemTriggerHandler.updateHigherItemsOnAccount();
            }
            
            if(Trigger.isInsert){
                OpportunityLineItemTriggerHandler.createAsset();
            }
        }
        
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                OpportunityLineItemTriggerHandler.validateProductFamily();
            }
            if(Trigger.isDelete){
                OpportunityLineItemTriggerHandler.updateHigherItemsOnAccount();
            }
        }
    }
}
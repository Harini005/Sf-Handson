trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete, after undelete) {
    if(Trigger_Invocation__mdt.getInstance('OpportunityLineItem').Active__c){
        if(Trigger.isAfter){
            OpportunityLineItemTriggerHandler.updateAccount(Trigger.newMap, Trigger.oldMap);
        }
    }
}
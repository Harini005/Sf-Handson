trigger OpportunityTrigger on Opportunity (after insert , after update, after delete, after undelete , before update) {
   
    if(Trigger_Invocation__mdt.getInstance('OpportunityTrigger').Active__c){
        if(Trigger.isAfter){
            OpportunityTriggerHandler.updateAccount();
            if(Trigger.isUpdate){
                OpportunityTriggerHandler.stageTracker();
            }
        }

        if(Trigger.isBefore){
            if(Trigger.isUpdate){
                OpportunityTriggerHandler.ValidateClosedLostReason();
            }
        }
    }
    
}
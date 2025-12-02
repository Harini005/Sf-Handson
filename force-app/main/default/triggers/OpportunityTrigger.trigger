trigger OpportunityTrigger on Opportunity (after insert , after update, after delete, after undelete , before update , before delete, before insert) {
   
    if(Trigger_Invocation__mdt.getInstance('OpportunityTrigger').Active__c){
        if(Trigger.isAfter){
            OpportunityTriggerHandler.updateAccount();
            OpportunityTriggerHandler.updateValuesDealOnAccount();
            if(Trigger.isUpdate){
                OpportunityTriggerHandler.stageTracker();
            }
        }

        if(Trigger.isBefore){
            if(Trigger.isUpdate){
                OpportunityTriggerHandler.validateClosedLostReason();
                OpportunityTriggerHandler.validateCloseOpportunitiesOnAccount();
            }

            if(Trigger.isDelete){
                OpportunityTriggerHandler.preventClosedDeal();
            }

            if(Trigger.isInsert){
                OpportunityTriggerHandler.checkForContact();
                OpportunityTriggerHandler.preventOppCreation();
                OpportunityTriggerHandler.validateCloseOpportunitiesOnAccount();
                
            }
        }
    }
    
}
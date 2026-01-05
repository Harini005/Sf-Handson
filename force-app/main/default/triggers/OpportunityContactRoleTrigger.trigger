trigger OpportunityContactRoleTrigger on OpportunityContactRole (before insert) {
    if(Trigger_Invocation__mdt.getInstance('OpportunityContactRole').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                OpportunityContactRoleTriggerHandler.preventDuplicates();
            }
        }
    }
}
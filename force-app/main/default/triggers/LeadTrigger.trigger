trigger LeadTrigger on Lead (before insert, before update, after update) {
    if(Trigger_Invocation__mdt.getInstance('LeadTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                LeadTriggerHandler.validateLead();
            }
        }

        if(Trigger.isAfter){
            if(Trigger.isUpdate){
                LeadTriggerHandler.createFollowUpTask();
            }
        }
    }
}
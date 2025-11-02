trigger LeadTrigger on Lead (before insert, before update) {
    if(Trigger_Invocation__mdt.getInstance('LeadTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                LeadTriggerHandler.validateLead();
            }
        }
    }
}
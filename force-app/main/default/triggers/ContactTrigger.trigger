trigger ContactTrigger on Contact (after insert, after update , before insert, before update) {
    if(Trigger_Invocation__mdt.getInstance('ContactTrigger').Active__C){
        ContactTriggerHandler.updateSalaryOnAccount();
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                ContactTriggerHandler.createAccount();
            }
        }
        
        if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                ContactTriggerHandler.validateContactFields();
            }
        }
    }
}
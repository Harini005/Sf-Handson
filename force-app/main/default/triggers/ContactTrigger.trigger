trigger ContactTrigger on Contact (after insert, after update , before insert, before update) {
    if(Trigger_Invocation__mdt.getInstance('ContactTrigger').Active__C){
        
        if(Trigger.isAfter){
            if(Trigger.isInsert || Trigger.isUpdate){
                ContactTriggerHandler.updateSalaryOnAccount();
            }
            
            if(Trigger.isInsert){
                ContactTriggerHandler.createAccount();
            }
        }
        
        if(Trigger.isBefore){
            if(Trigger.isInsert || Trigger.isUpdate){
                ContactTriggerHandler.validateContactFields();
                ContactTriggerHandler.setSalutation();
            }
        }
    }
}
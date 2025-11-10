trigger CaseTrigger on Case (after insert , before insert) {

    if(Trigger_Invocation__mdt.getInstance('CaseTrigger').Active__c){
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                CaseTriggerHandler.updateAccount();
            }
        }

        if(Trigger.isBefore){
            if(Trigger.isInsert){
                CaseTriggerHandler.activateAccountContact();
            }
        }
    }

}
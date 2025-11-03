trigger CaseTrigger on Case (after insert) {

    if(Trigger_Invocation__mdt.getInstance('CaseTrigger').Active__c){
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                CaseTriggerHandler.updateAccount();
            }
        }
    }

}
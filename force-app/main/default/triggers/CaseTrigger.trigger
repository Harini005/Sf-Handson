trigger CaseTrigger on Case (after insert, after update , after delete, after undelete) {

    if(Trigger_Invocation__mdt.getInstance('CaseTrigger').Active__c){
        if(Trigger.isAfter){
            CaseTriggerHandler.updateCasesCountOnAccount();
            if(Trigger.isInsert){
                CaseTriggerHandler.updateAccount();
            }
            
        }
    }

}
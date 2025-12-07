trigger CaseTrigger on Case (after insert, after update , after delete, after undelete,before insert) {


    if(Trigger_Invocation__mdt.getInstance('CaseTrigger').Active__c){
        if(Trigger.isAfter){
            CaseTriggerHandler.updateCasesCountOnAccount();
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
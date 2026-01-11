trigger UserTrigger on User (after update) {
    if(Trigger_Invocation__mdt.getInstance('UserTrigger').Active__c){
        if(Trigger.isAfter){
            if(Trigger.isUpdate){
                UserTrigggerHandler.assignOpenOppsToManager();
            }
        }
    }
}
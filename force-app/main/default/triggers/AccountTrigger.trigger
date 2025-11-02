trigger AccountTrigger on Account (before delete, after delete) {
    if(Trigger_Invocation__mdt.getInstance('AccountTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isDelete){
                AccountTriggerHandler.PreventActiveAccount();
                AccountTriggerHandler.preventContactDeletion();
            }
        }
    }
    
}
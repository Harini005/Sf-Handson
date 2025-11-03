trigger AccountTrigger on Account (before delete, after delete , after insert) {
    if(Trigger_Invocation__mdt.getInstance('AccountTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isDelete){
                AccountTriggerHandler.PreventActiveAccount();
                AccountTriggerHandler.preventContactDeletion();
            }
        }

        if(Trigger.isAfter){
            if(Trigger.isInsert){
                AccountTriggerHandler.createRelatedRecords();
            }
        }
    }
    
}
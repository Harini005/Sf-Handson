trigger AccountTrigger on Account (before delete, after delete , after insert, before update , after update) {
    if(Trigger_Invocation__mdt.getInstance('AccountTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isDelete){
                AccountTriggerHandler.PreventActiveAccount();
                AccountTriggerHandler.preventContactDeletion();
                AccountTriggerHandler.preventAccountDeletion();
            }
            
            if(Trigger.isUpdate){
                AccountTriggerHandler.setDescription();
                AccountTriggerHandler.preventAccountUpdates();
               
            }
        }
        
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                AccountTriggerHandler.createRelatedRecords();
                 AccountTriggerHandler.syncContactPhone();
            }

            if(Trigger.isUpdate){
                 AccountTriggerHandler.syncContactPhone();
                 AccountTriggerHandler.updateOpportunities();
            }
        }
    }
    
}
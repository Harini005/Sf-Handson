trigger AccountTrigger on Account (before delete, after delete , after insert, before update , after update) {
    if(Trigger_Invocation__mdt.getInstance('AccountTrigger').Active__c){
        if(Trigger.isBefore){
            if(Trigger.isDelete){
                AccountTriggerHandler.preventActiveAccount();
                AccountTriggerHandler.preventContactDeletion();
                AccountTriggerHandler.preventAccountDeletion();
                AccountTriggerHandler.preventAccountDeletionWhenOppsReated();
            }
            
            if(Trigger.isUpdate){
                AccountTriggerHandler.setDescription();
                AccountTriggerHandler.preventAccountUpdates();
                AccountTriggerHandler.preventUpdateFor1Hour();
               
            }
        }
        
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                AccountTriggerHandler.createRelatedRecords();
                AccountTriggerHandler.syncContactPhone();
                AccountTriggerHandler.sendEmailToAdmin();
            }

            if(Trigger.isUpdate){
                 AccountTriggerHandler.syncContactPhone();
                 AccountTriggerHandler.updateOpportunities();
                 AccountTriggerHandler.updateRelatedRecords();
            }
        }
    }
    
}
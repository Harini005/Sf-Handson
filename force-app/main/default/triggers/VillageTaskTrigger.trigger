trigger VillageTaskTrigger on CAMPX__Village_Task__c (before insert, before delete) {
    if(Trigger.isBefore){
        if(trigger.isInsert){
            VillageTaskTriggerHandler.setCharacters(Trigger.new);
        }

        if(Trigger.isDelete){
            VillageTaskTriggerHandler.validatePriority(Trigger.old);
        }
    }
}
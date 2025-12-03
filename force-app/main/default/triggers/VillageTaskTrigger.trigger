trigger VillageTaskTrigger on CAMPX__Village_Task__c (before insert) {
    if(Trigger.isBefore){
        if(trigger.isInsert){
            VillageTaskTriggerHandler.setCharacters(Trigger.new);
        }
    }
}
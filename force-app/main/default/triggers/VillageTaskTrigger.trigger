trigger VillageTaskTrigger on CAMPX__Village_Task__c (before insert, before delete, before update) {
    if(Trigger.isBefore){
        if(trigger.isInsert){
            VillageTaskTriggerHandler.setCharacters(Trigger.new);
            VillageTaskTriggerHandler.setDueDate(Trigger.new);
             VillageTaskTriggerHandler.ValidateAssigner(Trigger.new);
        }

        if(Trigger.isUpdate){
            VillageTaskTriggerHandler.ValidateAssigner(Trigger.new);
        }


        if(Trigger.isDelete){
            VillageTaskTriggerHandler.validatePriority(Trigger.old);
        }
    }
}
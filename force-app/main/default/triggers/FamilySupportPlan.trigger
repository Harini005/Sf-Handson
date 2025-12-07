trigger FamilySupportPlan on CAMPX__Family_Support_Plan__c (after insert, after update, before delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            FamilySupportPlanTriggerHandler.createVillageTask(Trigger.newMap);
        }

        if(Trigger.isUpdate){
            FamilySupportPlanTriggerHandler.updateVillageSupportPlan(Trigger.newMap , Trigger.oldMap);
        }
    }

    if(Trigger.isBefore){
        if(Trigger.isDelete){
            FamilySupportPlanTriggerHandler.beforeDelete(trigger.old);
        }
    }
}
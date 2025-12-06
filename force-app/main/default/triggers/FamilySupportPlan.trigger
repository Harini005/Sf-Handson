trigger FamilySupportPlan on CAMPX__Family_Support_Plan__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            FamilySupportPlanTriggerHandler.createVillageTask(Trigger.newMap);
        }

        if(Trigger.isUpdate){
            FamilySupportPlanTriggerHandler.updateVillageSupportPlan(Trigger.newMap , Trigger.oldMap);
        }
    }
}
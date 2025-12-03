trigger FamilySupportPlan on CAMPX__Family_Support_Plan__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            FamilySupportPlanTriggerHandler.createVillageTask(Trigger.newMap);
        }
    }
}
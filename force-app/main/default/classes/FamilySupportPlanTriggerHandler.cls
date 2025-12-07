public with sharing class FamilySupportPlanTriggerHandler {
    public static final String HEALTH_SAFETY = 'Health & Safety';
    public static final String HEALTH_SAFETY_CHECK = 'Health & Safety Check';
    public static final String HIGH = 'High';
    public static final String GREEN = 'Dr. Grace Evergreen';
    public static final String NOT_STARTED = 'Not Started';
    public static final Boolean BOOLEAN_TRUE = true;
    
    public static void createVillageTask(Map<Id, CAMPX__Family_Support_Plan__c> newMap){
        List<CAMPX__Village_Task__c> tasks = new List<CAMPX__Village_Task__c>();
        for(CAMPX__Family_Support_Plan__c record : newMap.values()){
            if(record.CAMPX__Priority__c  == HIGH && record.CAMPX__Focus_Area__c  == HEALTH_SAFETY){
                tasks.add(new CAMPX__Village_Task__c(
                    CAMPX__Assigned_Character__c  = GREEN,
                CAMPX__Status__c  = NOT_STARTED,
                CAMPX__Is_Baby_Safety_Critical__c = BOOLEAN_TRUE,
                CAMPX__Task_Type__c = HEALTH_SAFETY_CHECK,
                CAMPX__Support_Phase__c = record.CAMPX__Phase__c ,
                CAMPX__Family_Support_Plan__c = record.Id
                    ));
            }
        }
        
        if(tasks.isEmpty()){
            return;
        }
        
        insert tasks;
    }

    public static void updateVillageSupportPlan(Map<Id, CAMPX__Family_Support_Plan__c> newMap , Map<Id, CAMPX__Family_Support_Plan__c> oldMap){
        List<CAMPX__Village_Task__c> villageTasks = [Select CAMPX__Support_Phase__c,CAMPX__Family_Support_Plan__c From CAMPX__Village_Task__c where CAMPX__Family_Support_Plan__c IN :newMap.keySet()];
        List<CAMPX__Village_Task__c> tasksToUpdate = new List<CAMPX__Village_Task__c>();

        if(villageTasks.isEmpty()){
            return;
        }

        for(CAMPX__Village_Task__c villageTask : villageTasks){
            if(oldMap.get(villageTask.CAMPX__Family_Support_Plan__c).CAMPX__Phase__c != newMap.get(villageTask.CAMPX__Family_Support_Plan__c).CAMPX__Phase__c){
                tasksToUpdate.add(new CAMPX__Village_Task__c(Id=villageTask.Id , CAMPX__Support_Phase__c= newMap.get(villageTask.CAMPX__Family_Support_Plan__c).CAMPX__Phase__c));
            }
        }

        update tasksToUpdate;

       
    }

    public static void beforeDelete(List<CAMPX__Family_Support_Plan__c> records){
        Map<Id, CAMPX__Family_Support_Plan__c> recordMap = new Map<Id, CAMPX__Family_Support_Plan__c>([Select Id, (select Id from CAMPX__Village_Tasks__r ) from CAMPX__Family_Support_Plan__c where CAMPX__Priority__c = :HIGH AND ID IN :records]);
        
        if(recordMap.isEmpty()){
            return;
        }

        for(CAMPX__Family_Support_Plan__c record : records){
            if(recordMap.containsKey(record.Id) && !recordMap.get(record.Id).CAMPX__Village_Tasks__r.isEmpty()){
                record.addError('Cannot delete a high-priority plan that has related tasks. Please remove all tasks first.');
            }
        }
    }
}
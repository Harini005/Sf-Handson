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
}
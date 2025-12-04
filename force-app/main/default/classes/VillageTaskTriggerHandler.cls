public with sharing class VillageTaskTriggerHandler {
    public static final Map<String, String> taskToCharacters = new Map<String, String>{
        'Cook / Deliver Meal' => 'Ginger Claus',
        'Build / Fix' => 'Stella Pinewood',
        'Health & Safety Check' => 'Dr. Grace Evergreen',
        'Decorate' => 'Poppy Wintergold',
        'Garden / Outdoor' => 'Ivy Evergreen'
    }   ;
    
    public static final String COMPLETED = 'Completed';
    
    public static void setCharacters(List<CAMPX__Village_Task__c> records){
        for(CAMPX__Village_Task__c record : records){
            if(String.isNotBlank(record.CAMPX__Task_Type__c) && String.isBlank(record.CAMPX__Assigned_Character__c ) && taskToCharacters.containsKey(record.CAMPX__Task_Type__c)){
                record.CAMPX__Assigned_Character__c = taskToCharacters.get(record.CAMPX__Task_Type__c);
            }
        }
    }
    
    public static void validatePriority(List<CAMPX__Village_Task__c> records){
        for(CAMPX__Village_Task__c record : records){
            if(record.CAMPX__Is_Baby_Safety_Critical__c && record.CAMPX__Status__c != COMPLETED){
                record.addError('Cannot delete safety-critical tasks that are not completed. Please complete the task first or contact your administrator.');
            }
        }
    }
}
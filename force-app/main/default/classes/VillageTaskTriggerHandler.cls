public with sharing class VillageTaskTriggerHandler {
    public static final Map<String, String> taskToCharacters = new Map<String, String>{
        'Cook / Deliver Meal' => 'Ginger Claus',
        'Build / Fix' => 'Stella Pinewood',
        'Health & Safety Check' => 'Dr. Grace Evergreen',
        'Decorate' => 'Poppy Wintergold',
        'Garden / Outdoor' => 'Ivy Evergreen'
    }   ;
    
    public static final String COMPLETED = 'Completed';
    public static final String BABY_BEFORE_ARRIVE = 'Before Baby Arrives';
    public static final Integer NUMBER_OF_DAYS = 14;
    
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

    public static void setDueDate(List<CAMPX__Village_Task__c> records){
        for(CAMPX__Village_Task__c record : records){
            if(record.CAMPX__Support_Phase__c == BABY_BEFORE_ARRIVE && record.CAMPX__Due_Date__c == null){
                record.CAMPX__Due_Date__c = System.today().addDays(NUMBER_OF_DAYS);
            }
        }
    }

    public static void ValidateAssigner(List<CAMPX__Village_Task__c> newRecords ){
        for(CAMPX__Village_Task__c record : newRecords){
            if(record.CAMPX__Status__c == COMPLETED && String.isBlank(record.CAMPX__Assigned_Character__c)){
                record.addError('Cannot complete a task without assigning it to a villager first.');
            }
        }
    }
}
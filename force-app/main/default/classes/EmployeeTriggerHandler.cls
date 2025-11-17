public with Sharing class EmployeeTriggerHandler{
    
    public static final TriggerOperation AFTER_DELETE = TriggerOperation.AFTER_DELETE;
    
    public static void updateTechFirm(){
        Map<Id, Employee__C> newMap = ( Map<Id, Employee__C>) Trigger.newMap;
        Map<Id, Employee__c> oldMap = (Map<Id, Employee__c>) Trigger.oldMap;
        
        Map<Id, Employee__C> employees = new Map<Id, Employee__c>();
        
        if(Trigger.operationType == AFTER_DELETE){
            employees.putAll(oldMap);
        }
        else{
            employees.putAll(newMap);
        }
        
        List<Id> techFirms = new List<Id>();
        
        for(Employee__c record : employees.values()){
            if(String.isBlank(record.Tech_Firm__C)){
                continue;
            }
            techFirms.add(record.Tech_Firm__C);
        }
        
        if(techFirms.isEmpty()){
            return;
        }
        
        List<AggregateResult> results = [SELECT Min(Salary__c) minSalary,Max(Salary__c) maxSalary, Tech_Firm__c techFirmId From Employee__c Where Tech_Firm__c In :techFirms Group BY Tech_Firm__c ];
        List<Tech_Firm__c> techFirmRecords = new List<Tech_Firm__c>();
        for(AggregateResult result : results){
            techFirmRecords.add(new Tech_Firm__C(Id=(Id) result.get('techFirmId'), Min_Salary__c = (Decimal) result.get('minSalary'), Max_Salary__c = (Decimal) result.get('maxSalary')));
        }
        
        update techFirmRecords;
    }
}
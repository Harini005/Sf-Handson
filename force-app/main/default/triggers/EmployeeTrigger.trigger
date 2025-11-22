trigger EmployeeTrigger on Employee__c (after insert,after update,after delete,after undelete) {

    if(Trigger.isAfter){
        EmployeeTriggerHandler.updateTechFirm();
    }
}
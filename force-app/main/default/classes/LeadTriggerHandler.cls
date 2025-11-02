public with sharing class LeadTriggerHandler {
    public static void validateLead(){
        List<Lead> leads = (List<Lead>) Trigger.new;
        Map<Id,Lead> newMap = (Map<Id,Lead>) Trigger.newMap;
        Map<Id,Lead> oldMap = (Map<Id,Lead>) Trigger.oldMap;
        set<String> emails = new set<String>();
        for(Lead record : leads){
            if(!String.isBlank(record.Email)){
                if(((newMap==null) || newMap.get(record.Id).Email != oldMap.get(record.Id).Email)){
                    emails.add(record.Email);
                }
            }
        }
        
        if(emails.isEmpty()){
            return;
        }
        
        List<Contact> contacts = [SELECT Id,Email FROM Contact WHERE Email= :emails];
        Set<String> emailToContacts = new Set<String>();
        for(contact cont : contacts){
            emailToContacts.add(cont.Email);
        }
        
        for(Lead record: Leads){
            if(emailToContacts.contains(record.Email)){
                record.addError('OOPS !!! Contact is already created with this Email');
            }
        }
    }
}
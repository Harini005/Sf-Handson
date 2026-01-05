public with sharing class OpportunityContactRoleTriggerHandler{
    
    public static void preventDuplicates(){
        List<OpportunityContactRole> records = (List<OpportunityContactRole>) Trigger.new;
        List<Id> opportunityIds = new List<Id>();
        
        for(OpportunityContactRole record : records){
          opportunityIds.add(record.OpportunityId);
        }

        if(opportunityIds.isEmpty()){
            return;
        }

        List<OpportunityContactRole> contactRoles = [Select Id,ContactId, OpportunityId From OpportunityContactRole Where OpportunityId IN :opportunityIds];
        Map<Id, List<Id>> oppToContacts = new Map<Id, List<Id>>();

        for(OpportunityContactRole record : contactRoles){
            if(!oppToContacts.containsKey(record.OpportunityId)){
                oppToContacts.put(record.opportunityId , new List<Id>());
            }
            oppToContacts.get(record.OpportunityId).add(record.ContactId);
        }

        Map<Id, Opportunity> oppos = new Map<Id, Opportunity>([Select Id, isClosed From Opportunity where Id IN :opportunityIds]);

        for(OpportunityContactRole record : records){
            if(oppToContacts.get(record.opportunityId).contains(record.ContactId)){
                record.addError('Duplicate Contact On the same Opportunity');
            }
            else if(oppos.get(record.OpportunityId).isClosed){
                record.addError('Can\'t insert a contact role on closed Opportunity');
            }
        }
    }
}
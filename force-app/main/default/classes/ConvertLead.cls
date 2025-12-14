public with sharing class ConvertLead {
    public static void doInvoke(){
        Map<Id, Lead> newMap= (Map<Id, Lead>) Trigger.newMap;
        Map<Id, Lead> oldMap = (Map<Id, Lead>) Trigger.oldMap;
        List<Lead> records = new List<Lead>();

        for(Lead record : newMap.values()){
            if(oldMap.get(record.Id).Convert__c != record.Convert__c && record.Convert__c){
                records.add(record);
            }
        }

        List<Database.LeadConvert> leadsToConvert = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [Select Id,ApiName From LeadStatus Where IsConverted =true LIMIT 1];

        for(Lead record : records){
            Database.LeadConvert lead = new Database.LeadConvert();
            lead.setLeadId(record.Id);
            lead.setConvertedStatus(convertStatus.ApiName);
            leadsToConvert.add(lead);
        }

        Database.LeadConvertResult[] results = Database.convertLead(leadsToConvert);
    }
}
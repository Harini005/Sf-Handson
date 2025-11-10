public with sharing class ContactController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContact(Id accountId){
        return [SELECT Id, Name From Contact Where AccountId=:accountId];
    }
}
public with sharing class URLClass {
    @AuraEnabled(Cacheable = true)
    public static String getRequestUrl(){
        return URL.getCurrentRequestUrl().toExternalForm();
    }
}
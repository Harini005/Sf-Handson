public with sharing class ContactTriggerHandler {
    private static final Decimal BASE_SALARY = 50000;
    public static void updateSalaryOnAccount(){
        Map<Id,Contact> newMap = (Map<Id,Contact>) Trigger.newMap;
        Map<Id,Contact> oldMap = (Map<Id,Contact>) Trigger.oldMap;
        List<Id> filteredIds = new List<Id>();
        List<Account> accounts = new List<Account>();
        for(Contact cont : newMap.values()){
            
            filteredIds.add(cont.AccountId);
            
        }
        
        if(filteredIds.isEmpty()){
            return;
        }
        
        List<AggregateResult> results = [SELECT Sum(Salary__c) salary, AccountId accountId From Contact Where AccountId In :filteredIds AND Salary__c >: BASE_SALARY Group By AccountId];
        
        for(AggregateResult res : results){
            accounts.add(new Account(Id=(String)res.get('accountId'), AnnualRevenue=(Double) res.get('salary')));
        }
        
        update accounts;
    }
}
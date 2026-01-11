public with sharing class UserTrigggerHandler {
    public static void assignOpenOppsToManager(){
        Map<Id,User> newMap = new Map<Id,User>([Select Id, ManagerId FRom User Where Id IN :(List<User>) Trigger.new AND IsActive = false]);
        
        List<Opportunity> opps = [Select Id, OwnerId From Opportunity Where OwnerId = :newMap.keySet() And isClosed = false ];
        
        for(Opportunity opp : opps){
            opp.OwnerId = String.isBlank(newMap.get(opp.OwnerId).ManagerId) ? '005NS00000IrDHhYAN' : newMap.get(opp.OwnerId).ManagerId;
        }
        
        update opps;
        
    }
}
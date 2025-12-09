public with sharing class DateDiffChecker {
   
   public static void main(String dueDate){
     Date todayDate = Date.valueOf(System.Today());
     Date dueDateNew = Date.valueOf(dueDate);
     Integer diff = todayDate.daysBetween(dueDateNew);
     System.debug(diff);
   }
   
}
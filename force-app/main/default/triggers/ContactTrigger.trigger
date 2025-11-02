trigger ContactTrigger on Contact (after insert, after update) {
    if(Trigger_Invocation__mdt.getInstance('ContactTrigger').Active__C){
        ContactTriggerHandler.updateSalaryOnAccount();
    }
}
// Check a checkbox only when an Opp is changed to Closed Won!
trigger generateServiceInvoices on Opportunity (after update) {
  for (Opportunity opp : Trigger.new) {
    // Access the "old" record by its ID in Trigger.oldMap
    Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

    // Create booleans to check the old & new status' are correct
    Boolean oldOppIsWon = oldOpp.StageName.equals('Scheduled');
      System.debug('Previously Scheduled = ' + oldOppIsWon);
    Boolean newOppIsWon = opp.StageName.equals('Completed');
      System.debug('Now Completed = ' + newOppIsWon);
    
    // Check that the field was changed to the correct value & update fields
    if (oldOppIsWon && newOppIsWon) {
		System.debug('New Course Invoice Generated.');
        Course_Invoice__c newInvoice = new Course_Invoice__c();
        newInvoice.Opportunity2__c=opp.id;
        newInvoice.Invoice_Status__c='Draft';
        DateTime yourDate = Datetime.now();
		String dateOutput = yourDate.format('dd/MM/yyyy');
        newInvoice.name='ServiceINV ' + Date.parse(dateOutput);
        
        insert newInvoice;
    }
  }
}
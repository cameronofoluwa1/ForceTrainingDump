trigger deleteCalEvent on Opportunity (after update) {
    
  for (Opportunity opp : Trigger.new) {
    // Access the "old" record by its ID in Trigger.oldMap
    Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

    // Create booleans to check the old & new status' are correct
    Boolean oldOppIsWon = oldOpp.StageName.equals('Scheduled');
      System.debug('Previously Scheduled = ' + oldOppIsWon);
    Boolean newOppIsCancelled = opp.StageName.equals('Cancelled');
      System.debug('Now Completed = ' + newOppIsCancelled);
    
    // Check that the field was changed to the correct value & update fields
    if (oldOppIsWon && newOppIsCancelled) {
		System.debug('Course changed to cancelled.');
        String email = [SELECT Email from User WHERE User.Id = :opp.Instructor__c LIMIT 1].Email;
        EmailManager em = new EmailManager();
        em.sendMail(email, 'Trailhead Tutorial', 'Course has been cancelled, calendar event removed from your calendar.');
    }
  }
}
                
//[SELECT Email from User WHERE User.Id = :opp.Instructor__c]
trigger addLondonExpenses on Course_Invoice__c (after insert) {
    
    List<Expense_Items__c> oliList = new List<Expense_Items__c>();
    Integer counter = 1;
    
    for(Course_Invoice__c invoice : [SELECT Id, RecordTypeId, Opportunity2__r.Course_Location__c FROM Course_Invoice__c Where Id IN: trigger.new]){
        if(invoice.Opportunity2__r.Course_Location__c == 'London' && invoice.RecordTypeId == '0124L000000bu76QAA'){
            while(counter <=5){
                Expense_Items__c oli = new Expense_Items__c(Course_Invoice__c=invoice.Id, Name='Mileage Expense Day ' + counter, Expense_Amount__c=25);
                oliList.add(oli);
                counter = counter + 1;
            }
        }else{
            System.debug('HAHAHA');
        }
    }
    
    insert oliList;

}
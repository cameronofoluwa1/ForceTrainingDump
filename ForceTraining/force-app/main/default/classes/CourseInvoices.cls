public class CourseInvoices {
    public Course_Invoice__c cinv {get;set;}
    
    public CourseInvoices(){
        cinv = new Course_Invoice__c();
    }
}
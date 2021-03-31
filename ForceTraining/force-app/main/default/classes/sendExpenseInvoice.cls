public class sendExpenseInvoice {
    public class FlowInputs {
        @InvocableVariable public ID accountId;
    }
  @InvocableMethod(label='Send Expense Invoice' description='')
    public static void testtest123(List<FlowInputs> request){
        ID accountId = request[0].accountId;
        ExpensesInvoicePDFEmailer con = new ExpensesInvoicePDFEmailer();
        con.accountId = accountId;
        con.email = 'cameronofoluwa@gmail.com';
        con.sendPdf();
  }
}
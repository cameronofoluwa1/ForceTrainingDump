public class sendServIncoice {
    public class FlowInputs {
        @InvocableVariable public ID accountId;
    }
  @InvocableMethod(label='Send Service Invoice' description='')
    public static void testtest123(List<FlowInputs> request){
        ID accountId = request[0].accountId;
        ServiceInvoicePDFEmailer con = new ServiceInvoicePDFEmailer();
        con.accountId = accountId;
        con.email = 'cameronofoluwa@gmail.com';
        con.sendPdf();
  }
}
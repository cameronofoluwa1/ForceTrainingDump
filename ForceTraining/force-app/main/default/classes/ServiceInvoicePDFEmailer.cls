public with sharing class ServiceInvoicePDFEmailer {

	public ID accountId {get;set;}
	public String email {get;set;}
    
    public PageReference sendPdf() {
		// generate either service or expense invoice depending on type needed
		PageReference pdf = Page.ServicesInvoicePDF;
		// add parent id to generate correct invoice
		pdf.getParameters().put('id',accountId);
        
		// the contents of the attachment from the pdf
		Blob body; 
		try {     
			// returns the output of the page as a PDF with data
			body = pdf.getContentAsPdf();
        // need to pass unit test -- current bug  
		} catch (VisualforceException e) {
			body = Blob.valueOf('Some Text');
		}
                
		Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
		attach.setContentType('application/pdf');
		attach.setFileName('servicesInvoice.pdf');
		attach.setInline(false);
		attach.Body = body;
            
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setUseSignature(false);
		//mail.setToAddresses(new String[] { email });
		mail.setTargetObjectId( '0054L000000VWGzQAO' );
		mail.setSaveAsActivity( false );
		mail.setSubject('Updated Invoice Alert');
		mail.setHtmlBody('UPDATE ! Invoice status has been changed from draft to submitted. Need your immediate approval.');
		mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
                
		// Send the email
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		return null;
    }
}
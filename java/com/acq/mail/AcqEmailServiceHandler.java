package com.acq.mail;

import java.util.HashMap;

public interface AcqEmailServiceHandler {
	public void sendEmail(final HashMap<String,Object> model, final String templateLocation, String toEmail);
	public void sendEmailHtmlBody(String date,String filename,final HashMap<String,Object> model, final String templateLocation,byte[] byteArray, String toEmail);
	public void sendEmailWithAttachment(String orgEmail,String filePath,String htmlTemplate,HashMap<String,Object> model);
	public void sendEmailWithCC(final HashMap<String,Object> model, final String templateLocation,String ccMail, String toEmail);
		
}

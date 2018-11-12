package com.acq.web.controller;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.acq.web.controller.model.AcqDownloadPdfModel;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

public class PDFView extends AbstractPdfView {
	protected void buildPdfDocument(Map model,
			final Document document, PdfWriter writer, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		AcqDownloadPdfModel mod = (AcqDownloadPdfModel)model.get("command");
		try{
			Paragraph header = new Paragraph(new Chunk(" Acquiro Documents",FontFactory.getFont(FontFactory.HELVETICA, 30)));
			document.add(header);
			final String path=mod.getParam();
			File dir = new File(path);
			File[] matches = dir.listFiles(new FilenameFilter() {
		
		@Override
		public boolean accept(File dir, String name) {
			try {
				Image image1 = Image.getInstance(path+File.separator+name);
				image1.scaleAbsoluteWidth(750);
				image1.scaleAbsoluteHeight(850);
				image1.setAlignment(Image.MIDDLE);
				document.add(image1);
			} catch (BadElementException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
		}
	});	   
	   
	   System.out.println("pdf generated");
    }catch(Exception fe){
	   Paragraph by = new Paragraph(new Chunk("Message :" +" Document not found" ,FontFactory.getFont(FontFactory.HELVETICA, 20)));
	   document.add(by);
	   System.out.println("Error in generate pdf");
   }
 }

}
package com.acq;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.springframework.web.multipart.MultipartFile;

import sun.misc.BASE64Decoder;

public class AcqImageFunctions 
{
	
	private static final int IMG_WIDTH = 1240;
	private static final int IMG_HEIGHT = 1754;
	
	public static BufferedImage generateImage(BufferedImage originalImage, int type){
		BufferedImage scaledImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = scaledImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
			
		return scaledImage;
	    }


	public static boolean decode64AndSave(String base64Image,String location){
		BASE64Decoder decoder= new BASE64Decoder();
		FileOutputStream out=null ;
		try{
		byte[] image = decoder.decodeBuffer(base64Image);
		File imageFile = new File(location);		
		if(imageFile.exists())
			imageFile.delete();
		imageFile.createNewFile();
		out= new FileOutputStream(imageFile);
		out.write(image);
		out.close();
		return true;
		}catch(IOException ioException){
			return false;			
		}		
	}
	
	public static boolean save(MultipartFile usrImage,String location)
	{	
		try
		{
			byte[] image = usrImage.getBytes();
			ByteArrayInputStream bais = new ByteArrayInputStream(image);			
			BufferedImage originalImage = ImageIO.read(bais);			
			int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();			
			BufferedImage resizeImageJpg = generateImage(originalImage, type);
			ImageIO.write(resizeImageJpg, "jpeg", new File(location));			
			return true;
		}
		catch(IOException ioException)
		{
			System.out.println("error to save item image "+ioException);
			return false;			
		}
	}

	public static boolean savePdf(MultipartFile file, String location) {
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			File outputfile = new File(location);
			InputStream inputStream = file.getInputStream();
			FileOutputStream output = null;
			if (!outputfile.isDirectory()) {
			try {
			  output = new FileOutputStream(outputfile);
			  IOUtils.copy(inputStream, output);
			} catch (Exception e) {
			   e.printStackTrace();
			} finally {
			   baos.close();
			   output.close();
			}
			}
			System.out.println("file saved");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
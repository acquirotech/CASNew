package com.acq;

import java.security.MessageDigest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AcqBase {
	static ApplicationContext applicationContext;
	public static ApplicationContext getAppContext(){
		applicationContext = new ClassPathXmlApplicationContext("spring-database.xml"); 
		//appContext = new ClassPathXmlApplicationContext("file:WEB-INF/spring-database.xml");
		return applicationContext;
	}
	
	
	public static String generateSHA(String ClearText)
	{
		try
		{
			StringBuffer encryptStringBuffer;
			MessageDigest encryptionScheme = MessageDigest.getInstance("SHA-256");
			encryptionScheme.update(ClearText.getBytes());
			byte byteData[] = encryptionScheme.digest();
			encryptStringBuffer = new StringBuffer();
			for (int i = 0; i < byteData.length; i++)
			{
				encryptStringBuffer.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			return encryptStringBuffer.toString();
		}
		catch (Exception e)
		{
			return null;
		}
	}
}

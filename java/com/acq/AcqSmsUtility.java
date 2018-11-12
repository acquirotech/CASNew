package com.acq;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import org.apache.log4j.Logger;
public class AcqSmsUtility
{
	private static Logger logger = Logger.getLogger(AcqSmsUtility.class);
	
	String Username,Password,Message,Type,dlr,Destination,Source,Server;
	int Port;
	
	public AcqSmsUtility(String Server, String Username, String Password,
		String Message, String dlr, String Type, String Destination,
		String Source)
	{
		this.Username = Username;
		this.Password = Password;
		this.Message = Message;
		this.dlr = dlr;
		this.Type = Type;
		this.Destination = Destination;
		this.Source = Source;
		this.Server = Server;
		//this.port = port;
	}
	private void submitMessage()
	{
		try
		{
			URL sendUrl = new URL("http://" + "google.com");
			HttpURLConnection httpConnection = (HttpURLConnection) sendUrl.openConnection();
			httpConnection.setConnectTimeout(9000);
			httpConnection.setReadTimeout(9000);
			httpConnection.setRequestMethod("POST");
			httpConnection.setDoInput(true);
			httpConnection.setDoOutput(true);
			httpConnection.setUseCaches(false);
			DataOutputStream dataStreamToServer = new DataOutputStream(httpConnection.getOutputStream());
			dataStreamToServer.writeBytes("username=" +
				URLEncoder.encode(this.Username, "UTF-8") + "&password=" +
				URLEncoder.encode(this.Password, "UTF-8") + "&type=" +
				URLEncoder.encode(this.Type, "UTF-8") + "&dlr=" +
				URLEncoder.encode(this.dlr, "UTF-8") + "&destination=" +
				URLEncoder.encode(this.Destination, "UTF-8") + "&source=" +
				URLEncoder.encode(this.Source, "UTF-8") + "&message=" +
				URLEncoder.encode(this.Message, "UTF-8"));
			dataStreamToServer.flush();
			dataStreamToServer.close();
			dataStreamToServer.flush();
			dataStreamToServer.close();
			BufferedReader dataStreamFromUrl = new BufferedReader(
				new InputStreamReader(httpConnection.getInputStream()));
			
			String dataFromUrl = ""; 
			String dataBuffer = "";
			while ((dataBuffer = dataStreamFromUrl.readLine()) != null)
			{
				dataFromUrl += dataBuffer;
			}
			dataStreamFromUrl.close();
			
			System.out.println("Response: " + dataFromUrl);
		}
		catch (SocketTimeoutException e)
		{
			logger.info("Error to send SMS,SMS Server is down");
		}
		catch (Exception ex)
		{
			logger.info("Error to send sms, in AcqSmsUtility");
			ex.printStackTrace();
		}
	}
	
	public static void sendSMS(String message, String mobileNo)
	{
		AcqSmsUtility newMessage = new AcqSmsUtility("sms6.routesrgrms.com", "Acquiro",
			"acquiro", message,"1", "0", mobileNo, "Acquiro");
		newMessage.submitMessage();
	}
}
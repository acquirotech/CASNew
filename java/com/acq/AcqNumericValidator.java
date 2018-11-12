package com.acq;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class AcqNumericValidator
{
	private static Pattern pattern;
	private static Matcher matcher;
	private static final String NumericPattern = "^[0-9]{1,20}$";
	private static final String mobilePattern = "^[0-9]{10}$";
	private static final String multiPhonePattern = "^(\\d{10}(,\\d{10})*)?$";
	private static final String receiptNoPattern = "^[0-9\\-]{1,30}$";
	private static final String datePattern = "^[0-9\\/)]{10,10}$";
	private static final String daysPattern = "^(1)$|(7)$|(30)$|(90)$|(365)$";
	
	public static boolean checkMobileNum(String mobileNo)
	{
		if (mobileNo == "" || mobileNo == null || mobileNo.equals(""))
		{
			return true;
		}
		pattern = Pattern.compile(mobilePattern);
		matcher = pattern.matcher(mobileNo);
		return matcher.matches();
	}
	
	
	public static boolean checkReceiptNo(String receiptNo)
	{
		if (receiptNo == "" || receiptNo == null)
		{
			return false;
		}
		pattern = Pattern.compile(receiptNoPattern);
		matcher = pattern.matcher(receiptNo);
		return matcher.matches();
	}
	
	
	public static boolean checkId(final String id)
	{
		if (id == "" || id == null)
		{
			return false;
		}
		pattern = Pattern.compile(NumericPattern);
		matcher = pattern.matcher(id);
		return matcher.matches();
	}
	
	
	public static boolean checkPhoneNo(final String phoneNo)
	{
		if (phoneNo == "" || phoneNo == null)
		{
			return false;
		}
		pattern = Pattern.compile(mobilePattern);
		matcher = pattern.matcher(phoneNo);
		return matcher.matches();
	}
	
	
	
	public static boolean checkDays(String days)
	{
		if (days == "" || days == null)
		{
			return false;
		}
		pattern = Pattern.compile(daysPattern);
		matcher = pattern.matcher(days);
		return matcher.matches();
	}
	
	
	public static boolean checkDate(final String date)
	{
		if (date == "" || date == null || date.length() != 10)
		{
			return false;
		}
		pattern = Pattern.compile(datePattern);
		matcher = pattern.matcher(date);
		return matcher.matches();
	}
	
	
	public static boolean checkMultiPhone(String phoneString)
	{
		if (phoneString == "" || phoneString == null)
		{
			return false;
		}
		pattern = Pattern.compile(multiPhonePattern);
		matcher = pattern.matcher(phoneString);
		return matcher.matches();
	}
}
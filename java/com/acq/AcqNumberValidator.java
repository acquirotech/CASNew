package com.acq;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class AcqNumberValidator
{
	private static Pattern pattern;
	private static Matcher matcher;
	private static final String NumberPattern = "^[0-9]{1,20}$";
	private static final String phonePattern = "^[0-9]{10}$";
	private static final String receiptNoPattern = "^[0-9\\-]{1,30}$";
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	public static boolean checkMobileNum(String mobileNo)
	{
		if (mobileNo == "" || mobileNo == null || mobileNo.equals(""))
		{
			return true;
		}
		pattern = Pattern.compile(phonePattern);
		matcher = pattern.matcher(mobileNo);
		return matcher.matches();
	}
	public static boolean checkReceiptNum(String receiptNo)
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
		pattern = Pattern.compile(NumberPattern);
		matcher = pattern.matcher(id);
		return matcher.matches();
	}
	public static boolean checkPhoneNo(final String phoneNo)
	{
		if (phoneNo == "" || phoneNo == null)
		{
			return false;
		}
		pattern = Pattern.compile(phonePattern);
		matcher = pattern.matcher(phoneNo);
		return matcher.matches();
	}
	private static final String daysPattern = "^(1)$|(7)$|(30)$|(90)$|(365)$";
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
	private static final String multiPhonePattern = "^(\\d{10}(,\\d{10})*)?$";
	public static boolean checkMultiPhone(String phoneNo)
	{
		if (phoneNo == "" || phoneNo == null)
		{
			return false;
		}
		pattern = Pattern.compile(multiPhonePattern);
		matcher = pattern.matcher(phoneNo);
		return matcher.matches();
	}
	public static boolean validateEmail(final String hex)
	{
		pattern = Pattern.compile(EMAIL_PATTERN);
		if (hex == null || hex == "" || hex.equals(""))
		{
			return false;
		}
		matcher = pattern.matcher(hex);
		return matcher.matches();
	}
}
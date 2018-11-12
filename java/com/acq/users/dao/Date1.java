package com.acq.users.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Date1 {

	public static void main(String[] args)
	{
		try {
		String fromDate1= "09/25/2015";
		String toDate1= "09/25/2015";
		System.out.println("from date:"+fromDate1);
		System.out.println("to date:"+toDate1);
		SimpleDateFormat sdfDestination1 = new SimpleDateFormat("MM/dd/yyyy");
	    Date fdate1;
		
			fdate1 = sdfDestination1.parse(fromDate1);
		
	    Date tdate1;
		
			tdate1 = sdfDestination1.parse(toDate1);
		    
	    SimpleDateFormat sdfSource1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String newFromDate2 = sdfSource1.format(fdate1);
	    String newToDate1 = sdfSource1.format(tdate1);		
	    System.out.println("from date:"+newFromDate2);
		System.out.println("to date:"+newToDate1);
	}
	catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
}

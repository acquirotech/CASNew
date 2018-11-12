package com.acq.users.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.acq.mail.AcqEmailServiceHandler;
import com.acq.users.model.Users;

@Component
public class UserDaoImpl implements UserDao{

	private SessionFactory sessionFactory;

	@Autowired
	AcqEmailServiceHandler AcqEmailServiceHandler;
	

	@SuppressWarnings("unchecked")
	public Users findByUserName(String username) {
		List<Users> users = new ArrayList<Users>();
		try{
			//System.out.println("username is: "+username);
		users = getSessionFactory().getCurrentSession().createQuery("from Users where username=?")
				.setParameter(0, username).list();
		if(users.size()<=0){
			return null;
		}
		Iterator<Users> itr = users.iterator();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String endDate = df.format(new Date());
		String startDate = null;
		String empName = null;
		while(itr.hasNext()){
			Users usr = (Users)itr.next();
			startDate = usr.getLastUpdatedOn();
			empName = usr.getEmpName();
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = null;
		Date d2 = null;
		try{
			d1 = format.parse(startDate);
			d2 = format.parse(endDate);
			long diff = d2.getTime() - d1.getTime();
			long diffDays = diff / (24 * 60 * 60 * 1000);
			if(diffDays>90){
				return null;
			}
		} catch (Exception e) {
			System.out.println("error in calculate date "+e);
		}
			if (users.size() > 0) {
				return users.get(0);
			} else {
				return null;
			}
		}catch(Exception e){
			System.out.println("exception "+e);
			return null;
		}
	}
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	
}
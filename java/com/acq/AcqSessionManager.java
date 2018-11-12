package com.acq;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

public class AcqSessionManager
{
	private static final SessionFactory sessionManager = createSessionManager();
	private static ServiceRegistry serviceRegistry;

	private static SessionFactory createSessionManager()
	{
		try
		{
			Configuration configuration = new Configuration();
			configuration.configure();
			serviceRegistry = new StandardServiceRegistryBuilder().applySettings(
				configuration.getProperties()).build();
			return configuration.buildSessionFactory(serviceRegistry);
		}
		catch (Throwable ex)
		{
			System.err.println("Session Manager Creation Failure." + ex);
			throw new ExceptionInInitializerError(ex);
		}
	}
	public static SessionFactory getSessionManager()
	{
		return sessionManager;
	}
	public static void shutdown()
	{
		getSessionManager().close();
	}

}
package com.acq;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

public class AcqAuthToken
{
	public static Authentication getAuthToken()
	{
		return SecurityContextHolder.getContext().getAuthentication();
	}
}
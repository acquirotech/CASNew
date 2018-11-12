package com.acq.users.dao;

import com.acq.users.model.Users;

public interface UserDao {

	Users findByUserName(String username);
}
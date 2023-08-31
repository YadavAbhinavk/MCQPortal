package project.mcq.portal.dao;

import project.mcq.portal.entities.User;

public interface UserDao {
	int insertUser(User user);
	public User getUser(String mobileNo,String password);
}

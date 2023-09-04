package project.mcq.portal.dao;

import project.mcq.portal.entities.Users;

public interface UserDao {
	int insertUser(Users user);
	public Users getUser(String mobileNo,String password);
}

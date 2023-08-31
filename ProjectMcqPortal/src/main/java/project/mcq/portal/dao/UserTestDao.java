package project.mcq.portal.dao;

import java.util.List;

import project.mcq.portal.entities.UserTest;

public interface UserTestDao {
	int insertUser(UserTest userTest);
	List<UserTest> getAllUserTest(int userId);
}

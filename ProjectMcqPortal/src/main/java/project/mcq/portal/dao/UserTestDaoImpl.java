package project.mcq.portal.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import project.mcq.portal.entities.Admin;
import project.mcq.portal.entities.Question;
import project.mcq.portal.entities.Test;
import project.mcq.portal.entities.UserTest;
import project.mcq.portal.rowmappers.UserTestRowMapper;


public class UserTestDaoImpl implements UserTestDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	@Override
	public int insertUser(UserTest userTest) {
		String insertQuery = "INSERT INTO "
				+ "user_tests "
				+ "(user_id, tag, submission_time, score)"
				+ "VALUES (?,?,?,?)";

		return this.jdbcTemplate.update(
				insertQuery, userTest.getUserId(), userTest.getTag(), userTest.getSubmissionTime(), userTest.getScore());
	}

	@Override
	public List<UserTest> getAllUserTest(int userId) {
	
		
		
		String selectAllTests = "Select * from user_tests WHERE user_id = ?";
		return this.jdbcTemplate.query(selectAllTests, new UserTestRowMapper(),userId);

		
	}

}

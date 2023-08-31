package project.mcq.portal.rowmappers;

import org.springframework.jdbc.core.*;
import project.mcq.portal.entities.Test;

import java.sql.*;

public class TestRowMapperImpl implements RowMapper<Test> {
	public Test mapRow(ResultSet rs, int rowNum) throws SQLException {
		Test test = new Test();
		test.setTestId(rs.getInt("test_id"));
		test.setTag(rs.getString("tag"));
		test.setNumberOfQuestions(rs.getInt("no_of_questions"));
		test.setIsAvailable(rs.getString("is_available"));
		test.setNumberOfUsers(rs.getInt("num_of_users"));
		return test;
	}
}

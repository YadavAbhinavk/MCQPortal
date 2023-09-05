package project.mcq.portal.rowmappers;

import org.springframework.jdbc.core.*;
import project.mcq.portal.entities.Tests;

import java.sql.*;

public class TestRowMapperImpl implements RowMapper<Tests> {
	public Tests mapRow(ResultSet rs, int rowNum) throws SQLException {
		Tests test = new Tests();
		test.setTestId(rs.getInt("test_id"));
		test.setTag(rs.getString("tag"));
		test.setNumberOfQuestions(rs.getInt("no_of_questions"));
		test.setIsAvailable(rs.getString("is_available"));
		test.setNumberOfUsers(rs.getInt("num_of_users"));
		test.setQuestionsPerTest(rs.getInt("ques_per_test"));
		test.setTimePerQuestion(rs.getInt("time_for_each_question"));
		return test;
	}
}

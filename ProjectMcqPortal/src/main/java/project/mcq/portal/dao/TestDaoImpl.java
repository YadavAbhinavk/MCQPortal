package project.mcq.portal.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;


import project.mcq.portal.entities.Tests;
import project.mcq.portal.rowmappers.*;

public class TestDaoImpl implements TestDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertTest(Tests test) {
		String insertQuery = "INSERT INTO " + "tests " + "(tag, no_of_questions)" + "VALUES (?,?)";

		return this.jdbcTemplate.update(insertQuery, test.getTag(), test.getNumberOfQuestions());
	}

	@Override
	public int getTest(String tag) {
		String countQuery = "SELECT COUNT(*) FROM tests WHERE tag = ?";
		Integer count = jdbcTemplate.queryForObject(countQuery, Integer.class, tag);
		return count;
	}

	@Override
	public int updateTest(Tests test) {
		String updateQuery = "UPDATE tests " + "SET is_available =? WHERE tag = ?";
		Integer update = this.jdbcTemplate.update(updateQuery,test.getIsAvailable() ,test.getTag());
		return update;
	}
	
	@Override
	public int deleteTest(String tag)
	{
		String deleteQuery = "Delete from Tests where tag=?";
		int result = this.jdbcTemplate.update(deleteQuery, tag);
		return result;
	}
	@Override
	public List<Tests> getListOfTests()
	{
		String selectAllTests = "Select * from Tests";
		
		return this.jdbcTemplate.query(selectAllTests, new TestRowMapperImpl());	
	}
	@Override
	public String getAvailability(String tag)
	{
		String query = "Select is_available from tests where tag=?";
		String availablity = jdbcTemplate.queryForObject(query, String.class, tag);
		return availablity;
		
	}
}

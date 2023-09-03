package project.mcq.portal.dao;

import project.mcq.portal.entities.User;

import project.mcq.portal.rowmappers.UserRowMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class UserDaoImpl implements UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertUser(User user) {
		try {
			String insertQuery = "INSERT INTO " + "users " + "(mobile_no, name, password)" + "VALUES (?,?,?)";

			return this.jdbcTemplate.update(insertQuery, user.getMobileNo(), user.getName(), user.getPassword());
		} catch (DataAccessException e) {

			e.printStackTrace();
			return -1;
		}

	}

	@Override
	public User getUser(String mobileNo, String password) {
		try {

			String query = "SELECT * FROM users WHERE mobile_no = ? AND password = ?";
			User user = null;
			if (mobileNo != null && !mobileNo.isEmpty()) {
				if (password != null && !password.isEmpty()) {
					user = jdbcTemplate.queryForObject(query, new UserRowMapper(), mobileNo, password);
				}
			}
			return user;
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}
}

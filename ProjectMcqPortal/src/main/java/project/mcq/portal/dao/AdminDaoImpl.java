package project.mcq.portal.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import project.mcq.portal.entities.Admin;
import project.mcq.portal.rowmappers.AdminRowMapper;

public class AdminDaoImpl implements AdminDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Admin getAdmin(String username, String password) {
		String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
		Admin admin = null;
		try {
			if (username != null && !username.isEmpty()) {
				if (password != null && !password.isEmpty()) {
					System.out.println("Admin : " + admin);
					admin = jdbcTemplate.queryForObject(query, new AdminRowMapper(), username, password);
				}
			}
		} catch (EmptyResultDataAccessException e) {

			System.err.println("No admin found with the provided credentials.");
			e.printStackTrace();
		} catch (Exception e) {

			System.err.println("An error occurred while retrieving admin information.");
			e.printStackTrace();
		}

		return admin;
	}

}

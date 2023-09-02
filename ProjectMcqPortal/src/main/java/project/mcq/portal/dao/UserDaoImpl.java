package project.mcq.portal.dao;

import project.mcq.portal.entities.Admin;
import project.mcq.portal.entities.User;
import project.mcq.portal.rowmappers.AdminRowMapper;
import project.mcq.portal.rowmappers.UserRowMapper;

import org.springframework.beans.factory.annotation.Autowired;
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
	public int insertUser(User user){
		String insertQuery = "INSERT INTO "
				+ "users "
				+ "(mobile_no, name, password)"
				+ "VALUES (?,?,?)";

		return this.jdbcTemplate.update(
				insertQuery,user.getMobileNo(),user.getName(),user.getPassword());
	}
	@Override
	public User getUser(String mobileNo,String password)
	{
		
        
        String query = "SELECT * FROM users WHERE mobile_no = ? AND password = ?";
		User user = null;
		if(mobileNo != null && !mobileNo.isEmpty() ) {
			if( password != null && !password.isEmpty()) {
				user = jdbcTemplate.queryForObject(query, new UserRowMapper(), mobileNo, password); 
				System.out.println("User : " + user);
			}
		}
        return user;
	}
	
}

package project.mcq.portal.rowmappers;
import java.sql.*;
import org.springframework.jdbc.core.RowMapper;
import project.mcq.portal.entities.Admin;
public class AdminRowMapper implements RowMapper<Admin>{

	@Override
	public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
		Admin admin = new Admin();
		
		admin.setAdminId(rs.getInt("admin_id"));
		admin.setUsername(rs.getString("username"));
		admin.setPassword(rs.getString("password"));
		return admin;
	}

}

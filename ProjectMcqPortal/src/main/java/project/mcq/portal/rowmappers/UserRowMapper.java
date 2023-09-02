package project.mcq.portal.rowmappers;

import java.sql.SQLException;
import java.sql.ResultSet;
import project.mcq.portal.entities.User;
import org.springframework.jdbc.core.RowMapper;

public class UserRowMapper implements RowMapper<User>
{
    public User mapRow(final ResultSet rs, final int rowNum) throws SQLException {
        final User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setMobileNo(rs.getString("mobile_no"));
        user.setName(rs.getString("name"));
        user.setPassword(rs.getString("password"));
        return user;
    }
}
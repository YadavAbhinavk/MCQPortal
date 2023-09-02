package project.mcq.portal.rowmappers;

import java.sql.SQLException;
import java.sql.ResultSet;
import project.mcq.portal.entities.UserTest;
import org.springframework.jdbc.core.RowMapper;

public class UserTestRowMapper implements RowMapper<UserTest>
{
    public UserTest mapRow(final ResultSet rs, final int rowNum) throws SQLException {
        final UserTest userTest = new UserTest();
        userTest.setUserId(rs.getInt("user_id"));
        userTest.setUserTestId(rs.getInt("user_test_id"));
        userTest.setTag(rs.getString("tag"));
        userTest.setSubmissionTime(rs.getString("submission_time"));
        userTest.setScore(rs.getInt("score"));
        return userTest;
    }
}
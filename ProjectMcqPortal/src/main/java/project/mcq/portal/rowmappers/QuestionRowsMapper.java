package project.mcq.portal.rowmappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import project.mcq.portal.entities.Question;
public class QuestionRowsMapper implements RowMapper<Question> {
	
    public Question mapRow(ResultSet rs, int rowNum) throws SQLException {
        Question question = new Question();
        question.setQuestionId(rs.getInt("question_id"));
        question.setTag(rs.getString("tag"));
        question.setQuestionName(rs.getString("question_name"));
        question.setOption1(rs.getString("option1"));
        question.setOption2(rs.getString("option2"));
        question.setOption3(rs.getString("option3"));
        question.setOption4(rs.getString("option4"));
        question.setCorrectAnswer(rs.getString("answer"));
        question.setCorrectMarks(rs.getInt("correct_marks"));
        question.setWrongMarks(rs.getInt("wrong_marks"));
        return question;
    }

}

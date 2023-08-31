package project.mcq.portal.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import project.mcq.portal.entities.Question;
import project.mcq.portal.rowmappers.QuestionRowsMapper;

public class QuestionDaoImpl implements QuestionDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	@Override
	public int insertQues(Question question)
	{
		String insertQuery = "INSERT INTO "
				+ "questions "
				+ "(tag,question_name,option1,option2,"
				+ " option3,option4,answer) "
				+ "VALUES (?,?,?,?,?,?,?)";

		return this.jdbcTemplate.update(
				insertQuery, question.getTag(), question.getQuestionName(), 
				question.getOption1(), question.getOption2(),  question.getOption3(),
				 question.getOption4(), question.getCorrectAnswer());
	}
	@Override
	 public List<Question> getAllQuestionByTag(String tag) {
		String sql = "SELECT * FROM questions WHERE tag = ?";
		List<Map<String,Object>> rows = jdbcTemplate.queryForList(sql,tag);
		List<Question> questions = new ArrayList<>();
		for(Map<String,Object> row: rows)
		{
			Question question = new Question();
			question.setQuestionId((int) row.get("question_id"));
			question.setTag((String) row.get("tag"));
			question.setQuestionName((String) row.get("question_name"));
			question.setOption1((String) row.get("option1"));
			question.setOption2((String) row.get("option2"));
			question.setOption3((String) row.get("option3"));
			question.setOption4((String) row.get("option4"));
			question.setCorrectAnswer((String) row.get("answer"));
			questions.add(question);
			
		}
		return questions;
    }
	@Override
	public int deleteQues(int questionId)
	{
		String deleteQuery = "Delete from questions where question_id=?";
		return this.jdbcTemplate.update(
				deleteQuery,questionId);
	}
	@Override
	public int updateQues(Question question)
	{
		String updateQuery = "Update questions set question_name = ?,option1 = ?, "
				+ "option2 = ?,option3 = ?,option4 = ?,answer=?"
				+ "where question_id=?";
		return this.jdbcTemplate.update(
				updateQuery,question.getQuestionName(),question.getOption1(),question.getOption2(),
				question.getOption3(),question.getOption4(),question.getCorrectAnswer(),question.getQuestionId());
	}
	@Override
	public Question getQuestion(int quesId)
	{
		String query = "Select * from questions where question_id =?";
		
		return this.jdbcTemplate.queryForObject(query,new QuestionRowsMapper(),quesId);
	}
	@Override
	public String getAnswer(int quesId)
	{
		String getAnswerQuery = "Select answer from questions where question_id =?";
		return jdbcTemplate.queryForObject(getAnswerQuery, String.class, quesId);
	}
	
	 
}



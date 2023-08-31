package project.mcq.portal.dao;

import java.util.List;

import project.mcq.portal.entities.Question;

public interface QuestionDao {
	int insertQues(Question question);
	public List<Question> getAllQuestionByTag(String tag);
	int deleteQues(int questionId);
	int updateQues(Question question);
	Question getQuestion(int quesId);
	String getAnswer(int quesId);
}

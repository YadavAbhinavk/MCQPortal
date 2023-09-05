package project.mcq.portal.entities;

public class Question {
	private int questionId;
	private String tag;
	private String questionName;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private String correctAnswer;
	private int correctMarks;
	private int wrongMarks;
	public Question() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Question(int questionId, String tag, String questionName, String option1, String option2, String option3,
			String option4, String correctAnswer, int correctMarks, int wrongMarks) {
		super();
		this.questionId = questionId;
		this.tag = tag;
		this.questionName = questionName;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
		this.correctAnswer = correctAnswer;
		this.correctMarks = correctMarks;
		this.wrongMarks = wrongMarks;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getQuestionName() {
		return questionName;
	}
	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}
	public String getOption1() {
		return option1;
	}
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	public String getOption3() {
		return option3;
	}
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	public String getCorrectAnswer() {
		return correctAnswer;
	}
	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}
	public int getCorrectMarks() {
		return correctMarks;
	}
	public void setCorrectMarks(int correctMarks) {
		this.correctMarks = correctMarks;
	}
	public int getWrongMarks() {
		return wrongMarks;
	}
	public void setWrongMarks(int wrongMarks) {
		this.wrongMarks = wrongMarks;
	}
	@Override
	public String toString() {
		return "Question [questionId=" + questionId + ", tag=" + tag + ", questionName=" + questionName + ", option1="
				+ option1 + ", option2=" + option2 + ", option3=" + option3 + ", option4=" + option4
				+ ", correctAnswer=" + correctAnswer + ", correctMarks=" + correctMarks + ", wrongMarks=" + wrongMarks
				+ "]";
	}
}

package project.mcq.portal.entities;

public class Tests {
	private int testId;
	private String tag;
	private int numberOfQuestions;
	private int numberOfUsers;
	private String isAvailable;
	private int questionsPerTest;
	private int timePerQuestion;
	

	public Tests() {
		super();
		
	}


	public Tests(int testId, String tag, int numberOfQuestions, int numberOfUsers, String isAvailable,
			int questionsPerTest, int timePerQuestion) {
		super();
		this.testId = testId;
		this.tag = tag;
		this.numberOfQuestions = numberOfQuestions;
		this.numberOfUsers = numberOfUsers;
		this.isAvailable = isAvailable;
		this.questionsPerTest = questionsPerTest;
		this.timePerQuestion = timePerQuestion;
	}


	public int getTestId() {
		return testId;
	}


	public void setTestId(int testId) {
		this.testId = testId;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public int getNumberOfQuestions() {
		return numberOfQuestions;
	}


	public void setNumberOfQuestions(int numberOfQuestions) {
		this.numberOfQuestions = numberOfQuestions;
	}


	public int getNumberOfUsers() {
		return numberOfUsers;
	}


	public void setNumberOfUsers(int numberOfUsers) {
		this.numberOfUsers = numberOfUsers;
	}


	public String getIsAvailable() {
		return isAvailable;
	}


	public void setIsAvailable(String isAvailable) {
		this.isAvailable = isAvailable;
	}


	public int getQuestionsPerTest() {
		return questionsPerTest;
	}


	public void setQuestionsPerTest(int questionsPerTest) {
		this.questionsPerTest = questionsPerTest;
	}


	public int getTimePerQuestion() {
		return timePerQuestion;
	}


	public void setTimePerQuestion(int timePerQuestion) {
		this.timePerQuestion = timePerQuestion;
	}


	@Override
	public String toString() {
		return "Test [testId=" + testId + ", tag=" + tag + ", numberOfQuestions=" + numberOfQuestions
				+ ", numberOfUsers=" + numberOfUsers + ", isAvailable=" + isAvailable + ", questionsPerTest="
				+ questionsPerTest + ", timePerQuestion=" + timePerQuestion + "]";
	}
	
	
	
	
}

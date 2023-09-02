package project.mcq.portal.entities;

public class UserTest
{
    private int userTestId;
    private int userId;
    private String tag;
    private String submissionTime;
    private int score;
    
    public UserTest() {
    }
    
    public UserTest(final int userTestId, final int userId, final String tag, final String submissionTime, final int score) {
        this.userTestId = userTestId;
        this.userId = userId;
        this.tag = tag;
        this.submissionTime = submissionTime;
        this.score = score;
    }
    
    public int getUserTestId() {
        return this.userTestId;
    }
    
    public void setUserTestId(final int userTestId) {
        this.userTestId = userTestId;
    }
    
    public int getUserId() {
        return this.userId;
    }
    
    public void setUserId(final int userId) {
        this.userId = userId;
    }
    
    public String getTag() {
        return this.tag;
    }
    
    public void setTag(final String tag) {
        this.tag = tag;
    }
    
    public String getSubmissionTime() {
        return this.submissionTime;
    }
    
    public void setSubmissionTime(final String date) {
        this.submissionTime = date;
    }
    
    public int getScore() {
        return this.score;
    }
    
    public void setScore(final int score) {
        this.score = score;
    }
    
    @Override
    public String toString() {
        return "UserTest [userTestId=" + this.userTestId + ", userId=" + this.userId + ", tag=" + this.tag + ", submissionTime=" + this.submissionTime + ", score=" + this.score + "]";
    }
}
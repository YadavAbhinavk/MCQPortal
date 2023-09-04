package project.mcq.portal.entities;

public class Users {
	private int userId;
	private String name;
	private String mobileNo;
	private String password;
	
	public Users() {
		super();
	}
	
	public Users(int userId, String name, String mobileNo, String password) {
		super();
		this.userId = userId;
		this.name = name;
		this.mobileNo = mobileNo;
		this.password = password;
	}
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", name=" + name + ", mobileNo=" + mobileNo + ", password=" + password + "]\n";
	}
	
	
}

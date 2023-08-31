package project.mcq.portal.dao;

import java.util.List;

import project.mcq.portal.entities.Test;

public interface TestDao 
{
	public int insertTest(Test test);
	public int getTest(String tag);
	public int updateTest(Test test);
	public List<Test> getListOfTests();
	public int deleteTest(String tag);
	public String getAvailability(String tag);
	
}

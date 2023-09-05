package project.mcq.portal.dao;

import java.util.List;

import project.mcq.portal.entities.Tests;

public interface TestDao 
{
	public int insertTest(Tests test);
	public int getTest(String tag);
	public int updateTest(Tests test);
	public List<Tests> getListOfTests();
	public int deleteTest(String tag);
	public String getAvailability(String tag);
	public Tests getTestDetails(String tag);
	public int updateAvailablity(Tests test);
}

package project.mcq.portal.dao;

import project.mcq.portal.entities.Admin;

public interface AdminDao {
	public Admin getAdmin(String username,String password);
}


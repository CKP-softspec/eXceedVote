package com.ckp.model.dao;

import java.util.List;

import com.ckp.model.Role;

public interface RoleDAO {
	
	public Role find(int id);
	public void save(Role role);
	public void delete(Role role);
	public List<Role> findAll();
	public List<Role> query(String q);
}

package com.ckp.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;

import com.ckp.model.Account;
import com.ckp.model.dao.AccountDAO;

public class JpaAccountDAO implements AccountDAO {

	private EntityManager em;
	public JpaAccountDAO(EntityManager em)
	{
		this.em = em;
	}
	@Override
	public Account find(String username, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void save(Account account) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(Account account) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Account> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Account> query(String q) {
		// TODO Auto-generated method stub
		return null;
	}

}

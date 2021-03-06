package com.ckp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ckp.model.Project;
import com.ckp.model.dao.DaoFactory;
import com.ckp.model.dao.ProjectDAO;

/**
 * Servlet implementation class VoteServlet
 */
public class SetTeamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetTeamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int team = Integer.parseInt(request.getParameter("team"));
		ProjectDAO projectdao = DaoFactory.getInstance().getProjectDAO();
		List<Project> projects = projectdao.findAll();
		if(projects.size() == 0)
		{
			for(int i = 0; i < team; i++)
			{
				Project project = new Project(null, null, null, null, null, null);
				projectdao.save(project);
			}
		}
		else
		{
			if(team > projects.size())
			{
				for(int i = 0; i < team - projects.size(); i++)
				{
					Project project = new Project(null, null, null, null, null, null);
					projectdao.save(project);
				}
			}
			else if(team < projects.size())
			{
				for(int i = 0; i < projects.size() - team; i++)
				{
					Project project = projectdao.find(projects.size() - i);
					projectdao.delete(project);
				}
			}
			else;
		}
		response.sendRedirect("AdminOtherSettingPage.jsp");
	}
}

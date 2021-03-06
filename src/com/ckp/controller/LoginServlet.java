package com.ckp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ckp.controller.UserAuthentication;
import com.ckp.model.Login_log;
import com.ckp.model.Question;
import com.ckp.model.Time;
import com.ckp.model.User;
import com.ckp.model.dao.DaoFactory;
import com.ckp.model.dao.Login_logDAO;
import com.ckp.model.dao.QuestionDAO;
import com.ckp.model.dao.TimeDAO;
import com.ckp.model.Role;
import com.ckp.model.dao.RoleDAO;
import com.ckp.model.dao.UserDAO;

/**
 * @author Kanin Sirisith
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * doGet
	 * Auto-generate method do nothing
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * Method doPost
	 * get username and password from form sent by loginPage.jsp then authenticate user by sent call login() method
	 * from UserAuthentication class then set session for user
	 * @param
	 * @return
	 * @exception throw ServletException , IOException
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		RoleDAO roledao = DaoFactory.getInstance().getRoleDAO();
		List<Role> roles = roledao.findAll();
		if(roles.size() == 0)
		{
			Role roleAdmin = new Role("admin", 0);
			Role roleGuest = new Role("guest", 1);
			Role roleStaff = new Role("staff", 10);
			Role roleStudent = new Role("student", 5);
			roledao.save(roleAdmin);
			roledao.save(roleGuest);
			roledao.save(roleStaff);
			roledao.save(roleStudent);
			UserDAO userdao = DaoFactory.getInstance().getUserDAO();
			User admin = new User("eXceedVote", "Administrator", "admin", Encryptor.encryptMessageMD5("admin"), 1, 0);
			QuestionDAO questiondao = DaoFactory.getInstance().getQuestionDAO();
			Question question = new Question("Popular Vote");
			TimeDAO timedao = DaoFactory.getInstance().getTimeDAO();
			Time time = new Time();
			timedao.save(time);
			questiondao.save(question);
			userdao.save(admin);
		}
		String username = request.getParameter("uname");
		String password = request.getParameter("password");
		String digestPassword = Encryptor.encryptMessageMD5(password);
		if (username == null || username == "" || password == null
				|| password == "") {
			request.setAttribute("message","Please enter Username and Password");
			request.getRequestDispatcher("LoginPage.jsp").forward(request,
					response);
		} else {
			try {
				User user = UserAuthentication.login(username,digestPassword);
				if (user != null) {
					HttpSession session = request.getSession(true);
					System.out.println(session.toString());
					session.setAttribute("user", user);
					session.setAttribute("isLogin", "yes");
					session.setAttribute("ip", request.getRemoteAddr());
					session.setAttribute("userID", user.getId());
					session.setAttribute("userRole", user.getRoleId());
					session.setAttribute("userTeam", user.getProjectId());
					Login_log log = new Login_log(session);
					Login_logDAO loginlog = DaoFactory.getInstance().getLogin_logDAO();
					loginlog.save(log);
					response.sendRedirect("VotePage.jsp");
				}
				else {
					request.setAttribute("message","Username or Password is incorrect.");
					request.getRequestDispatcher("LoginPage.jsp").forward(request,response);
				}
			} catch (Throwable theException) {
				System.out.println(theException);
			}
		}
	}

}

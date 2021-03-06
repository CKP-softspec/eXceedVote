<%@ page language="java" 
    contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"
%>

<%@ page import="com.ckp.model.Ranking" %>
<%@ page import="com.ckp.model.Question" %>
<%@ page import="com.ckp.model.Project" %>
<%@ page import="com.ckp.model.Theme" %>
<%@ page import="com.ckp.model.ProjectResult" %>
<%@ page import="com.ckp.model.dao.DaoFactory" %>
<%@ page import="com.ckp.model.dao.QuestionDAO" %>
<%@ page import="com.ckp.model.dao.ProjectDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>

<%
	String s = (String)session.getAttribute("isLogin");
	int roleId = (Integer)session.getAttribute("userRole");
	int teamId = (Integer)session.getAttribute("userTeam");
	if(s == null || s == "" || s == "no")
	{
%>
	<jsp:forward page="LoginPage.jsp"></jsp:forward>
<%
	}
	if(roleId != 1)
	{
%>
	<jsp:forward page="VotePage.jsp"></jsp:forward>
<%
	}
	QuestionDAO questiondao = DaoFactory.getInstance().getQuestionDAO();
	List<Question> questions = questiondao.findAll();
	Ranking rank = new Ranking();
	HashMap<Question, List<ProjectResult>> rankmap = rank.getRankMap();
	ProjectDAO projectdao = DaoFactory.getInstance().getProjectDAO();
	List<Project> projects = projectdao.findAll();
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>eXceedVote</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Le styles -->
    <% out.println(Theme.getInstance().getTheme()); %>
    <link href="css/style.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    <!-- Add jQuery library -->
	<script type="text/javascript" src="fancybox/lib/jquery-1.8.2.min.js"></script>

	<!-- Add fancyBox main JS and CSS files -->
	<script type="text/javascript" src="fancybox/source/jquery.fancybox.js?v=2.0.6"></script>
	<link rel="stylesheet" type="text/css" href="fancybox/source/jquery.fancybox.css?v=2.0.6" media="screen" />
	<style type="text/css">
		.fancybox-custom .fancybox-skin {
			box-shadow: 0 0 50px #222;
		}
	</style>
	<script type="text/javascript" src="js/admin.js"></script>
	<script>
		var auto_refresh = setInterval(
		function (){
			$('#panel').load('AdminShowRanking.jsp #t1');
		}, 1000);
	
		function showModal(questionid) {
			var modal = '#modal' + questionid;
			var table = '#table-modal' + questionid;
			<%
				out.println("$(table).html(");
				
				out.println(");");
			%>
			$(modal).modal();
		}
		
		
		
	</script>
  </head>

  <body data-spy="scroll">

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="VotePage.jsp">eXceed Camp</a>
          <div class="nav-collapse collapse">
            <ul class="nav pull-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <strong>${user.getName()} ${user.getLastName() }</strong><b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <% if(roleId == 1) out.println("<li><a href=\"AdminAccountPage.jsp\">Administrator Page</a></li>"); %>
                  <li><a href="LogoutPage.jsp">Log out</a></li>
                </ul>
              </li>
            </ul>
            <ul class="nav">
              <li><a href="VotePage.jsp">Home</a></li>
              <li><a href="ProjectDetails.jsp">Project Details</a></li>
              <% if(teamId != 0) out.println("<li><a href=\"AddProjectPage.jsp\">Add/Edit Project</a></li>"); %>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
            <ul class="nav nav-list">
                <li class="nav-header">Account Setting</li>
                <li><a href="AdminAccountPage.jsp">Manage Account</a></li>
                <li><a href="#" onclick='showAddAccountModal()'>Add Account</a></li>
                <li class="nav-header">Vote Setting</li>
                <li class="active"><a href="AdminShowRanking.jsp">Show Ranking</a></li>
                <li><a href="AdminViewResult.jsp">View Vote Log</a></li>
                <li><a href="AdminQuestionPage.jsp">Manage Question</a></li>
                <li><a href="#" onclick='showAddQuestionModal()'>Add Question</a></li>
                <li class="nav-header">Other Setting</li>
                <li><a href="AdminOtherSettingPage.jsp">General Setting</a></li>
                <li class="divider"></li>
                <li><a href="LogoutPage.jsp">Log out</a></li>
            </ul>
        </div><!--/span-->
        <div class="span9" id="panel">
          <div class="hero-unit" id="t1">
          
          	<table class="table table-bordered"> 
          	<thead> 
          		<tr> 
          			<th>Question</th> 
          			<th>Ranking#1</th>
          			<th>Ranking#2</th>
          			<th>Ranking#3</th>
          			<th>See more</th>
          		</tr> 
          	</thead> 
          	<tbody> 
          		<%
          			for(Question question : questions)
          			{
          				List<ProjectResult> prs = rankmap.get(question);
          				out.println("<tr>");
          				out.println("<td rowspan='2'>" + question.getTitle() + "</td>");
          				int check = 0;
          				for(ProjectResult pr : prs)
          				{
          					if(check == 3) break;
          					out.println("<td>" + pr.getProject().getProjectName() + "</td>");
          					check++;
          				}
          				out.println("<td rowspan='2'><a href='#' onclick='showModal(" + question.getId() + ")'>See more ranking</a></td>");
          				out.println("</tr>");
          				out.println("<tr>");
          				check = 0;
          				for(ProjectResult pr : prs)
          				{
          					if(check == 3) break;
          					out.println("<td>Score: " + pr.getScore() + "</td>");
          					check++;
          				}
          				out.println("</tr>");
          			}
          		%>
          	</tbody> 
          </table>
          
          </div>
        </div><!--/span-->
        <%
        	for(Question question : questions)
        	{
        		List<ProjectResult> prs = rankmap.get(question);
        		out.println("<div class='modal hide fade' id='modal" + question.getId() + "'>");
      			out.println("<div class='modal-header'>");
        		out.println("<a class='close' data-dismiss='modal'>�</a>");
        		out.println("<h3>" + question.getTitle() + "</h3>");
     			out.println("</div>");
     			out.println("<div class='modal-body' id='modal-body" + question.getId() + "'>");
      			out.println("<table class='table table-bordered' id='table-modal" + question.getId() + "'>");
      			out.println("<thead>");
      			out.println("<tr>");
      			out.println("<th>Ranking</th>");
      			out.println("<th>Project</th>");
      			out.println("<th>Score</th>");
      			out.println("</tr>");
      			out.println("</thead>");
      			out.println("<tbody>"); 
      			int rankcount = 1;
      			for(ProjectResult pr : prs)
      			{
      				out.println("<tr>");
      				out.println("<td>" + rankcount + "</td>");
					out.println("<td>" + pr.getProject().getProjectName() + "</td>");
					out.println("<td>" + pr.getScore() + "</td>");
					out.println("</tr>");
					rankcount++;
      			}	
      			out.println("</tbody>");
      			out.println("</table>");
     		 	out.println("</div>");
      			out.println("<div class='modal-footer'>");
        		out.println("<a href='#' class='btn' data-dismiss='modal'>Close</a>");
      			out.println("</div>");
    			out.println("</div>");
        	}
        %>
        <div id="account-modal" class="modal hide fade in" style="display: none;">  
				<div class="modal-header">  
					<a class="close" data-dismiss="modal">�</a>  
					<h3>Add Account</h3>  
				</div>
				<form class="form-horizontal" id="account-form">  
				<div class="modal-body">       
					<div class="control-group">
		         		<label class="control-label">Username</label>
		         		<div class="controls">
		         			<input name="username" id="username" type="text" class="input-xlarge">
		         		</div>
		         	</div>
		         	<div class="control-group">
		         		<label class="control-label">Password</label>
		         		<div class="controls">
		         			<input name="password" id="password" type="password" class="input-xlarge">
		         		</div>
		         	</div>           
		         	<div class="control-group">
		         		<label class="control-label">First Name</label>
		         		<div class="controls">
		         			<input name="firstname" id="firstname" type="text" class="input-xlarge">
		         		</div>
		         	</div>
		         	<div class="control-group">
		         		<label class="control-label">Last Name</label>
		         		<div class="controls">
		         			<input name="lastname" id="lastname" type="text" class="input-xlarge">
		         		</div>
		         	</div>
		         	<div class="control-group">
		         		<label class="control-label">Role</label>
		         		<div class="controls">
		         			<div class="btn-group" data-toggle="buttons-radio">
  								<button type="button" onClick="$('#role').val('4'); $('#select-team').show(200);" class="btn active" checked>Student</button>
  								<button type="button" onClick="$('#role').val('3'); $('#select-team').hide(200); $('#team-select').val('0')" class="btn">Staff</button>
  								<button type="button" onClick="$('#role').val('2'); $('#select-team').hide(200); $('#team-select').val('0')" class="btn">Guest</button>
  								<button type="button" onClick="$('#role').val('1'); $('#select-team').hide(200); $('#team-select').val('0')" class="btn">Admin</button>
							</div>
							<input name="role" id="role" type="hidden" value="">
		         		</div>
		         	</div>
		         	
		         	<div class="control-group" id="select-team">
		         		<label class="control-label">Team</label>
		         		<div class="controls">
		         			<select id="team-select">
		         				<%
		         					int i = 1;
		         					for(Project project : projects)
		         					{
		         						out.println("<option value='" + project.getId() + "'>" + i + "</option>");
		         						i++;
		         					}
		         				%>
		         			</select>
		         		</div>
		         	</div>
				</div>
				<div class="modal-footer"> 
					<button type="button" id="submit-account" class="btn btn-primary" data-dismiss="modal" onclick='sendAddAccount()'>Save Changes</button>  
					<button class="btn" data-dismiss="modal">Close</button>  
				</div>
				</form>
          	</div>
          	<div id="question-modal" class="modal hide fade in" style="display: none;">  
				<div class="modal-header">  
					<a class="close" data-dismiss="modal">�</a>  
					<h3>Add Question</h3>  
				</div>  
				<form class="form-horizontal" id="question-form"> 
				<div class="modal-body">
					<div class="control-group">
		         		<label class="control-label">Question</label>
		         		<div class="controls">
		         			<input name="questionname" id="questionname" type="text" class="input-xlarge">
		         		</div>
		         	</div>                
				</div>
				<div class="modal-footer"> 
					<button type="button" id="submit-question" class="btn btn-primary" data-dismiss="modal" onclick='sendAddQuestion()'>Save Changes</button>  
					<button class="btn" data-dismiss="modal">Close</button>  
				</div>
				</form>
          	</div>
      </div><!--/row-->

      <hr>
      <footer>
        <p>&copy; develop by CKP</p>
      </footer>
    </div>    
    <script src="js/bootstrap-transition.js"></script>
    <script src="js/bootstrap-alert.js"></script>
    <script src="js/bootstrap-modal.js"></script>
    <script src="js/bootstrap-dropdown.js"></script>
    <script src="js/bootstrap-scrollspy.js"></script>
    <script src="js/bootstrap-tab.js"></script>
    <script src="js/bootstrap-tooltip.js"></script>
    <script src="js/bootstrap-popover.js"></script>
    <script src="js/bootstrap-button.js"></script>
    <script src="js/bootstrap-collapse.js"></script>
    <script src="js/bootstrap-carousel.js"></script>
    <script src="js/bootstrap-typeahead.js"></script>
  </body>
</html>

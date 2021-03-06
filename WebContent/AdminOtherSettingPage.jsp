<%@ page language="java" 
    contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"
%>

<%@ page import="com.ckp.model.Vote" %>
<%@ page import="com.ckp.model.Role" %>
<%@ page import="com.ckp.model.Time" %>
<%@ page import="com.ckp.model.Theme" %>
<%@ page import="com.ckp.model.Project" %>
<%@ page import="com.ckp.model.dao.DaoFactory" %>
<%@ page import="com.ckp.model.dao.VoteDAO" %>
<%@ page import="com.ckp.model.dao.RoleDAO" %>
<%@ page import="com.ckp.model.dao.ProjectDAO" %>
<%@ page import="com.ckp.model.dao.TimeDAO" %>
<%@ page import="java.util.List" %>

<%
	String s = (String)session.getAttribute("isLogin");
	if(s == null || s == "" || s == "no")
	{
%>
	<jsp:forward page="LoginPage.jsp"></jsp:forward>
<%
	}
	int roleId = (Integer)session.getAttribute("userRole");
	int teamId = (Integer)session.getAttribute("userTeam");
	if(roleId != 1)
	{
%>
	<jsp:forward page="VotePage.jsp"></jsp:forward>
<%
	}
	VoteDAO votedao = DaoFactory.getInstance().getVoteDAO();
	List<Vote> votes = votedao.findAll();
	RoleDAO roledao = DaoFactory.getInstance().getRoleDAO();
	List<Role> roles = roledao.findAll();
	ProjectDAO projectdao = DaoFactory.getInstance().getProjectDAO();
	List<Project> projects = projectdao.findAll();
	TimeDAO timedao = DaoFactory.getInstance().getTimeDAO();
	List<Time> times = timedao.findAll();
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
    <% out.println(Theme.getInstance().getTheme()); %>
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
		$(document).ready(function() {
			<%
				out.println("$('#day').val(" + times.get(0).getDay() + ");");
				out.println("$('#month').val(" + (times.get(0).getMonth() + 1) + ");");
				out.println("$('#year').val(" + times.get(0).getYear() + ");");
				out.println("$('#hour').val(" + times.get(0).getHour() + ");");
				out.println("$('#minute').val(" + times.get(0).getMin() + ");");
				out.println("$('#second').val(" + times.get(0).getSec() + ");");
				out.println("$('#theme').val(" + Theme.getInstance().getId() + ");");
			%>
		});
	</script>
	<script>
		$(document).ready(function() {
			$('#day').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
			
			$('#month').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
			
			$('#year').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
			
			$('#hour').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
			
			$('#minute').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
			
			$('#second').change(function() {
				$.post('settime-servlet', {day:$('#day').val(), month:$('#month').val(), year:$('#year').val(), hour:$('#hour').val(), minute:$('#minute').val(), second:$('#second').val()});
			});
		});
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
                <li><a href="AdminShowRanking.jsp">Show Ranking</a></li>
                <li><a href="AdminViewResult.jsp">View Vote Log</a></li>
                <li><a href="AdminQuestionPage.jsp">Manage Question</a></li>
                <li><a href="#" onclick='showAddQuestionModal()'>Add Question</a></li>
                <li class="nav-header">Other Setting</li>
                <li class="active"><a href="AdminOtherSettingPage.jsp">General Setting</a></li>
                <li class="divider"></li>
                <li><a href="LogoutPage.jsp">Log out</a></li>
            </ul>
        </div><!--/span-->
        <div class="span9" id="panel">
          <div class="hero-unit" id="t1">
          	<div id="legend"class="">
		    	<legend id="l1">VOTE END TIME</legend>
		    </div>
		    <div class="row">
		    	<div class="span4">
		    		<p class="offset4">Day</p>
		    	</div>
		    	<div class="span4">
		    		<p class="offset4">Month</p>
		    	</div>
		    	<div class="span4">
		    		<p class="offset4">Year</p>
		    	</div>
		    </div>
		    <div class="row">
		    	<div class="span4">
		    		<select id="day" name="day">
		    			<%
		    				for(int i = 1; i <= 31; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    	<div class="span4">
		    		<select id="month">
		    			<%
		    				for(int i = 1; i <= 12; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    	<div class="span4">
		    		<select id="year">
		    			<%
		    				for(int i = 2012; i <= 2020; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    </div>
		    <div class="row">
		    	<div class="span4">
		    		<p class="offset4">Hour</p>
		    	</div>
		    	<div class="span4">
		    		<p class="offset4">Minute</p>
		    	</div>
		    	<div class="span4">
		    		<p class="offset4">Second</p>
		    	</div>
		    </div>
		    <div class="row">
		    	<div class="span4">
		    		<select id="hour">
		    			<%
		    				for(int i = 0; i <= 23; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    	<div class="span4">
		    		<select id="minute">
		    			<%
		    				for(int i = 0; i <= 59; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    	<div class="span4">
		    		<select id="second">
		    			<%
		    				for(int i = 0; i <= 59; i++)
		    				{
		    					out.println("<option value='" + i + "'>" + i +"</option>");
		    				}
		    			%>
		    		</select>
		    	</div>
		    </div>
		    
		    <div id="legend"class="">
		        <legend id="l2">TEAM</legend>
		    </div>
		    <% out.println("<p>All Team : " + projects.size() + "</p>"); %>
		    <div class="control-group">
		    	<div class="controls">
		    		<form method="post" action="setteam-servlet">
		    			<input id="team" name="team" type="text"></input>
		    			<input type="submit" class="btn btn-primary" style="margin-top: -9px; margin-left: 10px"></input>
		    		</form>
		    	</div>
		    </div>
		    
		    <div id="legend"class="">
		        <legend id="l3">BALLOT LIMIT</legend>
		    </div>
		    <table class="table table-bordered table-hover">
		    	<thead>
		    		<tr>
		    			<th>ID</th>
		    			<th>Role</th>
		    			<th>Ballot Limit</th>
		    			<th>New Ballot Limit</th>
		    			<th>Submit</th>
		    		</tr>
		    	</thead>
		    	<tbody>
		    		<%
		    			int countrole = 1;
		    			for(Role role : roles)
		    			{
		    				out.println("<tr>");
		    				out.println("<td>" + role.getId() + "</td>");
		    				out.println("<td>" + role.getRole() + "</td>");
		    				out.println("<td id='ballot" + role.getId() + "'>" + role.getVoteLimit() + "</td>");
		    				out.println("<td><input type='text' id='role" + role.getId() + "'></input></td>");
		    				out.println("<td><button class=\"btn btn-primary\" onclick='setRole(\"" + role.getId() +"\")'>Submit</button></td>");
		    				out.println("</tr>");
		    			}
		    			countrole++;
		    		%>
		    	</tbody>
		    </table>
		    
		    <div id="legend"class="">
		        <legend id="l4">THEME</legend>
		    </div>
		    <p>Theme: Default</p>
		    <form method="post" action="settheme-servlet">
		    <div class="control-group">
		    	<div class="controls">
			    	<select id="theme" name="theme">
			    		<option value="1">Default</option>
			    		<option value="2">Amelia</option>
			    		<option value="3">Cerulean</option>
			    		<option value="4">Cosmo</option>
			    		<option value="5">Cyborg</option>
			    		<option value="6">Journal</option>
			    		<option value="7">Readable</option>
			    		<option value="8">Simplex</option>
			    		<option value="9">Slate</option>
			    		<option value="10">Spacelab</option>
			    		<option value="11">Spruce</option>
			    		<option value="12">Superhero</option>
			    		<option value="13">United</option>
			    	</select>
		    		<input type="submit" class="btn btn-primary" style="margin-top: -9px; margin-left: 10px">
		    	</div>
		    </div>
          	</form>
          </div>
        </div><!--/span-->
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

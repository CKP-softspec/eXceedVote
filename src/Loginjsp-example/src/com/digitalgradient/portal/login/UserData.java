package com.digitalgradient.portal.login;

public class UserData {
	
    private String username;
    private String password;
    private String realName;
    private String score;
    public boolean valid;
	
	
    public String getRealName() {
       return realName;
	}
    public void setRealName(String newRealName) {
       realName = newRealName;
	}
	
    public String getScore() {
       return score;
	}
    public void setScore(String newScore) {
       score = newScore;
	}

    public String getPassword() {
       return password;
	}
    public void setPassword(String newPassword) {
       password = newPassword;
	}

    public String getUserName() {
       return username;
	}
    public void setUserName(String newUsername) {
       username = newUsername;
	}
			
    public boolean isValid() {
       return valid;
	}

    public void setValid(boolean newValid) {
       valid = newValid;
	}	
}
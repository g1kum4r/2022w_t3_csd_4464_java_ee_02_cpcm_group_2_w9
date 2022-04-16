/**
 * 
 */
package sys.paymentbilling.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sys.paymentbilling.Constants;
import sys.paymentbilling.dao.PayRegisterDao;
import sys.paymentbilling.exception.IncorrectUsernameOrPassword;
import sys.paymentbilling.model.PayRegister;

public class LoginServlet extends HttpServlet {
	
	PayRegisterDao userDao;
	
	public LoginServlet() {
		userDao = new PayRegisterDao();
	}
		
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String username = req.getParameter(Constants.USERNAME);
		String password = req.getParameter(Constants.PASSWORD);
		try {
			
			PayRegister user = null;
			
			if(req.getParameter(Constants.ROLE) != null 
					&& req.getParameter(Constants.ROLE).equalsIgnoreCase(Constants.ROLE_ADMIN)) {
				user = userDao.loginAsAdmin(username, password);
			} else {
				user = userDao.login(username, password);				
			}
			
			if(user != null) {
				HttpSession session = req.getSession();
				session.setAttribute(Constants.USER_ID, user.getId());
				session.setAttribute(Constants.USERNAME, user.getUsername());
				session.setAttribute(Constants.ROLE, user.getRole());
				session.setAttribute(Constants.BRANCH, user.getBranch());
			}
			resp.sendRedirect(req.getContextPath().concat("/dashboard"));
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IncorrectUsernameOrPassword e) {
			resp.sendRedirect(
					req.getContextPath()
					.concat("/login.jsp?error=")
					.concat(e.getLocalizedMessage()));
		}
	}
	
}

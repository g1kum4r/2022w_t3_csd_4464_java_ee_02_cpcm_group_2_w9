package sys.paymentbilling.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sys.paymentbilling.Constants;


public class IndexServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Object roleObject = session.getAttribute(Constants.ROLE);
		if(roleObject != null) {
			String role = (String) roleObject;
			if(role.equalsIgnoreCase(Constants.ROLE_ADMIN)) {
				resp.sendRedirect(req.getContextPath().concat("/admin/home.jsp"));
			} else if (role.equalsIgnoreCase(Constants.ROLE_ACCOUNTANT)) {
				resp.sendRedirect(req.getContextPath().concat("/accountant/home.jsp"));
			}
		}
		
		if(roleObject == null) {
			resp.sendRedirect(req.getContextPath().concat("/login.jsp"));
		}
	}

}

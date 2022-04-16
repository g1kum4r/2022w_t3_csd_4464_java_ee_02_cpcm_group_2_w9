package sys.paymentbilling.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sys.paymentbilling.Constants;
import sys.paymentbilling.dao.PayRegisterDao;
import sys.paymentbilling.model.PayRegister;

public class AdminAccountantServlet extends HttpServlet {
	
	private PayRegisterDao payRegisterDao;
	
	public AdminAccountantServlet() {
		payRegisterDao = new PayRegisterDao();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		String idString = req.getParameter("id");
		if(action != null && !action.isEmpty()) {
			if(action.equalsIgnoreCase(Constants.EDIT)) {
				resp.sendRedirect(req.getContextPath().concat(String.format("/admin/create_accountant.jsp?id=%s", idString)));
			} else if (action.equalsIgnoreCase(Constants.DELETE)) {
				try {
					payRegisterDao.deleteAccountant(Integer.parseInt(idString));
					resp.sendRedirect(req.getContextPath().concat("/admin/home.jsp"));
				} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					resp.sendRedirect(req.getContextPath().concat(String.format("/admin/home.jsp?error=%s", e.getMessage())));
				}
			}
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter(Constants.ID);
		String branch = req.getParameter(Constants.BRANCH);
		String username = req.getParameter(Constants.USERNAME);
		String password = req.getParameter(Constants.PASSWORD);
		String dateOfJoining = req.getParameter(Constants.DATE_OF_JOINING);
		String dateOfBirth = req.getParameter(Constants.DATE_OF_BIRTH);
		String salary = req.getParameter(Constants.SALARY);
		
		PayRegister payRegister = new PayRegister();
		payRegister.setUsername(username);
		payRegister.setPassword(password);
		payRegister.setBranch(branch);
		payRegister.setDateOfJoining(dateOfJoining);
		payRegister.setDateOfBirth(dateOfBirth);
		payRegister.setSalary(salary);
		
		try {
			if(id != null && !id.isEmpty()) {
				this.payRegisterDao.updateAccountant(Integer.parseInt(id), payRegister);
				resp.sendRedirect(req.getContextPath()
						.concat("/admin/create_accountant.jsp?id=")
						.concat(String.valueOf(payRegister.getId()))
						.concat("&status=Updated"));				
			} else {
				this.payRegisterDao.createAccountant(payRegister);
				resp.sendRedirect(req.getContextPath()
						.concat("/admin/create_accountant.jsp?id=")
						.concat(String.valueOf(payRegister.getId()))
						.concat("&status=Created"));
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath()
					.concat("/admin/create_accountant.jsp?error=")
					.concat(e.getMessage()));
		}
	}

}

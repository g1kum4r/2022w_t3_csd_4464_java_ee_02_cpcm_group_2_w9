package sys.paymentbilling.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sys.paymentbilling.Constants;
import sys.paymentbilling.dao.StudentDao;
import sys.paymentbilling.model.Student;

public class AccountantStudentServlet extends HttpServlet {
	
	
	private StudentDao studentDao;
	public AccountantStudentServlet() {
		this.studentDao = new StudentDao();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		String idString = req.getParameter("id");
		if(action != null && !action.isEmpty()) {
			if(action.equalsIgnoreCase(Constants.EDIT)) {
				resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/create_student.jsp?id=%s", idString)));
			} else if (action.equalsIgnoreCase(Constants.DELETE)) {
				try {
					studentDao.deleteStudent(Integer.parseInt(idString));
					resp.sendRedirect(req.getContextPath().concat("/accountant/home.jsp"));
				} catch (NumberFormatException | ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/home.jsp?error=%s", e.getMessage())));
				}
			}
		}
	}


	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Student student = new Student();
		student.setName(req.getParameter(Constants.NAME));
		student.setCourse(req.getParameter(Constants.COURSE));
		student.setMobile(req.getParameter(Constants.MOBILE));
		student.setFeeSub(req.getParameter(Constants.FEE_SUB));
		student.setFees(req.getParameter(Constants.FEES));
		student.setPaid(req.getParameter(Constants.PAID));
		student.setBalance(req.getParameter(Constants.BALANCE));
		student.setAddress(req.getParameter(Constants.ADDRESS));
		student.setFatherName(req.getParameter(Constants.FATHER_NAME));
		student.setMotherName(req.getParameter(Constants.MOTHER_NAME));
		student.setDateOfBirth(req.getParameter(Constants.DATE_OF_BIRTH));
		student.setDateOfJoining(req.getParameter(Constants.DATE_OF_JOINING));
		student.setQualification(req.getParameter(Constants.QUALIFICATION));
		student.setTrainer(req.getParameter(Constants.TRAINER));
		try {
			String idString = req.getParameter("id");
			if(idString != null && !idString.isEmpty()) {
				student.setId(Integer.parseInt(idString));
				studentDao.updateStudent(student.getId(), student);								
				resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/create_student.jsp?status=updated&id=%d", student.getId())));
			} else {
				studentDao.createStudent(student);				
				if(student.getId() > 0) {
					resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/create_student.jsp?status=created&id=%d", student.getId())));
				} else {
					resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/create_student.jsp?error", "Student not saved. Unknown error, see logs.")));
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath().concat(String.format("/accountant/create_student.jsp?error", e.getMessage())));
		}
	}
}

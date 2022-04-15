package sys.paymentbilling.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sys.paymentbilling.Constants;
import sys.paymentbilling.exception.IncorrectUsernameOrPassword;
import sys.paymentbilling.jdbc.JdbcUtil;
import sys.paymentbilling.mapper.RowMapper;
import sys.paymentbilling.model.PayRegister;

public class PayRegisterDao {
	
	private RowMapper<PayRegister> userRowMapper = rs -> {
		try {
			if(rs.next()) {
				PayRegister payRegister = new PayRegister();
				payRegister.setId(rs.getInt("id"));
				payRegister.setUsername(rs.getString("user_name"));
				payRegister.setPassword(rs.getString("user_pwd"));
				payRegister.setBranch(rs.getString("branch"));
				payRegister.setRole(rs.getString("role"));
				payRegister.setDateOfJoining(rs.getString("date_of_joining"));
				payRegister.setDateOfBirth(rs.getString("date_of_birth"));
				payRegister.setSalary(rs.getString("salary"));
				return payRegister;					
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	};

	private RowMapper<List<PayRegister>> usersRowMapper = rs -> {
		List<PayRegister> users = new ArrayList<>();
		try {
			while(rs.next()) {
				PayRegister payRegister = new PayRegister();
				payRegister.setId(rs.getInt("id"));
				payRegister.setUsername(rs.getString("user_name"));
				payRegister.setPassword(rs.getString("user_pwd"));
				payRegister.setBranch(rs.getString("branch"));
				payRegister.setRole(rs.getString("role"));
				payRegister.setDateOfJoining(rs.getString("date_of_joining"));
				payRegister.setDateOfBirth(rs.getString("date_of_birth"));
				payRegister.setSalary(rs.getString("salary"));
				users.add(payRegister);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	};


	public PayRegister login(String username, String password, String role)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		PayRegister payRegister = JdbcUtil.execute("select * from pay_register u" + " where u.user_name = ? and u.user_pwd = ? and u.role = ?",
				userRowMapper, username, password, role);
		if (payRegister == null) {
			throw new IncorrectUsernameOrPassword();
		}
		return payRegister;
	}
	
	public PayRegister login(String username, String password)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		PayRegister payRegister = JdbcUtil.execute("select * from pay_register u" + " where u.user_name = ? and u.user_pwd = ? and u.role != 'ADMIN'",
				userRowMapper, username, password);
		if (payRegister == null) {
			throw new IncorrectUsernameOrPassword();
		}
		return payRegister;
	}

	public PayRegister loginAsAdmin(String username, String password)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		
		return login(username, password, Constants.ROLE_ADMIN);
	}

	public void createAccountant(PayRegister user) throws ClassNotFoundException, SQLException {
		user.setRole(Constants.ROLE_ACCOUNTANT);
		int id = JdbcUtil.insert("insert into pay_register"
				+ "(user_name, user_pwd, role, branch, date_of_joining, date_of_birth, salary)"
				+ "values (?, ?, ?, ?, ?, ?, ?)", 
				user.getUsername(), user.getPassword(), user.getRole(), user.getBranch(), user.getDateOfJoining(), user.getDateOfBirth(), user.getSalary());
		user.setId(id);
	}
	
	public void updateAccountant(int id, PayRegister user) throws ClassNotFoundException, SQLException {
		user.setRole(Constants.ROLE_ACCOUNTANT);
		JdbcUtil.insert("update pay_register set user_pwd = ?, branch = ?, date_of_joining = ?, date_of_birth = ?, salary = ? "
				+ "where id = ? ", 
				user.getPassword(), user.getBranch(), user.getDateOfJoining(), user.getDateOfBirth(), user.getSalary(), id);
		user.setId(id);
	}

	public PayRegister getAccountant(int id) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.id = ?", userRowMapper, id);
	}

	public List<PayRegister> getAccountants() throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT'", usersRowMapper);
	}
	
	public List<PayRegister> searcAccountants(String branch) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.branch = ?", usersRowMapper, branch);
	}
	
	public List<PayRegister> searcAccountants(String searchQuery, String branch) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.user_name = ? and u.branch = ?", usersRowMapper, searchQuery, branch);
	}

	public int deleteAccountant(int parseInt) throws ClassNotFoundException, SQLException {
		return JdbcUtil.delete("delete from pay_register where id = ?", parseInt);
	}

}

package sys.paymentbilling.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sys.paymentbilling.Constants;
import sys.paymentbilling.exception.IncorrectUsernameOrPassword;
import sys.paymentbilling.jdbc.JdbcUtil;
import sys.paymentbilling.mapper.RowMapper;
import sys.paymentbilling.model.User;

public class UserDao {
	
	private RowMapper<User> userRowMapper = rs -> {
		try {
			if(rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("user_name"));
				user.setPassword(rs.getString("user_pwd"));
				user.setBranch(rs.getString("branch"));
				user.setRole(rs.getString("role"));
				user.setDateOfJoining(rs.getString("date_of_joining"));
				user.setDateOfBirth(rs.getString("date_of_birth"));
				user.setSalary(rs.getString("salary"));
				return user;					
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	};

	private RowMapper<List<User>> usersRowMapper = rs -> {
		List<User> users = new ArrayList<>();
		try {
			while(rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("user_name"));
				user.setPassword(rs.getString("user_pwd"));
				user.setBranch(rs.getString("branch"));
				user.setRole(rs.getString("role"));
				user.setDateOfJoining(rs.getString("date_of_joining"));
				user.setDateOfBirth(rs.getString("date_of_birth"));
				user.setSalary(rs.getString("salary"));
				users.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	};


	public User login(String username, String password, String role)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		User user = JdbcUtil.execute("select * from pay_register u" + " where u.user_name = ? and u.user_pwd = ? and u.role = ?",
				userRowMapper, username, password, role);
		if (user == null) {
			throw new IncorrectUsernameOrPassword();
		}
		return user;
	}
	
	public User login(String username, String password)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		User user = JdbcUtil.execute("select * from pay_register u" + " where u.user_name = ? and u.user_pwd = ? and u.role != 'ADMIN'",
				userRowMapper, username, password);
		if (user == null) {
			throw new IncorrectUsernameOrPassword();
		}
		return user;
	}

	public User loginAsAdmin(String username, String password)
			throws ClassNotFoundException, SQLException, IncorrectUsernameOrPassword {
		
		return login(username, password, Constants.ROLE_ADMIN);
	}

	public void createAccountant(User user) throws ClassNotFoundException, SQLException {
		user.setRole(Constants.ROLE_ACCOUNTANT);
		int id = JdbcUtil.insert("insert into pay_register"
				+ "(user_name, user_pwd, role, branch, date_of_joining, date_of_birth, salary)"
				+ "values (?, ?, ?, ?, ?, ?, ?)", 
				user.getUsername(), user.getPassword(), user.getRole(), user.getBranch(), user.getDateOfJoining(), user.getDateOfBirth(), user.getSalary());
		user.setId(id);
	}
	
	public void updateAccountant(int id, User user) throws ClassNotFoundException, SQLException {
		user.setRole(Constants.ROLE_ACCOUNTANT);
		JdbcUtil.insert("update pay_register set user_pwd = ?, branch = ?, date_of_joining = ?, date_of_birth = ?, salary = ? "
				+ "where id = ? ", 
				user.getPassword(), user.getBranch(), user.getDateOfJoining(), user.getDateOfBirth(), user.getSalary(), id);
		user.setId(id);
	}

	public User getAccountant(int id) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.id = ?", userRowMapper, id);
	}

	public List<User> getAccountants() throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT'", usersRowMapper);
	}
	
	public List<User> searcAccountants(String branch) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.branch = ?", usersRowMapper, branch);
	}
	
	public List<User> searcAccountants(String searchQuery, String branch) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from pay_register u where u.role = 'ACCOUNTANT' and u.user_name = ? and u.branch = ?", usersRowMapper, searchQuery, branch);
	}

	public int deleteAccountant(int parseInt) throws ClassNotFoundException, SQLException {
		return JdbcUtil.delete("delete from pay_register where id = ?", parseInt);
	}

}

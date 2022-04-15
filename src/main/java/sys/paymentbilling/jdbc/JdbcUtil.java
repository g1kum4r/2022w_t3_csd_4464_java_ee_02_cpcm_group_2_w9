package sys.paymentbilling.jdbc;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.Connection;

import sys.paymentbilling.mapper.RowMapper;

public class JdbcUtil {

	private static Connection connection;

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		if (connection == null || connection.isClosed()) {
			Class.forName("com.mysql.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/paymentbillingsys?verifyServerCertificate=false&useSSL=false", "root",
					"root");
		}
		return connection;
	}

	public static ResultSet execute(String sql, Object... args) throws ClassNotFoundException, SQLException {
		PreparedStatement prepareStatement = getConnection().prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			prepareStatement.setObject(i + 1, args[i]);
		}
		prepareStatement.execute(sql);
		return prepareStatement.getResultSet();
	}

	public static <T> T execute(String sql, RowMapper<T> rowMapper, Object... args)
			throws ClassNotFoundException, SQLException {
		PreparedStatement prepareStatement = getConnection().prepareStatement(sql);
		for (int i = 0; i < args.length; i++) {
			prepareStatement.setObject(i + 1, args[i]);
		}
		if (prepareStatement.execute()) {
			return rowMapper.map(prepareStatement.getResultSet());
		}
		return null;
	}

	public static int insert(String sql, Object... args) throws ClassNotFoundException, SQLException {
		PreparedStatement prepareStatement = getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		for (int i = 0; i < args.length; i++) {
			prepareStatement.setObject(i + 1, args[i]);
		}
		if (prepareStatement.executeUpdate() > 0) {
			ResultSet resultSet = prepareStatement.getGeneratedKeys();
			return resultSet.next() ? resultSet.getInt(1) : 0;
		}
		return 0;
	}


	public static int delete(String sql, Object ...args) throws ClassNotFoundException, SQLException {
		PreparedStatement prepareStatement = getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		for (int i = 0; i < args.length; i++) {
			prepareStatement.setObject(i + 1, args[i]);
		}
		if (prepareStatement.executeUpdate() > 0) {
			ResultSet resultSet = prepareStatement.getGeneratedKeys();
			return resultSet.next() ? resultSet.getInt(1) : 0;
		}
		return 0;
	}

}

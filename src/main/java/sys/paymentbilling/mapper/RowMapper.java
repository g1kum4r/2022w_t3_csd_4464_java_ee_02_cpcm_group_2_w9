package sys.paymentbilling.mapper;

import java.sql.ResultSet;

public interface RowMapper <T> {
	public T map(ResultSet resultSet);
}

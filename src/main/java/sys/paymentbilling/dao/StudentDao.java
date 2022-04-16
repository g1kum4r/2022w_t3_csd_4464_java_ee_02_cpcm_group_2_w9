package sys.paymentbilling.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sys.paymentbilling.jdbc.JdbcUtil;
import sys.paymentbilling.mapper.RowMapper;
import sys.paymentbilling.model.Student;

public class StudentDao {
	
	private RowMapper<Student> studentRowMapper = (rs) -> {
		try {
			if(rs.next()) {
				Student student = new Student();
				student.setId(rs.getInt("id"));
				student.setName(rs.getString("name"));
				student.setCourse(rs.getString("course"));
				student.setMobile(rs.getString("mobile"));
				student.setFeeSub(rs.getString("fee_sub"));
				student.setFees(rs.getString("fees"));
				student.setPaid(rs.getString("paid"));
				student.setBalance(rs.getString("balance"));
				student.setAddress(rs.getString("address"));
				student.setFatherName(rs.getString("father_name"));
				student.setMotherName(rs.getString("mother_name"));
				student.setDateOfBirth(rs.getString("date_of_birth"));
				student.setDateOfJoining(rs.getString("date_of_joining"));
				student.setQualification(rs.getString("qualification"));
				student.setTrainer(rs.getString("trainer"));
				return student;				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	};

	private RowMapper<List<Student>> studentsRowMapper = (rs) -> {
		List<Student> students = new ArrayList<>();
		try {
			while(rs.next()) {
				Student student = new Student();
				student.setId(rs.getInt("id"));
				student.setName(rs.getString("name"));
				student.setCourse(rs.getString("course"));
				student.setMobile(rs.getString("mobile"));
				student.setFeeSub(rs.getString("fee_sub"));
				student.setFees(rs.getString("fees"));
				student.setPaid(rs.getString("paid"));
				student.setBalance(rs.getString("balance"));
				student.setAddress(rs.getString("address"));
				student.setFatherName(rs.getString("father_name"));
				student.setMotherName(rs.getString("mother_name"));
				student.setDateOfBirth(rs.getString("date_of_birth"));
				student.setDateOfJoining(rs.getString("date_of_joining"));
				student.setQualification(rs.getString("qualification"));
				student.setTrainer(rs.getString("trainer"));
				students.add(student);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return students;
	};
	
	public Student getStudent(int id) throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from student_2 where id = ?", studentRowMapper, id);
	}
	
	public List<Student> getStudents() throws ClassNotFoundException, SQLException {
		return JdbcUtil.execute("select * from student_2", studentsRowMapper);
	}
	
	public List<Student> getStudents(String searchQuery) throws ClassNotFoundException, SQLException {
		searchQuery = "%".concat(searchQuery).concat("%");
		return JdbcUtil.execute("select * from student_2 s where "
				+ " s.name like ? "
				+ " or s.course like ?"
				+ " or s.fee_sub like ?"
				+ " or s.fees like ?"
				+ " or s.paid like ?"
				+ " or s.balance like ? "
				+ " or s.mobile like ?"
				+ " or s.father_name like ?"
				+ " or s.mother_name like ?"
				+ " or s.address like ?"
				+ " or s.date_of_birth like ?"
				+ " or s.date_of_joining like ?"
				+ " or s.qualification like ?"
				+ " or s.trainer like ?", studentsRowMapper, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery
				, searchQuery);
	}
	
	
	public void createStudent(Student student) throws ClassNotFoundException, SQLException {
		int id = JdbcUtil.insertOrUpdate("INSERT INTO student_2 "
				+ "(name, course, mobile, fee_sub, fees, paid, balance, address, father_name, mother_name, date_of_birth, date_of_joining, qualification, trainer) "
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
				student.getName(), 
				student.getCourse(),
				student.getMobile(),
				student.getFeeSub(),
				student.getFees(),
				student.getPaid(),
				student.getBalance(),
				student.getAddress(),
				student.getFatherName(),
				student.getMotherName(),
				student.getDateOfBirth(),
				student.getDateOfJoining(),
				student.getQualification(),
				student.getTrainer());
		student.setId(id);
	}

	public void updateStudent(int id, Student student) throws ClassNotFoundException, SQLException {
		JdbcUtil.insertOrUpdate("UPDATE student_2 "
				+ " SET name=?, course=?, mobile=?, fee_sub=?, fees=?, paid=?, balance=?, address=?, father_name=?, mother_name=?, date_of_birth=?, date_of_joining=?, qualification=?, trainer=? "
				+ " WHERE id = ?", 
				student.getName(), 
				student.getCourse(),
				student.getMobile(),
				student.getFeeSub(),
				student.getFees(),
				student.getPaid(),
				student.getBalance(),
				student.getAddress(),
				student.getFatherName(),
				student.getMotherName(),
				student.getDateOfBirth(),
				student.getDateOfJoining(),
				student.getQualification(),
				student.getTrainer(), id);
		
	}

	public int deleteStudent(int id) throws ClassNotFoundException, SQLException {
		return JdbcUtil.delete("delete from student_2 where id = ?", id);
		
	}
	

}

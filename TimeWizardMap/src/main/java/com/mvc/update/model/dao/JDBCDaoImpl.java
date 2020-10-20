package com.mvc.update.model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.mvc.update.model.dto.JDBCDto;

@Repository
public class JDBCDaoImpl implements JDBCDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<JDBCDto> selectList() {
		List<JDBCDto> list = new ArrayList<JDBCDto>();
		
		String sql = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE "
				   + " FROM JDBCBOARD "
				   + " ORDER BY SEQ DESC ";
		
		try {
			list = jdbcTemplate.query(sql,
					(rs, rowNum)->{
						JDBCDto dto = new JDBCDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5));
								return dto;
					});
		} catch (DataAccessException e) {
			System.out.println("[ERROR] : selectList");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public JDBCDto selectOne(int seq) {
		JDBCDto dto = null;
		String sql = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE "
				   + " FROM JDBCBOARD "
				   + " WHERE SEQ = ? ";
		
		// queryForObject - 밑에서 세 번째 것. (sql, rowmap, args)
		dto = jdbcTemplate.queryForObject(sql, new MyMapper(), new Object[] {seq});
		
		return dto;
	}

	@Override
	public int insert(JDBCDto dto) {
		int res = 0;
		String sql = " INSERT INTO JDBCBOARD "
				   + " VALUES(JDBCBOARDSEQ.NEXTVAL, ?, ?, ?, SYSDATE) ";
		
		// .update(sql, args);
		res = jdbcTemplate.update(sql, new Object[] {dto.getWriter(), dto.getTitle(), dto.getContent()});
		
		return res;
	}

	@Override
	public int update(JDBCDto dto) {
		int res = 0;
		
		String sql = " UPDATE JDBCBOARD "
				   + " SET TITLE = ?, CONTENT = ? "
				   + " WHERE SEQ = ? ";
		
		res = jdbcTemplate.update(sql, new Object[] {dto.getTitle(), dto.getContent(), dto.getSeq()});
		
		return res;
	}

	@Override
	public int delete(int seq) {
		int res = 0;
		String sql = " DELETE FROM JDBCBOARD "
				   + " WHERE SEQ = ? ";
		
		res = jdbcTemplate.update(sql, new Object[] {seq});
		return res;
	}

	@Override
	public String test() {
		return null;
	}
	
	// inner Class
	private static final class MyMapper implements RowMapper<JDBCDto>{
		
		@Override
		public JDBCDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return new JDBCDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5));
		}
	}
}

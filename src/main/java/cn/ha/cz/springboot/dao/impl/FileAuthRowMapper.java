package cn.ha.cz.springboot.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import cn.ha.cz.springboot.bean.FileAuth;

public class FileAuthRowMapper implements RowMapper<FileAuth> {

	@Override
	public FileAuth mapRow(ResultSet rs, int rowNum) throws SQLException {
		FileAuth auth = new FileAuth();
		auth.setUserId(rs.getInt("userId"));
		auth.setAuthUserId(rs.getInt("authUserId"));
		auth.setAuthFileId(rs.getInt("authFileId"));
		
		return auth;
	}

}

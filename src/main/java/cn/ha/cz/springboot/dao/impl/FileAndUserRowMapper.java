package cn.ha.cz.springboot.dao.impl;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileBean;

public class FileAndUserRowMapper implements RowMapper<FileBean> {

	@Override
	public FileBean mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		//如果列名不存在的情况
//		ResultSetMetaData rsmd = rs.getMetaData();
//		int columnCount = rsmd.getColumnCount();
//		FileBean bean = new FileBean();
//		for(int i = 1; i <= columnCount; i++ ) {
//			String name = rsmd.getColumnName(i);
//		}
		
		FileBean bean = new FileBean();
		bean.setId(rs.getInt("id"));
		bean.setRemark(rs.getString("remark"));
		bean.setFilename(rs.getString("filename"));
		bean.setFilepath(rs.getString("filepath"));
		bean.setFullpath(rs.getString("fullpath"));
		bean.setQiniuUrl(rs.getString("qiniuUrl"));
		bean.setFiletype(EnumFileType.getById(rs.getInt("filetype")));
		bean.setFlag(rs.getInt("flag"));
		bean.setUploadtime(rs.getTimestamp("uploadtime"));
		bean.setFilesize(rs.getString("filesize"));
		bean.setParentid(rs.getInt("parentid"));

		// 关联表字段
		bean.setUserId(rs.getInt("user_id"));
		bean.setUsername(rs.getString("username"));

		return bean;
	}

}
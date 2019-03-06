package cn.ha.cz.springboot.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileBean;

public class FileRowMapper implements RowMapper<FileBean> {

	@Override
	public FileBean mapRow(ResultSet rs, int rowNum) throws SQLException {
		
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

		return bean;
	}

}
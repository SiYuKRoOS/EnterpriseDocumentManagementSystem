package cn.ha.cz.springboot.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.dao.IFileAuthDao;

@Repository
public class FileAuthDaoImpl implements IFileAuthDao {

	@Autowired
	JdbcTemplate jdbctemplate;

	@Override
	public List<FileBean> queryFileList(FileAuth param) {
		String sql = 
				  " SELECT DISTINCT b.*, d.username, d.id AS user_id" 
				+ " FROM file_auth a " 
				+ " JOIN FILE b ON (a.authFileId = b.id)" 
				//+ " JOIN user_file c ON (a.authFileId = c.fileId)" 
				+ " JOIN USER d ON (b.userId = d.id) "
				+ " WHERE 1=1 AND flag=1";
		
		//是否授权给当前用户
		if (param.getAuthUserId() > 0 && param.getAuthUserId()!=1) {
			sql += " AND a.authUserId = " + param.getAuthUserId();
		}
		//文件名模糊查询
		if (!StringUtils.isEmpty(param.getFilename())) {
			sql += " AND b.filename like '%" + param.getFilename() + "%'";
		}
		//文件类型查询
		if (param.getFiletype() > 0) {
			sql += " AND b.filetype = " + param.getFiletype();
		}
		
		
		String folderSQL = sql+ " AND b.filetype = "+EnumFileType.FOLFER.getId() + " ORDER BY b.uploadtime";
		String fileSQL   = sql+ " AND b.filetype != "  +EnumFileType.FOLFER.getId() + " ORDER BY b.uploadtime";
		
		List<FileBean> all =new ArrayList<>();
		
		List<FileBean> folderList = jdbctemplate.query(folderSQL, new FileAndUserRowMapper());
		List<FileBean> fileList = jdbctemplate.query(fileSQL, new FileAndUserRowMapper());
		
		all.addAll(folderList);
		all.addAll(fileList);
		
		return all;
	}

	@Override
	public int[] insertFileAuth(List<FileAuth> authlist) {
		// TODO Auto-generated method stub
		String sql = "insert into file_auth values (?,?,?)";

		List<Object[]> args = new ArrayList<>();
		for (FileAuth auth : authlist) {
			args.add(new Object[] { auth.getUserId(), auth.getAuthFileId(), auth.getAuthUserId() });
		}

		return jdbctemplate.batchUpdate(sql, args);
		// return jdbctemplate.update(sql, new Object[] {auth.getUserId(),
		// auth.getAuthFileId(), auth.getAuthUserId()});
	}

	@Override
	public List<FileAuth> queryAuthFileList(FileAuth fileAuth) {
		String sql = "select * from file_auth where 1=1";
		if (fileAuth.getUserId() > 0) {
			sql += " AND userId = " + fileAuth.getUserId();
		}
		if (fileAuth.getAuthUserId() > 0) {
			sql += " AND authUserId = " + fileAuth.getAuthUserId();
		}
		if (fileAuth.getAuthFileId() > 0) {
			sql += " AND authFileId = " + fileAuth.getAuthFileId();
		}
		return jdbctemplate.query(sql, new FileAuthRowMapper());
	}

	@Override
	public int deleteFileAuth(FileAuth fileAuth) {
		String sql = "delete from file_auth where 1=1";
		if (fileAuth.getUserId() > 0) {
			sql += " AND userId = " + fileAuth.getUserId();
		}
		if (fileAuth.getAuthUserId() > 0) {
			sql += " AND authUserId = " + fileAuth.getAuthUserId();
		}
		if (fileAuth.getAuthFileId() > 0) {
			sql += " AND authFileId = " + fileAuth.getAuthFileId();
		}
		return jdbctemplate.update(sql);
	}

}

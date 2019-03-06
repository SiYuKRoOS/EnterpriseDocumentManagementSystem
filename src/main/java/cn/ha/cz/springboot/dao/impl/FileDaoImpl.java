package cn.ha.cz.springboot.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.dao.IFileDao;

@Repository
public class FileDaoImpl implements IFileDao {

	@Autowired
	JdbcTemplate jdbctemplate;
	
	private String orderBy(){
		return " ORDER BY a.uploadtime";
	}

	//查询自己上传的文件
	@Override
	public List<FileBean> queryFileList(int userId) {
		// TODO Auto-generated method stub

		String sql = "SELECT a.* , c.username, c.id AS user_id" 
				+ " FROM FILE a "
				+ " JOIN user_file b ON (a.id = b.fileId)" 
				+ " JOIN USER c ON (b.userId = c.id)" 
				+ " WHERE b.userId =  "+ userId 
				+ " AND flag=1";
		
		String folderSQL = sql+ " AND a.filetype = "+EnumFileType.FOLFER.getId() + orderBy();
		String fileSQL   = sql+ " AND a.filetype != "  +EnumFileType.FOLFER.getId() + orderBy();
		
		List<FileBean> all =new ArrayList<>();
		
		List<FileBean> folderList = jdbctemplate.query(folderSQL, new FileAndUserRowMapper());
		List<FileBean> fileList = jdbctemplate.query(fileSQL, new FileAndUserRowMapper());
		
		all.addAll(folderList);
		all.addAll(fileList);
		
		//List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());

		return all;
	}

	@Override
	public List<FileBean> queryFileAll() {
		String sql = "SELECT a.* , c.username, c.id AS user_id" 
				+ " FROM FILE a "
				+ " JOIN user_file b ON (a.id = b.fileId)" 
				+ " JOIN USER c ON (b.userId = c.id)" 
				+ " WHERE flag=1";
			
		String folderSQL = sql+ " AND a.filetype = "+EnumFileType.FOLFER.getId() + orderBy();
		String fileSQL   = sql+ " AND a.filetype != "  +EnumFileType.FOLFER.getId() + orderBy();
		
		List<FileBean> all =new ArrayList<>();
		
		List<FileBean> folderList = jdbctemplate.query(folderSQL, new FileAndUserRowMapper());
		List<FileBean> fileList = jdbctemplate.query(fileSQL, new FileAndUserRowMapper());
		
		all.addAll(folderList);
		all.addAll(fileList);
				
		//List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());

		return all;
	}

	@Override
	public List<FileBean> searchFileList(Integer userId, String filename, int filetype, Integer parentId) {
		String sql = "SELECT a.* , c.username, c.id AS user_id" 
				+ " FROM FILE a JOIN user_file b ON (a.id = b.fileId)" 
				+ " JOIN USER c ON (b.userId = c.id)"
				+ " where 1=1 and flag=1";

		if (userId != null) {
			sql += " AND b.userId = " + userId;
		}

		if (filename != null && !"".equals(filename)) {
			sql += " AND filename like '%" + filename + "%'";
		}

		if (filetype != -1) {
			sql += " AND filetype = " + filetype;
		}
		
		if(parentId!=null && parentId > 0){
			sql += " AND parentid = " + parentId;
		}
		
		
		String folderSQL = sql+ " AND a.filetype = "+EnumFileType.FOLFER.getId() + orderBy();
		String fileSQL   = sql+ " AND a.filetype != "  +EnumFileType.FOLFER.getId() + orderBy();
		
		List<FileBean> all =new ArrayList<>();
		List<FileBean> folderList = jdbctemplate.query(folderSQL, new FileAndUserRowMapper());
		List<FileBean> fileList = jdbctemplate.query(fileSQL, new FileAndUserRowMapper());
		
		all.addAll(folderList);
		all.addAll(fileList);

		//sql += " ORDER BY a.uploadtime";
		//List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());
		return all;
	}

	@Override
	public int insertFile(final FileBean fileBean) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbctemplate.update(new PreparedStatementCreator() {
			String sql = "insert into file(filename, remark, filepath, fullpath, filetype, flag, uploadtime, filesize, parentid, userId)"
					+ "   values (?,?,?,?,?,?,?,?,?,?)";

			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
				PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, fileBean.getFilename());
				ps.setString(2, fileBean.getRemark());
				ps.setString(3, fileBean.getFilepath());
				ps.setString(4, fileBean.getFullpath());
				ps.setInt(5, fileBean.getFiletype().getId());
				ps.setInt(6, fileBean.getFlag());
				ps.setTimestamp(7, new Timestamp(fileBean.getUploadtime().getTime()));// java.util.Date转java.sql.Date
				ps.setString(8, fileBean.getFilesize());
				ps.setInt(9, fileBean.getParentid()==null?0:fileBean.getParentid());
				ps.setInt(10, fileBean.getUserId());
				return ps;
			}
		}, keyHolder);

		return keyHolder.getKey().intValue();
	}

	@Override
	public int insertUserFile(int userId, int fileId) {
		String sql = "insert into user_file values(?,?)";
		return jdbctemplate.update(sql, new Integer[] { userId, fileId });
	}

	@Override
	public FileBean queryById(int fileId) {
		String sql = "select * from file where id = " + fileId;
		List<FileBean> list = jdbctemplate.query(sql, new FileRowMapper());
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public int updateFile(FileBean fileBean) {
		// TODO Auto-generated method stub
		String sql = "update file set flag=?, filepath=?, fullpath=? where id=?";

		return jdbctemplate.update(sql,
				new Object[] { fileBean.getFlag(), fileBean.getFilepath(), fileBean.getFullpath(), fileBean.getId() });
	}
	
	@Override
	public int updateName(FileBean fileBean) {
		// TODO Auto-generated method stub
		String sql = "update file set remark=? where id=?";

		return jdbctemplate.update(sql,
				new Object[] { fileBean.getRemark(), fileBean.getId() });
	}

	@Override
	public int count(Integer... userId) {
		String sql = " SELECT count(*)" + " FROM FILE a " 
				+ " JOIN user_file b ON (a.id = b.fileId)"
				+ " JOIN USER c ON (b.userId = c.id)" 
				+ " WHERE 1=1 AND flag=1";

		if (userId != null && userId.length == 1) {
			sql += " AND b.userId = " + userId[0];
		}

		return jdbctemplate.queryForObject(sql, Integer.class);

	}

	@Override
	public List<FileBean> searchFileListByFolder(int folderId) {
		List<FileBean> all = new ArrayList<>();
		
		String orderBy = " order by uploadtime";
		
		//文件夹优先
		String sql = "select * from file where parentid = " + folderId +" and flag=1 and filetype=" + EnumFileType.FOLFER.getId() + orderBy;
		List<FileBean> folderList = jdbctemplate.query(sql, new FileRowMapper());
		all.addAll(folderList);
		
		// TODO Auto-generated method stub
		sql = "select * from file where parentid = " + folderId +" and flag=1 and filetype!=" + EnumFileType.FOLFER.getId() + orderBy;
		List<FileBean> fileList = jdbctemplate.query(sql, new FileRowMapper());
		all.addAll(fileList);
		
		
		return all;
	}

	@Override
	public List<FileBean> searchFileListByFolder(FileBean params) {
		List<FileBean> all = new ArrayList<>();
		
		String orderBy = " order by uploadtime";
		
		String baseSQL = "select a.*, b.id as user_id, b.username from file a join user b on (a.userId = b.id) where 1=1 and a.flag=1 ";
		if(!StringUtils.isEmpty(params.getFilename())){
			baseSQL += " and filename like '%"+params.getFilename() +"%'";
		}
		
		if(!StringUtils.isEmpty(params.getFiletype())){
			baseSQL += " and filetype = "+ params.getFiletype().getId();
		}
		
		if(params.getParentid()>0){
			baseSQL += " and parentid = "+ params.getParentid();
		}
		
		//文件夹优先
		String folderSql = baseSQL + " and filetype=" + EnumFileType.FOLFER.getId() + orderBy;
		List<FileBean> folderList = jdbctemplate.query(folderSql, new FileAndUserRowMapper());
		all.addAll(folderList);
		
		String fileSql = baseSQL +" and filetype!=" + EnumFileType.FOLFER.getId() + orderBy;
		List<FileBean> fileList = jdbctemplate.query(fileSql, new FileAndUserRowMapper());
		all.addAll(fileList);
		
		return all;
	}

}

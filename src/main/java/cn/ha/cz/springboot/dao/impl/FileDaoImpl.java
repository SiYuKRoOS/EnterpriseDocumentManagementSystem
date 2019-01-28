package cn.ha.cz.springboot.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.dao.IFileDao;

@Repository
public class FileDaoImpl implements IFileDao {

	@Autowired
	JdbcTemplate jdbctemplate;

	@Override
	public List<FileBean> queryFileList(int userId) {
		// TODO Auto-generated method stub

		String sql = "SELECT a.* , c.username, c.id AS user_id" + " FROM FILE a "
				+ " JOIN user_file b ON (a.id = b.fileId)" + " JOIN USER c ON (b.userId = c.id)" + " WHERE b.userId =  "
				+ userId + " AND flag=1 ORDER BY a.uploadtime desc";
		List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());

		return list;
	}

	@Override
	public List<FileBean> queryFileAll() {
		String sql = "SELECT a.* , c.username, c.id AS user_id" + " FROM FILE a "
				+ " JOIN user_file b ON (a.id = b.fileId)" 
				+ " JOIN USER c ON (b.userId = c.id)" 
				+ " WHERE flag=1"
				+ " ORDER BY a.uploadtime desc";
		List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());

		return list;
	}

	@Override
	public List<FileBean> searchFileList(Integer userId, String filename, int filetype) {
		String sql = "SELECT a.* , c.username, c.id AS user_id" + " FROM FILE a "
				+ " JOIN user_file b ON (a.id = b.fileId)" + " JOIN USER c ON (b.userId = c.id)"
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

		sql += " ORDER BY a.uploadtime desc";
		List<FileBean> list = jdbctemplate.query(sql, new FileAndUserRowMapper());
		return list;
	}

	@Override
	public int insertFile(final FileBean fileBean) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbctemplate.update(new PreparedStatementCreator() {
			String sql = "insert into file(filename, remark, filepath, fullpath, filetype, flag, uploadtime, filesize)"
					+ "   values (?,?,?,?,?,?,?,?)";

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
	public int count(Integer... userId) {
		String sql = " SELECT count(*)" + " FROM FILE a " + " JOIN user_file b ON (a.id = b.fileId)"
				+ " JOIN USER c ON (b.userId = c.id)" + " WHERE 1=1 AND flag=1";

		if (userId != null && userId.length == 1) {
			sql += " AND b.userId = " + userId[0];
		}

		return jdbctemplate.queryForObject(sql, Integer.class);

	}

}

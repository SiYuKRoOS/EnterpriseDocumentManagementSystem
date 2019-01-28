package cn.ha.cz.springboot.dao.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IUserDao;

@Repository
public class UserDaoImpl implements IUserDao {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	JdbcTemplate jdbcTemplate;

	@Override
	public UserBean queryUser(int id) {
		String sql = "select * from user where id = ?";
		logger.info(sql.replaceAll("//?", id+""));
		UserBean user = jdbcTemplate.queryForObject(sql, new Object[] { id }, new UserRowMapper());
		return user;
	}

	@Override
	public int insertUser(UserBean u) {
		String sql = "insert into user(username, password, phone, status, level) values(?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql,
				new Object[] { u.getUsername(), u.getPassword(), u.getPhone(), u.getStatusEnum().getId(), u.getLevelEnum().getId() });
	}

	@Override
	public int updateUser(UserBean u) {
		String sql = "update user set username=?, password=?, phone=?, status=?, level=? where id = ?";
		return jdbcTemplate.update(sql,
				new Object[] { u.getUsername(), u.getPassword(), u.getPhone(), u.getStatusEnum().getId(), u.getLevelEnum().getId(), u.getId() });
	}
	
	@Override
	public int updatePwd(String password, int userId) {
		String sql = "update user set password=? where id = ?";
		return jdbcTemplate.update(sql,
				new Object[] { password, userId });
	}


	@Override
	public List<UserBean> queryUserList() {
		String sql = "select * from user where level!=1";
		List<UserBean> list = jdbcTemplate.query(sql, new UserRowMapper());
		return list;
	}
	
	@Override
	public int queryUserByName(String name, Integer userId) {
		String sql = "select count(*) from user where 1=1 ";
		
		if(name!=null) {
			sql += " and username = '"+name+"'";
		}
		if(userId!=null) {
			sql += " and id != "+userId;
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public UserBean queryUser(String name, String pwd) {
		String sql = "select * from user where username = ? and password = ?";
		List<UserBean> list = jdbcTemplate.query(sql, new Object[] { name, pwd }, new UserRowMapper());
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<UserBean> searchUserList(UserBean user) {
		String sql = "select * from user where 1=1 and level!=1";
		if(user.getId()>0) {
			sql += " and id = "+user.getId();
		}
		if(!StringUtils.isEmpty(user.getUsername())) {
			sql += " and username like '%"+user.getUsername() +"%'";
		}
		if(!StringUtils.isEmpty(user.getPhone())) {
			sql += " and phone like '%"+user.getPhone() +"%'";
		}
		List<UserBean> list = jdbcTemplate.query(sql, new UserRowMapper());
		return list;
	}

	@Override
	public int deleteUser(int userId) {
		String sql= "delete from user where id = "+userId;
		return jdbcTemplate.update(sql);
	}

}

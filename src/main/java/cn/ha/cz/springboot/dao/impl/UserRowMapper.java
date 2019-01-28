package cn.ha.cz.springboot.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.bean.EnumUserLevel;
import cn.ha.cz.springboot.bean.EnumUserStatus;

public class UserRowMapper implements RowMapper<UserBean> {

	@Override
	public UserBean mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserBean user = new UserBean();
		user.setId(rs.getInt("id"));
		user.setUsername(rs.getString("username"));
		user.setPassword(rs.getString("password"));
		user.setPhone(rs.getString("phone"));
		user.setStatusEnum(EnumUserStatus.getById(rs.getInt("status")));
		user.setLevelEnum(EnumUserLevel.getById(rs.getInt("level")));
		return user;
	}

}

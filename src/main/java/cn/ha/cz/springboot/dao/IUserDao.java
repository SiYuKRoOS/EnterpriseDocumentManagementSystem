package cn.ha.cz.springboot.dao;

import java.util.List;

import cn.ha.cz.springboot.bean.UserBean;

public interface IUserDao {

	UserBean queryUser(int id);
	
	UserBean queryUser(String name, String pwd);
	
	int queryUserByName(String name, Integer userId);

	List<UserBean> queryUserList();

	int insertUser(UserBean userBean);

	int updateUser(UserBean userBean);
	
	List<UserBean> searchUserList(UserBean user);
	
	int deleteUser(int userId);
	
	int updatePwd(String password, int userId);
}

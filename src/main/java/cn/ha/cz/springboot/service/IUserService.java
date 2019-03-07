package cn.ha.cz.springboot.service;

import java.util.List;

import cn.ha.cz.springboot.bean.UserBean;

public interface IUserService {
	
	List<UserBean> queryAuthUserList(int fileId);
	
}

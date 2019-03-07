package cn.ha.cz.springboot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IFileAuthDao;
import cn.ha.cz.springboot.dao.IUserDao;
import cn.ha.cz.springboot.service.IUserService;

@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	IUserDao userDao;
	
	@Autowired
	IFileAuthDao fileAuthDao;
	
	@Override
	public List<UserBean> queryAuthUserList(int fileId) {
		List<UserBean> userlist =  userDao.queryUserList();
		
		FileAuth params = new FileAuth();
		params.setAuthFileId(fileId);
		
		List<FileAuth> autList = fileAuthDao.queryAuthFileList(params);
		label:
		for(UserBean u: userlist) {
			for(FileAuth auth: autList) {
				if(auth.getAuthUserId()==u.getId()) {
					u.setIschecked(true);
					continue label;
				}
			}
		}
		return userlist;
	}

}

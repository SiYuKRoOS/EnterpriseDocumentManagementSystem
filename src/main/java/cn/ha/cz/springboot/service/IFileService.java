package cn.ha.cz.springboot.service;

import java.util.List;

import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.bean.UserBean;

public interface IFileService {	
	List<FileBean> queryFileList(UserBean user);
	
	List<FileBean> searchFileList(UserBean user, String filename, int filetype, Integer parentId);
	
	void uploadFile(FileBean uploadFile, UserBean uploadUser);
	
	List<FileBean> queryAuthFileList(FileAuth param);
}

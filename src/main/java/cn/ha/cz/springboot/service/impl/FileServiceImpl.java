package cn.ha.cz.springboot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IFileAuthDao;
import cn.ha.cz.springboot.dao.IFileDao;
import cn.ha.cz.springboot.service.IFileService;

@Service
public class FileServiceImpl implements IFileService {

	@Autowired
	IFileDao fileDao;
	
	@Autowired
	IFileAuthDao fileAuthDao;

	public List<FileBean> queryFileList(UserBean user) {
		List<FileBean> filelist = null;
		// 如果是普通员工，只能看自己的
		// && user.getLevelEnum() == EnumUserLevel.GENERAL
		if (user != null) {
			filelist = fileDao.queryFileList(user.getId());
		} else {
			filelist = fileDao.queryFileAll();
		}
		return filelist;
	}

	@Override
	public List<FileBean> searchFileList(UserBean user, String filename, int filetype) {
		// 如果是普通员工，只能看自己的
		// && user.getLevelEnum() == EnumUserLevel.GENERAL
		if (user != null) {
			return fileDao.searchFileList(user.getId(), filename, filetype);
		} else {
			return fileDao.searchFileList(null, filename, filetype);
		}
	}

	@Override
	public void uploadFile(FileBean uploadFile, UserBean uploadUser) {
		int fileId = fileDao.insertFile(uploadFile);
		int userId = uploadUser.getId();
		fileDao.insertUserFile(userId, fileId);
	}

	@Override
	public List<FileBean> queryAuthFileList(FileAuth param) {
		return fileAuthDao.queryFileList(param);
	}
}

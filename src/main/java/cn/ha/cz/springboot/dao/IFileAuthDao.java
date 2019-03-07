package cn.ha.cz.springboot.dao;

import java.util.List;

import cn.ha.cz.springboot.bean.FileAuth;
import cn.ha.cz.springboot.bean.FileBean;

public interface IFileAuthDao {
	
	/**  */
	List<FileAuth> queryAuthFileList(FileAuth param);

	/** 查看有权限的文件列表 */
	List<FileBean> queryFileList(FileAuth param);
	
	/**批量插入*/
	int[] insertFileAuth(List<FileAuth> authlist);
	
	/**删除该文件的分享的用户*/
	int deleteFileAuth(FileAuth fileAuth);
}

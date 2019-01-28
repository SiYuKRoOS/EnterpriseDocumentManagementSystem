package cn.ha.cz.springboot.dao;

import java.util.List;

import cn.ha.cz.springboot.bean.FileBean;

public interface IFileDao {

	/** 根据主键查找文件 */
	FileBean queryById(int fileId);

	/** 查找用户上传的文件 */
	List<FileBean> queryFileList(int userId);

	/** 查找全部文件 */
	List<FileBean> queryFileAll();

	/** 文件查找接口 */
	List<FileBean> searchFileList(Integer userId, String filename, int filetype);

	/** 插入文件信息并返回主键ID */
	int insertFile(FileBean fileBean);

	/** 根据主键删除文件:逻辑删除，修改状态为2 */
	int updateFile(FileBean fileBean);

	/** 插入用户上传文件关系表 */
	int insertUserFile(int userId, int fileId);

	int count(Integer... userId);
	
}

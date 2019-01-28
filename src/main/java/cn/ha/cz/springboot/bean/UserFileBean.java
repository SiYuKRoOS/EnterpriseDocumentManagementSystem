package cn.ha.cz.springboot.bean;

/**
 * 用户文件权限
 * 
 * @author Administrator
 *
 */
public class UserFileBean {
	int userId;
	int fileId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

}

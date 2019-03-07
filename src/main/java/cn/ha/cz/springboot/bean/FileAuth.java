package cn.ha.cz.springboot.bean;

public class FileAuth {

	int userId;
	int authFileId;
	int authUserId;
	
	String filename;
	int filetype;
	
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getFiletype() {
		return filetype;
	}
	public void setFiletype(int filetype) {
		this.filetype = filetype;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getAuthFileId() {
		return authFileId;
	}
	public void setAuthFileId(int authFileId) {
		this.authFileId = authFileId;
	}
	public int getAuthUserId() {
		return authUserId;
	}
	public void setAuthUserId(int authUserId) {
		this.authUserId = authUserId;
	}
	
	
}

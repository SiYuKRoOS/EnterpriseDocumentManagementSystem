package cn.ha.cz.springboot.bean;

import java.util.Date;

/**
 * 用户操作记录
 * 
 * @author Administrator
 *
 */
public class UserRecordBean {

	int fileId;
	String fileName;
	String filePath;
	String userId;
	String userName;

	EnumUserOperation operationEnum;
	Date recordTime;

	public EnumUserOperation getOperationEnum() {
		return operationEnum;
	}

	public void setOperationEnum(EnumUserOperation operationEnum) {
		this.operationEnum = operationEnum;
	}

	public Date getRecordTime() {
		return recordTime;
	}

	public void setRecordTime(Date recordTime) {
		this.recordTime = recordTime;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}

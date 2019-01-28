package cn.ha.cz.springboot.bean;

import java.util.Date;

/**
 * 上传文件
 * @author Administrator
 *
 */
public class FileBean {

	int id;
	String filename;
	String filepath;
	String fullpath;
	String qiniuUrl;
	int flag;
	String remark;
	EnumFileType filetype;
	Date uploadtime;
	
	String username;
	int userId ;
	
	String filesize;

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}

	public EnumFileType getFiletype() {
		return filetype;
	}

	public void setFiletype(EnumFileType filetype) {
		this.filetype = filetype;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getFullpath() {
		return fullpath;
	}

	public void setFullpath(String fullpath) {
		this.fullpath = fullpath;
	}

	public String getQiniuUrl() {
		return qiniuUrl;
	}

	public void setQiniuUrl(String qiniuUrl) {
		this.qiniuUrl = qiniuUrl;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "FileBean [id=" + id + ", filename=" + filename + ", filepath=" + filepath + ", fullpath=" + fullpath
				+ ", qiniuUrl=" + qiniuUrl + ", flag=" + flag + ", remark=" + remark + ", filetype=" + filetype
				+ ", uploadtime=" + uploadtime + ", username=" + username + ", userId=" + userId + "]";
	}

}

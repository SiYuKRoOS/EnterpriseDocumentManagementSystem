package cn.ha.cz.springboot.bean;

import java.util.Date;

/**
 * 上传文件
 * 
 * @author Administrator
 *
 */
public class FileBean {

	Integer id;
	String filename;
	String filepath;
	String fullpath;
	String qiniuUrl;
	Integer flag;
	String remark;
	EnumFileType filetype;
	Date uploadtime;
	Integer parentid;

	String username;
	Integer userId;

	String filesize;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
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

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public EnumFileType getFiletype() {
		return filetype;
	}

	public void setFiletype(EnumFileType filetype) {
		this.filetype = filetype;
	}

	public Date getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(Date uploadtime) {
		this.uploadtime = uploadtime;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	@Override
	public String toString() {
		return "FileBean [id=" + id + ", filename=" + filename + ", filepath="
				+ filepath + ", fullpath=" + fullpath + ", qiniuUrl="
				+ qiniuUrl + ", flag=" + flag + ", remark=" + remark
				+ ", filetype=" + filetype + ", uploadtime=" + uploadtime
				+ ", parentid=" + parentid + ", username=" + username
				+ ", userId=" + userId + ", filesize=" + filesize + "]";
	}

}

package cn.ha.cz.springboot.bean.vo;

import cn.ha.cz.springboot.bean.EnumUserLevel;
import cn.ha.cz.springboot.bean.EnumUserStatus;

public class UserVo {

	int id;
	String username;
	String password;
	String phone;
	int status;
	int level;
	
	EnumUserStatus statusEnum;
	EnumUserLevel levelEnum;
	
	boolean isChecked;
	
	
	public boolean isChecked() {
		return isChecked;
	}
	public void setChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}
	public EnumUserStatus getStatusEnum() {
		return statusEnum;
	}
	public void setStatusEnum(EnumUserStatus statusEnum) {
		this.statusEnum = statusEnum;
	}
	public EnumUserLevel getLevelEnum() {
		return levelEnum;
	}
	public void setLevelEnum(EnumUserLevel levelEnum) {
		this.levelEnum = levelEnum;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	@Override
	public String toString() {
		return "UserVo [id=" + id + ", username=" + username + ", password=" + password + ", phone=" + phone
				+ ", status=" + status + ", level=" + level + "]";
	}
	
	
}

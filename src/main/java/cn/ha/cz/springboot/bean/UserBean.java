package cn.ha.cz.springboot.bean;

/**
 * 用户信息
 * 
 * @author Administrator
 *
 */
public class UserBean {

	int id;
	String username;
	String password;
	String phone;
	EnumUserStatus statusEnum;
	EnumUserLevel levelEnum;
	
	boolean ischecked;
	
	public boolean isIschecked() {
		return ischecked;
	}

	public void setIschecked(boolean ischecked) {
		this.ischecked = ischecked;
	}

	public EnumUserLevel getLevelEnum() {
		return levelEnum;
	}

	public void setLevelEnum(EnumUserLevel levelEnum) {
		this.levelEnum = levelEnum;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public EnumUserStatus getStatusEnum() {
		return statusEnum;
	}

	public void setStatusEnum(EnumUserStatus statusEnum) {
		this.statusEnum = statusEnum;
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

	@Override
	public String toString() {
		return "UserBean [id=" + id + ", username=" + username + ", password=" + password + ", phone=" + phone
				+ ", statusEnum=" + statusEnum + ", levelEnum=" + levelEnum + ", ischecked=" + ischecked + "]";
	}

	
}

package cn.ha.cz.springboot.bean;

public enum EnumUserStatus {
	NORMAL(1,  "正常"), INVALID(0, "无效");
	
	int id;
	String name;
	
	EnumUserStatus(int id, String name){
		this.id = id;
		this.name = name;
	}
	
	public static EnumUserStatus getById(int id) {
		for(EnumUserStatus status: EnumUserStatus.values()) {
			if(status.getId()==id) {
				return status;
			}
		}
		return null;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}

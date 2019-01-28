package cn.ha.cz.springboot.bean;

public enum EnumUserLevel {

	SUPERADMIN(1, "超级管理员"), ADMIN(2, "系统管理员"), GENERAL(3, "普通员工");
	
	int id ;
	String name;
	EnumUserLevel(int id, String name){
		this.id = id;
		this.name = name;
	}
	
	public static EnumUserLevel getById(int id) {
		for(EnumUserLevel e: EnumUserLevel.values()) {
			if(e.getId()==id) {
				return e;
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

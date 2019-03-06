package cn.ha.cz.springboot.bean;

/**
 * 用户操作
 * 
 * @author Administrator
 *
 */
public enum EnumUserOperation {

	UPLOAD(1, "上传"), DOWNLOAD(2, "下载"), DELETE(3, "删除");

	int id;
	String name;

	EnumUserOperation(int id, String name) {
		this.id = id;
		this.name = name;
	}

	public static EnumUserOperation getById(int id) {
		for (EnumUserOperation status : EnumUserOperation.values()) {
			if (status.getId() == id) {
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

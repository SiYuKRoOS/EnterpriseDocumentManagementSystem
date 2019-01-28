package cn.ha.cz.springboot.bean;

public enum EnumFileType {
	EXCEL(1, "EXCEL"), WORD(2, "WORD"), PPT(3, "PPT"), PDF(4, "PDF"), PIC(5, "PIC"), ZIP(6, "ZIP"), OTHRER(10, "其他");

	int id;
	String name;

	EnumFileType(int id, String name) {
		this.id = id;
		this.name = name;
	}

	public static EnumFileType getBySuffix(String suffix) {
		EnumFileType fileType = null;
		String zipReg = "^zip|rar|7z|tar|bz2|cab|jar$";
		String picReg = "^jpg|bmp|png|psd|jpeg$";

		if ("word".equalsIgnoreCase(suffix)) {
			fileType = EnumFileType.WORD;
		} else if ("ppt".equalsIgnoreCase(suffix)) {
			fileType = EnumFileType.PPT;
		} else if ("xls".equalsIgnoreCase(suffix) || "xlsx".equalsIgnoreCase(suffix)) {
			fileType = EnumFileType.EXCEL;
		} else if ("pdf".equalsIgnoreCase(suffix)) {
			fileType = EnumFileType.PDF;
		} else if (suffix.matches(picReg)) {
			fileType = EnumFileType.PIC;
		} else if (suffix.matches(zipReg)) {
			fileType = EnumFileType.ZIP;
		} else {
			fileType = EnumFileType.OTHRER;
		}

		return fileType;
	}

	public static EnumFileType getById(int id) {
		for (EnumFileType e : EnumFileType.values()) {
			if (e.getId() == id) {
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

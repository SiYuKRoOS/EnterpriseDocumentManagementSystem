package cn.ha.cz.springboot.bean.vo;

import cn.ha.cz.springboot.bean.EnumUserLevel;
import cn.ha.cz.springboot.bean.EnumUserStatus;
import cn.ha.cz.springboot.bean.UserBean;

public class UserVoToPo {
	
	public static UserBean toUserBean(UserVo vo) {
		UserBean user = new UserBean();
		user.setId(vo.id);
		user.setUsername(vo.getUsername());
		user.setPhone(vo.getPhone());
		user.setPassword(vo.password);
		user.setStatusEnum(EnumUserStatus.getById(vo.getStatus()));
		user.setLevelEnum(EnumUserLevel.getById(vo.getLevel()));
		return user;
	}
	
	public static UserVo toUserVo(UserBean userBean) {
		UserVo vod = new UserVo();
		vod.setId(userBean.getId());
		vod.setUsername(userBean.getUsername());
		vod.setPhone(userBean.getPhone());
		vod.setStatusEnum(userBean.getStatusEnum());
		vod.setLevelEnum(userBean.getLevelEnum());
		return vod;
	}
}

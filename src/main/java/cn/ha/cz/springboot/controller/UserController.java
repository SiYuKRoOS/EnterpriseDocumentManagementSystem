package cn.ha.cz.springboot.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.ha.cz.springboot.bean.EnumUserLevel;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.bean.vo.UserVo;
import cn.ha.cz.springboot.bean.vo.UserVoToPo;
import cn.ha.cz.springboot.dao.IUserDao;

@Controller
@RequestMapping("/user")
public class UserController {
	Logger Logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	IUserDao userDao;
	
	@ModelAttribute
	public void init(HttpSession session, Model model) {
		EnumUserLevel[] values = EnumUserLevel.values();
		List<EnumUserLevel> list = new ArrayList<>();
		for(EnumUserLevel userLevel: values) {
			if(userLevel != EnumUserLevel.SUPERADMIN) {
				list.add(userLevel);
			}
		}
		model.addAttribute("levelEnums", list);
	}
	
	@RequestMapping("list")
	public ModelAndView list() {
		ModelAndView mv = new ModelAndView();

		List<UserBean> userlist = userDao.queryUserList();

		mv.addObject("userlist", userlist);
		mv.setViewName("userlist");

		return mv;
	}

	@RequestMapping("search")
	public ModelAndView search(@RequestParam String username, @RequestParam String phone,
			Model model) {
		ModelAndView mv = new ModelAndView();

		UserBean user = new UserBean();
		user.setUsername(username);
		user.setPhone(phone);
		List<UserBean> userlist = userDao.searchUserList(user);

		mv.addObject("userlist", userlist);
		mv.setViewName("userlist");
		
		model.addAttribute("username", username);
		model.addAttribute("phone", phone);

		return mv;
	}
	
	@RequestMapping("toAddUser")
	public String toAddUser(HttpSession session, Model model) {
		
		return "useradd";
	}
	
	@RequestMapping("toEditUser")
	public String toEditUser(@RequestParam int userId, HttpSession session, Model model) {
		UserBean edituser = userDao.queryUser(userId);
		model.addAttribute("edituser", edituser);
		return "useredit";
	}
	
	@RequestMapping("toEditPwd")
	public String toEditPwd(HttpSession session, Model model) {
		return "userpwd";
	}
	
	@RequestMapping("editUser")
	public String editUser(UserVo userVo, HttpSession session, Model model) {
		Logger.info("===>editUser params:{}", userVo);
		int count = userDao.queryUserByName(userVo.getUsername(), userVo.getId());
		
		if(count>0) {
			model.addAttribute("success", 2);//重名
		}else {
			UserBean userBean = UserVoToPo.toUserBean(userVo);
			int updateUser = userDao.updateUser(userBean);
			model.addAttribute("success", updateUser);
		}
		
		model.addAttribute("edituser", userDao.queryUser(userVo.getId()));
		return "useredit";
	}
	
	@RequestMapping("addUser")
	public String addUser(HttpSession session, Model model, UserVo userVo) {
		Logger.info("===>addUser params:{}", userVo);
		
		int count = userDao.queryUserByName(userVo.getUsername(), null);
		if(count>0) {
			model.addAttribute("success", 2);//重名
		}else {
			UserBean userBean = UserVoToPo.toUserBean(userVo);
			userBean.setPassword("123456");
			userDao.insertUser(userBean);
			model.addAttribute("success", 1);
		}
		return "useradd";
	}
	
	@RequestMapping("editPwd")
	public String editPwd(@RequestParam String password, @RequestParam String newPassword, HttpSession session, Model model) {
		Logger.info("===>editPwd params:{},{}", password, newPassword);
		
		UserBean userBean = (UserBean) session.getAttribute("user");
		int flag = 1;
		if("".equals(password.trim()) || "".equals(newPassword.trim())) {
			flag = 2;
		}else if(!password.equals(newPassword)) {
			flag = 3;
		} else {
			flag = userDao.updatePwd(newPassword, userBean.getId());
		}
		
		model.addAttribute("success", flag);
		return "userpwd";
	}
	

	@RequestMapping("/delete")
	@ResponseBody
	public int delete(@RequestParam int userId, HttpSession session) {
		Logger.info("===>delete params:{}", userId);
		
		UserBean user = (UserBean)session.getAttribute("user");
		//自己不能删除自己
		if(user!=null && user.getId()==userId) {
			return 2;
		}
		//普通员工没有权限
		if(user!=null && user.getLevelEnum() == EnumUserLevel.GENERAL) {
			return 3;
		}
		return userDao.deleteUser(userId);
	}
}

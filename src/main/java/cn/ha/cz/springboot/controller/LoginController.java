package cn.ha.cz.springboot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.ha.cz.springboot.bean.EnumUserStatus;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IUserDao;

@Controller
@RequestMapping("/login")
public class LoginController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private IUserDao userDao;

	@RequestMapping
	public String login(HttpSession session) {
		if(session.getAttribute("user")!=null) {
			return "redirect:/file/downloadlist";
		}
		return "login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("/tologin")
	public String tologin(HttpSession session) {
		session.invalidate();
		return "login";
	}

	@RequestMapping("/dologin")
	public String login(@RequestParam String username, @RequestParam String password, HttpSession session,
			HttpServletRequest request) {
		logger.info("===>dologin params: {}, {} ", username, password);
		
		UserBean user = userDao.queryUser(username, password);
		if (user == null) {
			request.setAttribute("error", "用户名或密码错误");
			return "login";
		}
		
		if(user.getStatusEnum() == EnumUserStatus.INVALID) {
			request.setAttribute("error", "账户已经被禁用");
			return "login";
		}
		
		//session.setAttribute("isMobile", PCUtils.JudgeIsMoblie(request));
		session.setAttribute("user", user);
		return "redirect:/";
	}
	
}

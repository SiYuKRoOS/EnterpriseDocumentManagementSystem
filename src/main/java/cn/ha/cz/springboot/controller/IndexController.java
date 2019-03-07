package cn.ha.cz.springboot.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.EnumUserLevel;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.service.IFileService;

@Controller
@RequestMapping("/")
public class IndexController {
	
	@Autowired
	IFileService fileService;

	@ModelAttribute
	public void init(HttpSession session, Model model) {
		UserBean user = (UserBean)session.getAttribute("user");
		model.addAttribute("filelist", fileService.queryFileList(user));
		
		model.addAttribute("typeEnums", EnumFileType.values());
		model.addAttribute("from", "download");
	}
	
	@RequestMapping
	public String toIndex(HttpSession session) {
		UserBean userBean = (UserBean) session.getAttribute("user");
		if(userBean.getLevelEnum()==EnumUserLevel.GENERAL){
			return "redirect:/file/downloadlist";
		}
		return "redirect:/file/uploadlist";
	}
	
}

package cn.ha.cz.springboot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/error")
public class ErrController implements ErrorController{

	private static final Logger logger = LoggerFactory
			.getLogger(ErrController.class);

	@Override
	public String getErrorPath() {
		return "redirect:/404.jsp";
	}

	@RequestMapping
	public String error(HttpSession session, HttpServletRequest request) {
		logger.error("出错啦！进入自定义错误控制器:{}", request.getRequestURI());
		return getErrorPath();
	}
}

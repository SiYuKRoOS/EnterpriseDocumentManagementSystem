package cn.ha.cz.springboot.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.util.PCUtils;

public class LoginInterceptor implements HandlerInterceptor {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		boolean judgeIsMoblie = false;
		// 检查每个到来的请求对应的session域中是否有登录标识
		UserBean userBean = (UserBean) request.getSession().getAttribute("user");
		if (null == userBean || !(userBean instanceof UserBean)) {
			logger.info("URI: "+request.getRequestURI()+", 用户未登陆...跳转登录页...");
			// 未登录，重定向到登录页
			response.sendRedirect(request.getContextPath()+"/login");
			
			return false;
		}
		
		judgeIsMoblie = PCUtils.JudgeIsMoblie(request);
		request.getSession().setAttribute("isMobile", judgeIsMoblie);
		
		logger.info("===>URI={}, 用户:{} {}端登录 ", request.getRequestURI(),userBean.getUsername(),judgeIsMoblie?"Mobile":"PC" );
		return true;

	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

}

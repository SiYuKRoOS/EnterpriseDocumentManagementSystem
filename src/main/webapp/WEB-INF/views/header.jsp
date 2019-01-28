<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.tpl-header-navbar a{
		padding: 0 8px;
	}
</style>	
<header>
	<!-- logo -->
	<div class="am-fl tpl-header-logo">
<!-- 		<a href="javascript:;"><img -->
<%-- 			src="<%=request.getContextPath()%>/static/assets1/img/logo.png" --%>
<!-- 			alt=""></a> -->
		<div class="am-text-xl am-text-middle" style="color: #FFF;padding: 10px">在线文档管理系统</div>
		
	</div>
	<!-- 右侧内容 -->
	<div class="tpl-header-fluid">
		<!-- 侧边切换 -->
		<div class="am-fl tpl-header-switch-button am-icon-list">
			<span></span>
		</div>

		<!-- 其它功能-->
		<div class="am-fr tpl-header-navbar">
			<ul>
				<!-- 欢迎语 -->
				<li class="am-text-sm">
					<a href="javascript:;">欢迎你, <span>${user.username }</span></a>
					
				</li>
				<li class="am-text-sm">
					<a href="<%=request.getContextPath()%>/user/toEditPwd">
						 |&nbsp;修改密码
					</a>
				</li>
				<!-- 退出 -->
				<li class="am-text-sm">
					<a href="<%=request.getContextPath()%>/login/logout">
						|&nbsp;<span class="am-icon-sign-out"></span> 退出
					</a>
				</li>
			</ul>
		</div>
	</div>
</header>
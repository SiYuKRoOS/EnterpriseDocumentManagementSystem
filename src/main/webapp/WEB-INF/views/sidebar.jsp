<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<div class="left-sidebar " style="width: 180px;">
	<ul class="sidebar-nav">
		<li class="sidebar-nav-heading"><span
			class="sidebar-nav-heading-info"
			style="font-size: 16px; padding-left: 0">
			
			<span class="am-icon-home am-icon-sm">&nbsp;菜单管理</span> 
		</span></li>
		<!-- 手机端隐藏 -->
		<c:if test="${!sessionScope.isMobile}">
			<c:if test="${sessionScope.user.levelEnum.id < 3}">
			<li class="sidebar-nav-link"><a
				href="<%=request.getContextPath()%>/user/list"> <i
					class="am-icon-users sidebar-nav-link-logo"></i> 人员管理
			</a></li>
			</c:if>
		</c:if>
		<c:if test="${sessionScope.user.levelEnum.id < 3}">
		<li class="sidebar-nav-link">
			<a href="<%=request.getContextPath()%>/file/uploadlist"> <i
				class="am-icon-folder sidebar-nav-link-logo"></i> 我的文档
		</a>
		</li>
		</c:if>
		<li class="sidebar-nav-link">
			<a href="<%=request.getContextPath()%>/file/downloadlist"> <i
				class="am-icon-download sidebar-nav-link-logo"></i> 文档下载
		</a></li>
	</ul>
</div>
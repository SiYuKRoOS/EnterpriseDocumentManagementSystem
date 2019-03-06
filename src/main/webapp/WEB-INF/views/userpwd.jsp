<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>在线文档管理系统</title>
<meta name="description" content="在线文档管理系统">
<meta name="keywords" content="在线文档管理系统">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/assets1/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<script src="<%=request.getContextPath()%>/static/assets1/js/echarts.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>

<style>
.am-form-group {
	padding-top: 10px;
}
</style>
<script type="text/javascript">
	
</script>
</head>

<body>
<body data-type="widgets">
	<script src="<%=request.getContextPath()%>/static/assets1/js/theme.js"></script>

	<div class="am-g tpl-g">
		<!-- 头部 -->
		<jsp:include page="header.jsp" />

		<!-- 侧边导航栏 -->
		<jsp:include page="sidebar.jsp" />

		<!-- 内容区域 -->
		<div class="tpl-content-wrapper">
			<div class="row-content am-cf">
				<div class="row">
					<div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
						<div class="widget am-cf">
							<div class="widget-head am-cf">
								<div class="widget-title am-fl">修改密码</div>
								<div class="widget-function am-fr">
									<a href="javascript:;" class="am-icon-cog"></a>
								</div>
							</div>
							<div class="widget-body am-fr">

								<form action="<%=request.getContextPath()%>/user/editPwd" method="post" class="am-form tpl-form-border-form tpl-form-border-br">
									<div class="am-form-group">
										<label class="am-u-sm-3 am-form-label"> 新密码：</label>
										<div class="am-u-sm-9">
											<input type="password" class="am-form-field tpl-form-no-bg" name="password" required value="${edituser.password }" placeholder="请输入新密码 ">
										</div>
									</div>
									<div class="am-form-group">
										<label class="am-u-sm-3 am-form-label"> 重复新密码：</label>
										<div class="am-u-sm-9">
											<input type="password" class="am-form-field tpl-form-no-bg" name="newPassword" required placeholder="请输入新密码 ">
										</div>
									</div>
									<div class="am-form-group">
										<div class="am-u-sm-9 am-u-sm-push-3">
											<button type="submit" class="am-btn am-btn-primary tpl-btn-bg-color-success">
												<i class="am-icon-save">&nbsp;提交</i>
											</button>

											<a href="<%=request.getContextPath()%>/" class="am-btn tpl-btn-bg-color-success">
												<i class="am-icon-history">&nbsp;返回</i>
											</a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.datatables.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/dataTables.responsive.min.js"></script>
	<script src="<%request.getContextPath())%>/static/assets1/js/app.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			var success = '${success}'

			if (success != '') {
				if (success == '1') {
					alert("修密码成功，请重新登录 ");
				} else if (success == '2') {
					alert("密码不能为空");
				} else if (success == '3') {
					alert("两次密码不一致，请重新输入");
				} else {
					alert("修改密码失败");
				}
			}
		}
	</script>
</body>
</html>
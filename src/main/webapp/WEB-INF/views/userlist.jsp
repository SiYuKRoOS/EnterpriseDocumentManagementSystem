<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>在线文档管理系统</title>
<meta name="description" content="首页">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"/> -->
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/static/assets1/i/favicon.png">
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="南京环正" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script
	src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>

</head>

<body data-type="widgets">
	<script src="<%=request.getContextPath()%>/static/assets1/js/theme.js"></script>
	<div class="am-g tpl-g">
		<!-- 头部 -->
		<jsp:include page="header.jsp" />

		<!-- 风格切换 -->
		<!--  -->

		<!-- 侧边导航栏 -->
		<jsp:include page="sidebar.jsp" />

		<!-- 内容区域 -->
		<div class="tpl-content-wrapper">
			<div class="row-content am-cf" style="">
				<div class="row">
					<div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
						<div class="widget am-cf theme-black"
							style="border: none; background: none;">
							<div class="widget-head am-cf" style="padding: 0">
								<div class="widget-title am-cf">
									人员管理
									<div class="am-form-group am-fr">
										<div class="am-btn-toolbar">
											<div class="am-btn-group am-btn-group-xs">
												<a href="<%=request.getContextPath()%>/user/toAddUser"
													class="am-btn am-btn-default am-btn-success"> <span
													class="am-icon-plus"></span> 添加人员
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="widget-body am-u-sm-12">
								<form action="<%=request.getContextPath()%>/user/search"
									method="post">

									<div class="am-u-sm-12 am-u-md-6 am-u-lg-4" style="">
										<div
											class="am-form-group am-input-group-sm tpl-form-border-form cl-p">
											<label class="am-u-md-4 am-form-label">用户名：</label>
											<div class="am-u-md-8">
												<input type="text" placeholder="姓名" name="username"
													value="${username}">
											</div>
										</div>
									</div>
									<div class="am-u-sm-12 am-u-md-6 am-u-lg-4" style="">
										<div
											class="am-form-group am-input-group-sm tpl-form-border-form cl-p">
											<label class="am-u-md-4 am-form-label">手机号：</label>
											<div class="am-u-md-8">
												<input type="text" placeholder="手机号" name="phone"
													value="${phone}">
											</div>
										</div>
									</div>
									<div class="am-u-sm-12 am-u-md-6 am-u-lg-4" style="padding: 0">
										<div
											class="am-input-group am-input-group-sm tpl-form-border-form cl-p">
											<span class="am-input-group-btn">
												<button
													class="am-btn  am-btn-default am-btn-success tpl-table-list-field am-icon-search"
													type="submit"></button>
											</span>
										</div>
									</div>
								</form>



								<div class="am-u-sm-12" style="margin-top: 20px;">
									<table width="100%"
										class="am-table am-table-compact tpl-table-black tpl-am-table-hover"
										id="example-r">
										<thead>
											<tr>
												<th>序号</th>
												<th>用户名</th>
												<th>手机号</th>
												<th>角色</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${not empty userlist }">
												<c:forEach items="${userlist }" var="user" varStatus="s">
													<tr>
														<td>${s.index+1}</td>
														<td>${user.username}</td>
														<td>${user.phone}</td>
														<td>${user.levelEnum.name}</td>
														<td>
															<div class="tpl-table-black-operation">
																<a href="<%=request.getContextPath()%>/user/toEditUser?userId=${user.id}"> 
																	<i class="am-icon-pencil"></i>编辑
																</a>
																<!-- 超级管理员 -->
																<c:if test="${sessionScope.user.levelEnum.id==1}">
																	<a href="javascript:;" onclick="deleteUser(${user.id},'${user.username }')"
																		class="tpl-table-black-operation-del"> <i
																		class="am-icon-trash"></i> 删除
																	</a>
																</c:if>
																<!-- 系统管理员 
																<c:if
																	test="${sessionScope.user.levelEnum.id==2 and sessionScope.user.id != user.id }">
																	<a href="javascript:;" onclick="deleteUser(${user.id},'${user.username }')"
																		class="tpl-table-black-operation-del"> <i
																		class="am-icon-trash"></i> 删除
																	</a>
																</c:if>
																-->
															</div>
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${empty userlist }">
												<tr>
													<td colspan="5">没有数据</td>
												</tr>
											</c:if>
											<!-- more data -->
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script
		src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/app.js"></script>
	<script type="text/javascript">
	
		function deleteUser(userId, userName){
			if(confirm('是否确认删除该用户？\n'+userName)){
				$.ajax({
					url : "<%=request.getContextPath()%>/user/delete",
					type : 'POST',
					data : {userId:userId},
					success : function(data) {
						window.location.reload();
						if (1 == data) {
							alert("删除成功");
						} else if(1 == data ){
							alert("无法删除自己");
						}else if(2==data){
							alert("您没有权限");
						}else{
							alert("删除失败");
						}
					}
				});
			}
		}
	</script>
</body>
</html>
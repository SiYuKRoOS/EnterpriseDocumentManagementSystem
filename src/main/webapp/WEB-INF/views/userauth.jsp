<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/assets1/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="南京环正" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>
</head>

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
								<div class="widget-title am-fl">文件授权</div>
								<div class="widget-function am-fr">
									<div class="am-btn-group am-btn-group-xs">
										<a href="javascript:;" id="userAuthBtn" class="am-btn am-btn-default am-btn-success" style="color: #fff">
											<span class="am-icon-save"></span>
											保存
										</a>
									</div>
									<div class="am-btn-group am-btn-group-xs">
										<a href="<%=request.getContextPath() %>/file/uploadlist" class="am-btn tpl-btn-bg-color-success">
											<i class="am-icon-history">&nbsp;返回</i>
										</a>
									</div>
								</div>
							</div>
							<div class="widget-body am-fr">
								<form action="<%=request.getContextPath()%>/user/search" method="post">
									<div class="am-u-sm-12 am-u-md-6 am-u-lg-6" style="">
										<div class="am-form-group am-input-group-sm tpl-form-border-form cl-p">
											文件名：${file.remark}
											<input type="hidden" value="${file.id}" id="hiddeFileID">
										</div>
									</div>
								</form>

								<div class="am-u-sm-12">
									<table width="100%" class="am-table am-table-compact tpl-table-black tpl-am-table-hover" id="example-r">
										<thead>
											<tr>
												<th>
													<input type="checkbox" class="checkAll">
												</th>
												<th>用户名</th>
												<th>手机号</th>
												<th>角色</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${not empty userlist }">
												<c:forEach items="${userlist }" var="user" varStatus="s">
													<tr>
														<td>
															<input type="checkbox" class="checkOne" value="${user.id}" ${user.ischecked?'checked':''}>
														</td>
														<td>${user.username}</td>
														<td>${user.phone}</td>
														<td>${user.levelEnum.name}</td>
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
    <jsp:include page="footer.jsp" />
	<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/app.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".checkAll").click(function(){
				if($(this).prop("checked")){
					$(".checkOne").prop("checked",true);
				}else{
					$(".checkOne").prop("checked",false);
				}
			})
			
			$(".checkOne").click(function(){
				$(".checkOne").each(function(){
	                if($(this).prop("checked") == false){
	                    allChecked = false;
	                }
	            });
	            if(allChecked){
	                $(".checkAll").prop("checked",true);
	            } else {
	                $(".checkAll").prop("checked",false);
	            }
			})
			
			$("#userAuthBtn").click(function(){
				
				var authAjax = function(userIds){
					$.ajax({
						url : "<%=request.getContextPath()%>/file/authUser",
						type : 'POST',
						//它的含义是是否使用传统的方式浅层序列化
						traditional : true,
						data : {
							userIds : userIds,
							fileId : $("#hiddeFileID").val()
						},
						success : function(data) {
							if (1 == data) {
								alert("授权成功");
							} else {
								alert("授权失败");
							}
						}
					});
				}
				var userIds = [];
				$(".checkOne:checked").each(function(i) {
					userIds[i] = $(this).val();
				});
				console.log("userIds: "+ userIds);
				if(userIds.length==0){
					//alert("请选择人员");
					if(confirm("未选择人员，是否确认提交 ?")){
						authAjax(userIds);
					}
				}else{
					authAjax(userIds);
				}
			})
		})
	</script>
</body>
</html>
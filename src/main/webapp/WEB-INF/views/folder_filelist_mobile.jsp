<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.ha.cz.springboot.bean.EnumFileType"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>在线文档管理系统</title>
<meta name="description" content="刘维">
<meta name="keywords" content="在线文档">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" />
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/assets1/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="南京环正" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>

<style type="text/css">
.am-table>tbody>tr>td, .am-table>tbody>tr>th, .am-table>tfoot>tr>td,
	.am-table>tfoot>tr>th, .am-table>thead>tr>td, .am-table>thead>tr>th {
	border-top: 1px dotted #ddd;
	color: #cfcfcf;
}

.theme-black .tpl-table-black-operation a.tpl-table-black-operation-del,
	.theme-black .tpl-table-black-operation a {
	border: none;
	font-size: 16px;
}
</style>
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
		<div class="tpl-content-wrapper active">
			<div class="row-content am-cf" style="padding: 8px">
				<div class="row">
					<div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
						<div class="widget am-cf">
							<div class="widget-head am-cf">
								<div class="am-fl">
									<!-- 
									<c:if test="${from == 'download' }">文档下载 (${count })</c:if>
									<c:if test="${from == 'upload' }">我的文档 (${count })</c:if>
									 -->
									<c:if test="${parentid!=null and parentid>0 }">
										<a href="<%=request.getContextPath() %>/folder/viewFolder?folderId=${parentid}&from=${from}">
											<i class="am-icon-reply"></i>
										</a>
									</c:if>
									<c:if test="${parentid!=null and parentid==0 and from =='upload'}">
										<a href="<%=request.getContextPath()%>/file/uploadlist">
											<i class="am-icon-reply"></i>
										</a>
									</c:if>
									<c:if test="${parentid!=null and parentid==0 and from =='download'}">
										<a href="<%=request.getContextPath()%>/file/downloadlist">
											<i class="am-icon-reply"></i>
										</a>
									</c:if>
									/${folder.filename }
								</div>
								<c:if test="${from == 'upload' }">
									<div class="widget-function am-fr">
										<button type="button" class="am-btn am-btn-default am-btn-success am-btn-xs" id="uploadBtn">
											<span class="am-icon-plus"></span>
											文档上传
										</button>
									</div>
								</c:if>
								<form id="fileUploadForm" enctype='multipart/form-data'>
									<input id="fileUpload" type="file" name="file" multiplename="file" multiple style="display: none;" />
									<input type="hidden" name="folderId" value="${folder.id}">
								</form>
								<script type="text/javascript">
									$(function() {
									    $('#uploadBtn').click(function(){
									        $('#fileUpload').click();
									    });

										var uploading = false;
										var imgFile = []; //存放文件
										$("#fileUpload").on("change", function() {
											if (uploading) {
												alert("文件正在上传中，请稍候");
												return false;
											}
											
											$.ajax({
												url : "<%=request.getContextPath()%>/file/upload",
												type : 'POST',
												data : new FormData($('#fileUploadForm')[0]), //单文件
												//data: formData, //多文件
												
												processData : false,
												contentType : false,
												beforeSend : function() {
													uploading = true;
												},
												success : function(data) {
													if ("1" == data) {
														alert("上传成功");
													} else {
														alert("上传失败");
													}
						
													uploading = false;
													window.location.reload();
												}
											});
										});
									});
								</script>

								<c:if test="${from == 'download' }">
									<div class="am-u-sm-6" style="float: right;">
										<form action="<%=request.getContextPath() %>/file/search?from=${from}" method="post">
											<div class="am-input-group am-input-group-sm tpl-form-border-form cl-p">
												<input type="text" class="am-form-field" name="filename" value="${filename}">
												<input type="hidden" name="folderId" value="${folder.id}">
												<span class="am-input-group-btn">
													<button class="am-btn am-btn-default am-btn-success tpl-table-list-field am-icon-search" type="submit">
												</span>
											</div>
										</form>
									</div>
								</c:if>
							</div>
							<div class="widget-body  widget-body-lg am-fr" style="padding: 0px 8px">
								<table width="100%" class="am-table am-table-compact" style="table-layout: fixed; word-wrap: break-word;">
									<tbody>
										<c:if test="${not empty filelist }">
											<c:forEach items="${filelist}" var="file" varStatus="s">
												<tr>
													<td class="am-text-middle" width="40">
														<span class="am-badge am-round"> ${s.index+1 } </span>
													</td>
													<td class="am-text-middle">
														<c:choose>
															<c:when test="${file.filetype == EnumFileType.FOLFER }">
																<a href="<%=request.getContextPath() %>/folder/viewFolder?folderId=${file.id}&from=${from}">${file.remark }</a>
															</c:when>
															<c:otherwise>
																<a href="<%=request.getContextPath() %>${file.filepath}" title="点击下载${file.filename }">${file.filename }</a>
															</c:otherwise>
														</c:choose>
													</td>
													<td width="80" class="am-text-middle" style="text-align: center">
														<label> ${file.username } </label>
														<span style="color: #999; font-size: 10px; display: block;">
															<fmt:formatDate value="${file.uploadtime}" pattern="yyyy-MM-dd" />
														</span>
													</td>
													<td width="80" class="am-text-middle" style="text-align: center">
														<div class="tpl-table-black-operation">
															<c:if test="${from == 'upload' and file.filetype != EnumFileType.FOLFER}">
																<a href="javascript:;" onclick="confirmDel(${file.id},'${file.filename }')" class="tpl-table-black-operation-del">
																	<i class="am-icon-trash"></i>
																	删除
																</a>
															</c:if>
															<c:if test="${from == 'download' and sessionScope.user.levelEnum.id ==1 }">
																<a href="javascript:;" onclick="confirmDel(${file.id},'${file.filename }')" class="tpl-table-black-operation-del">
																	<i class="am-icon-trash"></i>
																	删除
																</a>
															</c:if>

															<c:choose>
																<c:when test="${file.filetype == EnumFileType.FOLFER }">
																	<a href="<%=request.getContextPath() %>/folder/viewFolder?folderId=${file.id}&from=${from}">
																		<i class="am-icon-folder-open"></i>
																		查看
																	</a>
																</c:when>
																<c:otherwise>
																	<a href="<%=request.getContextPath() %>/file/download?fileId=${file.id}">
																		<i class="am-icon-download"></i>
																		下载
																	</a>
																</c:otherwise>
															</c:choose>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:if>
										<c:if test="${empty filelist }">
											<tr>
												<td colspan="6">没有数据</td>
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
	<script type="text/javascript">
		function confirmDel(fileId, filename){
			if(confirm('是否确认删除此文档？\n'+filename)){
				$.ajax({
					url : "<%=request.getContextPath()%>/file/delete",
					type : 'POST',
					data : {fileId:fileId},
					success : function(data) {
						window.location.reload();
						if (1 == data) {
							alert("删除成功");
						} else if(2 == data){
							alert("该文件夹中有文件，请先删除!");
						} else {
							alert("删除失败");
						}
					}
				});
			}
		}
	</script>

	<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.datatables.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/dataTables.responsive.min.js"></script>
	<script src="<%=request.getContextPath()%>/static/assets1/js/app.js"></script>
</body>
</html>
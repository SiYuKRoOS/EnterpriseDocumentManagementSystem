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
<meta name="description" content="在线文档管理系统">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"/> -->
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/assets1/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="在线文档管理系统" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
// 	$(".am-icon-search").click(function(){
// 		filename = $("#filename").val();
// 		filetype = $("#filetype").val();
// 		alert(filename+","+filetype);
// 	})
})
</script>
<style type="text/css">
.am-form-group:hover {
	cursor: pointer;
}

.tpl-table-black-operation a {
	width: 55px;
}
.tpl-table-black-operation a:HOVER {
 cursor: pointer;
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

    <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
      <div class="am-modal-dialog">
        <div class="am-modal-hd">
          新建文件夹
          <a href="javascript:void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
          <input type="text" class="am-modal-prompt-input" name="newFileName">
        </div>
        <div class="am-modal-footer">
          <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
      </div>
    </div>

    <div class="am-modal am-modal-prompt" tabindex="-1" id="rename-prompt">
      <div class="am-modal-dialog">
        <div class="am-modal-hd">
          文件夹重命名
          <a href="javascript:void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
          <input type="hidden" class="am-modal-prompt-input" id="folderId">
          <input type="text" class="am-modal-prompt-input" id="folderName">
        </div>
        <div class="am-modal-footer">
          <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
      </div>
    </div>

    <!-- 内容区域 -->
    <div class="tpl-content-wrapper">
      <div class="row-content am-cf" style="">
        <div class="row">
          <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
            <div class="widget am-cf theme-black" style="border: none; background: none;">
              <div class="widget-head am-cf" style="padding: 0">
                <div class="widget-title am-cf">
                  <c:if test="${from == 'download' }">文档下载 (${count})
										<div class="am-form-group am-fr">
                      <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">&nbsp;</div>
                      </div>
                    </div>
                  </c:if>
                  <c:if test="${from == 'upload' }">我的文档 (${count})
										<div class="am-form-group am-fr">
                      <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                          <button type="button" class="am-btn am-btn-default am-btn-default am-btn-xs" id="addFolderBtn">
                            <span class="am-icon-folder"></span> 新建文件夹
                          </button>
                        </div>
                        <div class="am-btn-group am-btn-group-xs">
                          <button type="button" class="am-btn am-btn-default am-btn-success am-btn-xs" id="uploadBtn">
                            <span class="am-icon-plus"></span> 文档上传
                          </button>
                        </div>
                      </div>
                    </div>
                  </c:if>
                </div>
                <form id="fileUploadForm" enctype='multipart/form-data'>
                  <input id="fileUpload" type="file" name="file" multiplename="file" multiple style="display: none;" />
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
              </div>
              <form action="<%=request.getContextPath() %>/file/search?from=${from}" method="post">
                <div class="widget-body am-u-sm-12">
                  <div class="am-u-sm-12 am-u-md-6 am-u-lg-3" style="">
                    <div class="am-form-group tpl-table-list-select" style="float: left">
                      <select data-am-selected="{btnSize: 'sm'}" class="am-input-lg" name="filetype">
                        <option value="-1" ${filetype==type.id?'selected':''}>所有类别</option>
                        <c:forEach items="${typeEnums }" var="type">
                          <option value="${type.id }" ${filetype==type.id?'selected':''}>${type.name }</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="am-u-sm-12 am-u-md-6 am-u-lg-3" style="padding: 0">
                    <div class="am-input-group am-input-group-sm tpl-form-border-form cl-p">
                      <input type="text" class="am-form-field" name="filename" value="${filename}">
                      <span class="am-input-group-btn">
                        <button class="am-btn am-btn-default am-btn-success tpl-table-list-field am-icon-search" type="submit"></button>
                      </span>
                    </div>
                  </div>
                  <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">&nbsp;</div>
                  <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">&nbsp;</div>

                  <div class="am-u-sm-12">
                    <table width="100%" class="am-table am-table-compact tpl-table-black ">
                      <thead>
                        <tr>
                          <th>序号</th>
                          <th>文件类型</th>
                          <th>文件名</th>
                          <th>大小</th>
                          <th>创建者</th>
                          <th>上传时间</th>
                          <th>操作</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:if test="${not empty filelist }">
                          <c:forEach items="${filelist}" var="file" varStatus="s">
                            <tr class="gradeX">
                              <td class="am-text-middle">
                                <span class="am-badge  am-round"> ${s.index+1 } </span>
                              </td>
                              <td class="am-text-middle" width="100">
                                <span style="vertical-align: middle;"> <img src="<%=request.getContextPath() %>/static/assets1/img/file${file.filetype.id }.png" class="tpl-table-line-img" alt="${file.filetype.name }"> ${file.filetype.name }
                                </span>
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
                              <td class="am-text-middle">${file.filesize }</td>
                              <td class="am-text-middle">${file.username }</td>
                              <td class="am-text-middle">${file.uploadtime}</td>
                              <td class="am-text-middle">
                                <div class="tpl-table-black-operation">
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

                                  <c:if test="${from == 'upload'}">
                                    <c:if test="${file.filetype == EnumFileType.FOLFER}">
                                    <a data-toggle='modal' data-target='#rename-prompt' onclick="rename(${file.id})" style="width: 68px">
                                      <i class="am-icon-edit"></i>
                                      重命名
                                    </a>
                                    </c:if>
                                    <a href="javascript:;" onclick="confirmDel(${file.id},'${file.remark }')" class="tpl-table-black-operation-del">
                                      <i class="am-icon-trash"></i>
                                      删除
                                    </a>

                                    <!-- 管理员才能分配权限 -->
                                    <c:if test="${sessionScope.user.levelEnum.id < 3 }">
                                      <a href="<%=request.getContextPath() %>/file/toAuthUser?fileId=${file.id}">
                                        <i class="am-icon-share-alt"></i>
                                        权限
                                      </a>
                                    </c:if>
                                  </c:if>
                                  <c:if test="${from == 'download' and sessionScope.user.levelEnum.id ==1 }">
                                    <a href="javascript:;" onclick="confirmDel(${file.id},'${file.remark }')" class="tpl-table-black-operation-del">
                                      <i class="am-icon-trash"></i>
                                      删除
                                    </a>
                                  </c:if>
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
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
  <script type="text/javascript">
	
		$(function(){
			 $('#addFolderBtn').on('click', function() {
			    $('#my-prompt').modal({
				      relatedTarget: this,
				      onConfirm: function(e) {
				    	console.log("folder: "+e.data);
				        $.ajax({
							url : "<%=request.getContextPath()%>/folder/createFolder",
							type : 'POST',
							data : {folderName:e.data},
							success : function(data) {
								alert("新建成功")
								window.location.reload();
								return ;
							}
						});
				      }
			    });
			 });
			 
			 $("#rename-prompt").on("closed.modal.amui", function() {
				 console.log("removeData:amui.modal")
		         $(this).removeData("amui.modal");
		    });
			 
			 //重写confirm事件，默认会重复提交
			 var $confirmBtn = $("#rename-prompt").find('[data-am-modal-confirm]');
			 $confirmBtn.off('click.confirm.modal.amui').on('click', function() {
				console.log("onConfirm: "+$("#folderId").val()+":"+$("#folderName").val());
		        $.ajax({
					url : "<%=request.getContextPath()%>/folder/renameFolder",
					type : 'POST',
					data : {folderId:$("#folderId").val(),folderName:$("#folderName").val()},
					success : function(data) {
						alert("修改成功")
						window.location.reload();
					}
				});
			 });
		})
		
		function rename(folderId){
			 var url = "<%=request.getContextPath()%>/folder/getFolder?folderId="+folderId;
			 //console.log(url);
			 $.ajax({
				url : url,
				type : 'POST',
				success : function(data) {
					$("#folderId").val(data.id);
					$("#folderName").val(data.remark);
					
					$("#rename-prompt").modal();
				}
			})
		}
		
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
  <!--[if (gte IE 9)|!(IE)]><!-->
  <script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>
  <!--<![endif]-->
  <!--[if lte IE 8 ]>
		<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
		<script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.ie8polyfill.min.js"></script>
	<![endif]-->

  <script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
  <script src="<%=request.getContextPath()%>/static/assets1/js/app.js"></script>

</body>
</html>

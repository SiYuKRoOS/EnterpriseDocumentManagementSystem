<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.ha.cz.springboot.bean.EnumFileType"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<jsp:include page="include_head.jsp" />

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
                        <jsp:include page="filelist_body.jsp" />
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
  <jsp:include page="include_footer.jsp" />
  
  <jsp:include page="footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.ha.cz.springboot.bean.EnumFileType"%>
<%@ page import="cn.ha.cz.springboot.bean.EnumUserLevel"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.ha.cz.springboot.bean.EnumFileType"%>
===${param.file.id }

<c:choose>
  <c:when test="${param.file.filetype == EnumFileType.FOLFER }">
    <a href="<%=request.getContextPath() %>/folder/viewFolder?folderId=${param.file.id}&from=${param.from}">${param.file.remark }</a>
  </c:when>
  <c:otherwise>
    <a href="<%=request.getContextPath() %>${param.file.filepath}" title="点击下载${param.file.filename }">${param.file.filename }</a>
  </c:otherwise>
</c:choose>
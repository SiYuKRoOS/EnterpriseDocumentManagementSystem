<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>在线文档管理系统</title>
<meta name="description"
  content="在线文档管理系统>
<meta name="keywords" content="在线文档管理系统">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" >
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/static/assets1/i/favicon.png" />
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath()%>/static/assets1/i/app-icon72x72@2x.png" />
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/amazeui.datatables.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/assets1/css/app.css">
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets1/js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function(){
		 var rem = $.cookie('remember');
         if(rem){
             $("
  #remember-me").prop("checked",true);
             $("#username").val($.cookie("username"));
             $("#password").val($.cookie("password"));
         }
	
		$("#remember-me").click(function(){
			console.log("checked: "+$(this).prop("checked"));
			if($(this).prop("checked")){
               addCookie();
            }else{
               expireCookie();
            }
		})
	})
	
	function
  addCookie(){
		 var username=$( "#username").val();
         var password=$( "#password").val();
         console.log("addCookie: "+username+", "+password);

         $.cookie("remember","true",{expires:7});
         $.cookie("username",username,{expires:7 });
         $.cookie("password",password,{expires:7 });
	}
	
	
	function
  expireCookie(){
		 console.log("expireCookie");
		 $.cookie("remember","false",{expires:-1});
         $.cookie("username","",{ expires:-1 });
         $.cookie("password","",{ expires:-1 });
	}
	
	function rememberMe(){
		var checked=$( "#remember-me").is(":checked");
		if(checked){
			addCookie();
		}
		returntrue;
	}


</script>
</head>
<body data-type="login">
  <script src="<%=request.getContextPath()%>/static/assets1/js/theme.js"></script>
  <div class="am-g tpl-g">
    <div class="tpl-login">
      <div class="tpl-login-content" style="margin: 8% auto 0">
        <div class="tpl-login-logo" style="background-image: url('<%=request.getContextPath()%>/static/assets1/img/login2.png');background-size: 130px"></div>
        <form class="am-form tpl-form-line-form" action="<%=request.getContextPath()%>/login/dologin" method="post" onsubmit="return rememberMe()">
          <div class="am-form-group">
            <input type="text" class="tpl-form-input" name="username" id="username" placeholder="请输入账号" required>
          </div>

          <div class="am-form-group">
            <input type="password" class="tpl-form-input" name="password" id="password" placeholder="请输入密码" required>
          </div>
          <div class="am-form-group tpl-login-remember-me">
            <input id="remember-me" type="checkbox">
            <label for="remember-me">记住密码 </label>
          </div>

          <div class="am-form-group">
            <button type="submit" class="am-btn am-btn-primary  am-btn-block tpl-btn-bg-color-success tpl-login-btn">登录</button>
          </div>
          <div class="am-form-group">
            <span style="color: red; text-align: center;">${error}</span>
          </div>
        </form>
      </div>
    </div>
  </div>

  <style>
<!--
.blog-footer {
	padding: 10px 0;
	text-align: center;
	color: #b5b5b5;
	position: fixed; left : 0px;
	bottom: 0px;
	width: 100%;
	height: 130px;
	left: 0px;
}
-->
-->
</style>
  <footer class="blog-footer">
    <p>
      <br />
      <small>©Copyright 2019. xin-ikea.cn All Rights Reserved</small>
      <br />
      <small> 邮箱：83351061@QQ.COM</small>
      <br />
      <small> 备案号：苏ICP备18048845号 </small>     
    </p>
  </footer>
  <script src="<%=request.getContextPath()%>/static/assets1/js/amazeui.min.js"></script>
  <script src="<%=request.getContextPath()%>/static/assets1/js/app.js"></script>
</body>

</html>
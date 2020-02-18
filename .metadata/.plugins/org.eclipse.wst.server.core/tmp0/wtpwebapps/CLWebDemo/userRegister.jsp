<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>用户注册</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<script src="js/bootstrap.min.js"></script>
		
    <link href="resources/css/jquery-ui-themes.css" type="text/css" rel="stylesheet"/>
    <link href="resources/css/axure_rp_page.css" type="text/css" rel="stylesheet"/>
    <link href="data/styles.css" type="text/css" rel="stylesheet"/>
    <link href="files/用户注册/styles.css" type="text/css" rel="stylesheet"/>
    <script src="resources/scripts/jquery-1.7.1.min.js"></script>
    <script src="resources/scripts/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="resources/scripts/prototypePre.js"></script>
    <script src="data/document.js"></script>
    <script src="resources/scripts/prototypePost.js"></script>
    <script src="files/用户注册/data.js"></script>
    <script type="text/javascript">
      $axure.utils.getTransparentGifPath = function() { return 'resources/images/transparent.gif'; };
      $axure.utils.getOtherPath = function() { return 'resources/Other.html'; };
      $axure.utils.getReloadPath = function() { return 'resources/reload.html'; };
    </script>
    
    <script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function validate()
	{
		var uname = document.getElementById("uname");
		var upwd = document.getElementById("upwd");
	
	if (uname.value=="")
		{
			alert("请填写用户名！");
			uname.focus();
			return false;
		}
	if (upwd.value=="")
		{
			alert("请填写密码！");
			upwd.focus();
			return false;
		}
		return true;
	}
	
	function myregist(){
		var uname = $("#uname").val();
		var upwd = $("#upwd").val();
		
		if(validate()){
			$.ajax({
				//用来跳转的url
				url:"register.do?uname="+uname+"&upwd="+upwd,
				//数据提交方式
				type:"post",
				//返回到页面的数据类型
				datatype:"String",
				//成功后调用的方法
				success:function(result){
					
					if(result == "ok"){
						alert("注册成功");
						location.href="userLogin.jsp";
					}else{
						alert("用户名或密码格式不正确");
						location.href="userRegister.jsp";
					}
				}
			});
		}
	}
</script>

  </head>
  <body>
    <div id="base" class="">

      <!-- Unnamed (矩形) -->
      <div id="u0" class="ax_default box_2">
        <div id="u0_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u1" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u2" class="ax_default shape">
        <div id="u2_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u3" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u4" class="ax_default _形状">
        <div id="u4_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u5" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u6" class="ax_default _二级标题">
        <div id="u6_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u7" class="text">
          <p><span>职业培训网络大学</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u8" class="ax_default shape">
        <div id="u8_div" class="">
        	<center>
        	<div style="width: 500px;">
        		 <form action="register.do" method="post"  class="form-horizontal" style="margin-top: 200px;">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">用户名</label>
				    <div class="col-sm-10">
				      <input type="text" name="uname" id="uname" class="form-control" id="empName_add_input" placeholder="请输入用户名">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">验证码</label>
				    <div class="col-sm-7">
				      <input type="text" class="form-control" id="email_add_input" placeholder="请输入短信验证码">
				      
				      <span class="help-block"></span>
				    </div>
				    <button type="button" class="btn btn-default col-sm-2">获取验证码</button>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">密码</label>
				    <div class="col-sm-10">
				      <input type="password" name="upwd" id="upwd" class="form-control" id="email_add_input" placeholder="请输入密码">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <center style="margin-left: 90px;">
					  <div class="has-success">
						  <div class="checkbox">
						    <label>
						      <input type="checkbox" id="checkboxSuccess" value="option1" checked="checked">
						                我已阅读并同意《职业培训质量提升平台服务协议》
						    </label>
						  </div>
					  </div>
					  <br />
					  </center>
					  <button type="button" onclick="myregist()" class="btn btn-primary">确认注册</button>
					  &nbsp;
					  <a href="homePage.jsp">
			     	  	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					  </a>
					  
			   </form><br /><br />
			   <div>
		        <p class="text-primary">
		        	<a href="userLogin.jsp">
		        		<button type="button" class="btn btn-link">已有账号，去登录</button>
		        	</a>
		        </p>
		      </div>
			   </center>
        	</div>
        </div>
        <!-- Unnamed () -->
        <div id="u9" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u10" class="ax_default heading_1">
        <div id="u10_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u11" class="text"><br /><br /><br />
          <p><span>用户注册</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u12" class="ax_default shape">
        <div id="u12_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u13" class="text">
          <p><span>LO</span></p><p><span>GO</span></p>
        </div>
      </div>
    </div>
    
   
  </body>
</html>

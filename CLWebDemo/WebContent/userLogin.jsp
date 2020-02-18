<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>忘记密码－修改成功</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
    
    <link href="resources/css/jquery-ui-themes.css" type="text/css" rel="stylesheet"/>
    <link href="resources/css/axure_rp_page.css" type="text/css" rel="stylesheet"/>
    <link href="data/styles.css" type="text/css" rel="stylesheet"/>
    <link href="files/忘记密码－修改成功/styles.css" type="text/css" rel="stylesheet"/>
    <script src="resources/scripts/jquery-1.7.1.min.js"></script>
    <script src="resources/scripts/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="resources/scripts/prototypePre.js"></script>
    <script src="data/document.js"></script>
    <script src="resources/scripts/prototypePost.js"></script>
    <script src="files/忘记密码－修改成功/data.js"></script>
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
				alert("请填写登录名！");
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
		
		function mysubmit(){
			var uname = $("#uname").val();
			var upwd = $("#upwd").val();
			
			if(validate()){
				$.ajax({
					//用来跳转的url
					url:"login.do?uname="+uname+"&upwd="+upwd,
					//数据提交方式
					type:"post",
					//返回到页面的数据类型
					datatype:"String",
					//成功后调用的方法
					success:function(result){
						
						if(result == "ok"){
							alert("登录成功");
							location.href="homePageLogged.jsp";
						}else{
							alert("用户名或密码错误");
							location.href="userLogin.jsp";
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
      <div id="u98" class="ax_default box_2">
        <div id="u98_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u99" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u100" class="ax_default shape">
        <div id="u100_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u101" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u102" class="ax_default _形状1">
        <div id="u102_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u103" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u106" class="ax_default shape">
        <div id="u106_div" class="">
        	<center>
      			<div style="width: 500px;">
      				<form action="login.do" method="post" class="form-horizontal" >
      					<h4 style="margin-top: 100px; font-weight: 800;"">用户登录</h4><br /><br /><br />
			  			<ul class="nav nav-tabs" role="tablist">
			    			<li role="presentation" class="active"><a href="#zhlogin" aria-controls="zhlogin" role="tab" data-toggle="tab">账号登录</a></li>
			    			<li role="presentation"><a href="#yzmlogin" aria-controls="yzmlogin" role="tab" data-toggle="tab">验证码登录</a></li>
			  			</ul>

			  			<div class="tab-content">
			    			<div role="tabpanel" class="tab-pane active" id="zhlogin"><br />
			    				<div class="form-group">
			    					<div class="col-sm-offset-2 col-sm-8">
			      						<input name="uname" type="text" class="form-control" id="uname" placeholder="请输入用户名" required="required">
			    					</div>
								</div>
								<div class="form-group">
					    			<div class="col-sm-offset-2 col-sm-8">
					      				<input name="upwd" type="password" class="form-control" id="upwd" placeholder="请输入密码" required="required">
					    			</div>
								</div>
								
								<!-- 用户名的登录 -->
								<div class="form-group">
					    			<div class="col-sm-offset-2 col-sm-8">
					      				<button type="button" onclick="mysubmit()" class="btn btn-primary btn-lg" style="height: auto;width: 323.33px;">登录</button><br /><br />
					      				<a href="userRegister.jsp">
					      					<button type="button" class="btn btn-default btn-lg" style="height: auto;width: 323.33px;">注册</button>
					      				</a>
					    			</div>
								</div>
								
								
								<br>
								<div>
							        <p class="text-primary">
							        	<a href="forgetPwd1.jsp">
							        		<button type="button" class="btn btn-link">忘记密码</button>
							        	</a>
							        </p>
							    </div>		
				    		</div>
				    		<div role="tabpanel" class="tab-pane" id="yzmlogin"><br />
				    			<div class="form-group">
			    					<div class="col-sm-offset-2 col-sm-8">
			      						<input type="text" class="form-control" id="uname" name="uname" placeholder="请输入手机号/账号">
			    					</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-5">
										<input type="password" class="form-control" id="upwd" name="upwd" placeholder="请输入验证码">
									</div>
  									<div class=" col-sm-2">
  										<button class="btn btn-default">获取验证码</button>
  									</div>	
								</div>
								
								<!-- 用验证码的登录 -->
								<div class="form-group">
					    			<div class="col-sm-offset-2 col-sm-8">
					      				<button type="button" onclick="mysubmit()" class="btn btn-primary btn-lg" style="height: auto;width: 323.33px;">登录</button><br /><br />
					      				<a href="userRegister.jsp">
					      					<button type="button" class="btn btn-default btn-lg" style="height: auto;width: 323.33px;">注册</button>
					      				</a>
					    			</div>
								</div>
				    		</div>
				    		
				    	</div>	
					</form>
				</div>
			</center>
        </div>
        <!-- Unnamed () -->
        <div id="u107" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>
      
      <!-- Unnamed (矩形) -->
      <div id="u132" class="ax_default _二级标题">
        <div id="u132_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u133" class="text">
          <p><span>职业培训网络大学</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u134" class="ax_default shape">
        <div id="u134_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u135" class="text">
          <p><span>LO</span></p><p><span>GO</span></p>
        </div>
      </div>
    </div>
  </body>
</html>

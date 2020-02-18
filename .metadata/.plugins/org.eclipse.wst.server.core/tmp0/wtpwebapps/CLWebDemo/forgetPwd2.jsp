<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>忘记密码－修改密码</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
	
    <link href="resources/css/jquery-ui-themes.css" type="text/css" rel="stylesheet"/>
    <link href="resources/css/axure_rp_page.css" type="text/css" rel="stylesheet"/>
    <link href="data/styles.css" type="text/css" rel="stylesheet"/>
    <link href="files/忘记密码－修改密码/styles.css" type="text/css" rel="stylesheet"/>
    <script src="resources/scripts/jquery-1.7.1.min.js"></script>
    <script src="resources/scripts/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="resources/scripts/prototypePre.js"></script>
    <script src="data/document.js"></script>
    <script src="resources/scripts/prototypePost.js"></script>
    <script type="text/javascript">
      $axure.utils.getTransparentGifPath = function() { return 'resources/images/transparent.gif'; };
      $axure.utils.getOtherPath = function() { return 'resources/Other.html'; };
      $axure.utils.getReloadPath = function() { return 'resources/reload.html'; };
    </script>
    
 <script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript">
	function validate()
	{
		var upwd = document.getElementById("upwd");
		var upwd2 = document.getElementById("upwd2");
	
	if (upwd.value=="")
		{
			alert("请填写密码！");
			upwd.focus();
			return false;
		}
	if((upwd.value).length<5||(upwd.value).length>20){
		alert("为了安全起见，您输入的密码长度必须在5~20位之间！");
		userpwd.focus();
		return false;
	}
	if (upwd2.value=="")
    {
    		alert("请确认密码！");
    		userpwd2.focus();
    		return false;
  	}
	if((upwd2.value)!=(upwd.value)){
		alert("您两次输入的密码不一致！");
		userpwd2.focus();
		return false;
	}
		return true;
	}
	
	function changePwd(){
		var uname = $("#uname").val();
		var upwd = $("#upwd").val();
		if(validate()){
			$.ajax({
				//用来跳转的url
				url:"changePwd.do?uname="+uname+"&upwd="+upwd,
				//数据提交方式
				type:"post",
				//返回到页面的数据类型
				datatype:"String",
				//成功后调用的方法
				success:function(result){
					
					if(result == "ok"){
						alert("修改密码成功");
						location.href="forgetPwd3.jsp";
					}else{
						alert("用户名错误,请重新输入！");
						location.href="forgetPwd1.jsp";
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
      <div id="u50" class="ax_default box_2">
        <div id="u50_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u51" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u52" class="ax_default shape">
        <div id="u52_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u53" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u54" class="ax_default _形状1">
        <div id="u54_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u55" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u58" class="ax_default shape">
        <div id="u58_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u59" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u60" class="ax_default heading_1">
        <div id="u60_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u61" class="text">
          <p><span>找回密码</span></p>
        </div>
      </div>

      <!-- Unnamed (水平线) -->
      <div id="u62" class="ax_default horizontal_line">
        <img id="u62_img" class="img " src="images/忘记密码－手机账号/u14.png"/>
        <!-- Unnamed () -->
        <div id="u63" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u64" class="ax_default paragraph">
        <div id="u64_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u65" class="text">
          <p><span>修改密码</span></p>
        </div>
      </div>

      <!-- Unnamed (椭圆形) -->
      <div id="u66" class="ax_default shape">
        <img id="u66_img" class="img " src="images/忘记密码－手机账号/u44.png"/>
        <!-- Unnamed () -->
        <div id="u67" class="text">
          <p><span>2</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u68" class="ax_default paragraph">
        <div id="u68_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u69" class="text">
          <p><span>手机账号</span></p>
        </div>
      </div>

      <!-- Unnamed (椭圆形) -->
      <div id="u70" class="ax_default shape">
        <img id="u70_img" class="img " src="images/忘记密码－手机账号/u20.png"/>
        <!-- Unnamed () -->
        <div id="u71" class="text">
          <p><span>✓</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u72" class="ax_default paragraph">
        <div id="u72_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u73" class="text">
          <p><span>修改成功</span></p>
        </div>
      </div>

      <!-- Unnamed (水平线) -->
      <div id="u74" class="ax_default horizontal_line">
        <img id="u74_img" class="img " src="images/忘记密码－手机账号/u24.png"/>
        <!-- Unnamed () -->
        <div id="u75" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
      </div>

      <!-- Unnamed (椭圆形) -->
      <div id="u76" class="ax_default shape">
        <img id="u76_img" class="img " src="images/忘记密码－手机账号/u20.png"/>
        <!-- Unnamed () -->
        <div id="u77" class="text">
          <p><span>3</span></p>
        </div>
      </div>

<form action="changePwd.do" method="post" >
      <!-- Unnamed (矩形) -->
      <div id="u78" class="ax_default heading_1">
        <div id="u78_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u79" class="text">
          <p><span>新密码</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u80" class="ax_default heading_1">
        <div id="u80_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u81" class="text">
          <p><span>再输一次</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u82" class="ax_default shape">
          <p><span>
			<!-- <input type="button" value="确认新密码" onclick="changePwd()"> -->
			<button type="button" style="width:242px; height:45px" class="btn btn-primary" onclick="changePwd()">确认新密码</button>
		  </span></p>
      </div>

      <!-- Unnamed (组合) -->
      <div id="u84" class="ax_default" data-left="610" data-top="323" data-width="245" data-height="50">

        <!-- border (矩形) -->
        <div id="u85" class="ax_default _形状1" data-label="border">
          <div id="u85_div" class=""></div>
          <!-- Unnamed () -->
          <div id="u86" class="text" style="display:none; visibility: hidden">
            <p><span></span></p>
          </div>
        </div>

        <!-- user_id (文本框) -->
        <div id="u87" class="ax_default _文本框" data-label="user_id">
          <input name="upwd" id="upwd"  type="password" style="width: 240px; height: 45px;" placeholder="请输入新密码" />
          <input type="hidden" name="uname" id="uname" value="<%=request.getParameter("uname")%>">
        </div>
      </div>

      <!-- Unnamed (组合) -->
      <div id="u88" class="ax_default" data-left="613" data-top="395" data-width="242" data-height="50">

        <!-- border (矩形) -->
        <div id="u89" class="ax_default _形状1" data-label="border">
          <div id="u89_div" class=""></div>
          <!-- Unnamed () -->
          <div id="u90" class="text" style="display:none; visibility: hidden">
            <p><span></span></p>
          </div>
        </div>

        <!-- user_pw (文本框) -->
        <div id="u91" class="ax_default _文本框" data-label="user_pw">
          <input name="upwd2" id="upwd2"  type="password" style="width: 240px; height: 45px;" placeholder="请再次输入密码" />
         
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u92" class="ax_default heading_1">
        <div id="u92_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u93" class="text">
          <p><span>(英文字母，符号或数字)</span></p>
        </div>
      </div>
</form>


      <!-- Unnamed (矩形) -->
      <div id="u94" class="ax_default _二级标题">
        <div id="u94_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u95" class="text">
          <p><span>职业培训网络大学</span></p>
        </div>
      </div>

      <!-- Unnamed (矩形) -->
      <div id="u96" class="ax_default shape">
        <div id="u96_div" class=""></div>
        <!-- Unnamed () -->
        <div id="u97" class="text">
          <p><span>LO</span></p><p><span>GO</span></p>
        </div>
      </div>
    </div>
  </body>
</html>

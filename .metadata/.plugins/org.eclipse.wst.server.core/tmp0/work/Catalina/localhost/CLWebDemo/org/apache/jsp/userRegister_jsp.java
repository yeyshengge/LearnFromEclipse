/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.38
 * Generated at: 2019-08-02 02:40:46 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class userRegister_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>用户注册</title>\r\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\r\n");
      out.write("    <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/>\r\n");
      out.write("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\"/>\r\n");
      out.write("    \r\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jquery-3.4.1.min.js\"></script>\r\n");
      out.write("\t\t<link href=\"css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("\t\t<script src=\"js/bootstrap.min.js\"></script>\r\n");
      out.write("\t\t\r\n");
      out.write("    <link href=\"resources/css/jquery-ui-themes.css\" type=\"text/css\" rel=\"stylesheet\"/>\r\n");
      out.write("    <link href=\"resources/css/axure_rp_page.css\" type=\"text/css\" rel=\"stylesheet\"/>\r\n");
      out.write("    <link href=\"data/styles.css\" type=\"text/css\" rel=\"stylesheet\"/>\r\n");
      out.write("    <link href=\"files/用户注册/styles.css\" type=\"text/css\" rel=\"stylesheet\"/>\r\n");
      out.write("    <script src=\"resources/scripts/jquery-1.7.1.min.js\"></script>\r\n");
      out.write("    <script src=\"resources/scripts/jquery-ui-1.8.10.custom.min.js\"></script>\r\n");
      out.write("    <script src=\"resources/scripts/prototypePre.js\"></script>\r\n");
      out.write("    <script src=\"data/document.js\"></script>\r\n");
      out.write("    <script src=\"resources/scripts/prototypePost.js\"></script>\r\n");
      out.write("    <script src=\"files/用户注册/data.js\"></script>\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("      $axure.utils.getTransparentGifPath = function() { return 'resources/images/transparent.gif'; };\r\n");
      out.write("      $axure.utils.getOtherPath = function() { return 'resources/Other.html'; };\r\n");
      out.write("      $axure.utils.getReloadPath = function() { return 'resources/reload.html'; };\r\n");
      out.write("    </script>\r\n");
      out.write("    \r\n");
      out.write("    <script src=\"js/jquery.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\tfunction validate()\r\n");
      out.write("\t{\r\n");
      out.write("\t\tvar uname = document.getElementById(\"uname\");\r\n");
      out.write("\t\tvar upwd = document.getElementById(\"upwd\");\r\n");
      out.write("\t\r\n");
      out.write("\tif (uname.value==\"\")\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\talert(\"请填写用户名！\");\r\n");
      out.write("\t\t\tuname.focus();\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\tif (upwd.value==\"\")\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t\talert(\"请填写密码！\");\r\n");
      out.write("\t\t\tupwd.focus();\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\treturn true;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction myregist(){\r\n");
      out.write("\t\tvar uname = $(\"#uname\").val();\r\n");
      out.write("\t\tvar upwd = $(\"#upwd\").val();\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tif(validate()){\r\n");
      out.write("\t\t\t$.ajax({\r\n");
      out.write("\t\t\t\t//用来跳转的url\r\n");
      out.write("\t\t\t\turl:\"register.do?uname=\"+uname+\"&upwd=\"+upwd,\r\n");
      out.write("\t\t\t\t//数据提交方式\r\n");
      out.write("\t\t\t\ttype:\"post\",\r\n");
      out.write("\t\t\t\t//返回到页面的数据类型\r\n");
      out.write("\t\t\t\tdatatype:\"String\",\r\n");
      out.write("\t\t\t\t//成功后调用的方法\r\n");
      out.write("\t\t\t\tsuccess:function(result){\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\tif(result == \"ok\"){\r\n");
      out.write("\t\t\t\t\t\talert(\"注册成功\");\r\n");
      out.write("\t\t\t\t\t\tlocation.href=\"userLogin.jsp\";\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\talert(\"用户名或密码格式不正确\");\r\n");
      out.write("\t\t\t\t\t\tlocation.href=\"userRegister.jsp\";\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("  </head>\r\n");
      out.write("  <body>\r\n");
      out.write("    <div id=\"base\" class=\"\">\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u0\" class=\"ax_default box_2\">\r\n");
      out.write("        <div id=\"u0_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u1\" class=\"text\" style=\"display:none; visibility: hidden\">\r\n");
      out.write("          <p><span></span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u2\" class=\"ax_default shape\">\r\n");
      out.write("        <div id=\"u2_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u3\" class=\"text\" style=\"display:none; visibility: hidden\">\r\n");
      out.write("          <p><span></span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u4\" class=\"ax_default _形状\">\r\n");
      out.write("        <div id=\"u4_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u5\" class=\"text\" style=\"display:none; visibility: hidden\">\r\n");
      out.write("          <p><span></span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u6\" class=\"ax_default _二级标题\">\r\n");
      out.write("        <div id=\"u6_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u7\" class=\"text\">\r\n");
      out.write("          <p><span>职业培训网络大学</span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u8\" class=\"ax_default shape\">\r\n");
      out.write("        <div id=\"u8_div\" class=\"\">\r\n");
      out.write("        \t<center>\r\n");
      out.write("        \t<div style=\"width: 500px;\">\r\n");
      out.write("        \t\t <form action=\"register.do\" method=\"post\"  class=\"form-horizontal\" style=\"margin-top: 200px;\">\r\n");
      out.write("\t\t\t\t  <div class=\"form-group\">\r\n");
      out.write("\t\t\t\t    <label class=\"col-sm-2 control-label\">用户名</label>\r\n");
      out.write("\t\t\t\t    <div class=\"col-sm-10\">\r\n");
      out.write("\t\t\t\t      <input type=\"text\" name=\"uname\" id=\"uname\" class=\"form-control\" id=\"empName_add_input\" placeholder=\"请输入用户名\">\r\n");
      out.write("\t\t\t\t      <span class=\"help-block\"></span>\r\n");
      out.write("\t\t\t\t    </div>\r\n");
      out.write("\t\t\t\t  </div>\r\n");
      out.write("\t\t\t\t  <div class=\"form-group\">\r\n");
      out.write("\t\t\t\t    <label class=\"col-sm-2 control-label\">验证码</label>\r\n");
      out.write("\t\t\t\t    <div class=\"col-sm-7\">\r\n");
      out.write("\t\t\t\t      <input type=\"text\" class=\"form-control\" id=\"email_add_input\" placeholder=\"请输入短信验证码\">\r\n");
      out.write("\t\t\t\t      \r\n");
      out.write("\t\t\t\t      <span class=\"help-block\"></span>\r\n");
      out.write("\t\t\t\t    </div>\r\n");
      out.write("\t\t\t\t    <button type=\"button\" class=\"btn btn-default col-sm-2\">获取验证码</button>\r\n");
      out.write("\t\t\t\t  </div>\r\n");
      out.write("\t\t\t\t  <div class=\"form-group\">\r\n");
      out.write("\t\t\t\t    <label class=\"col-sm-2 control-label\">密码</label>\r\n");
      out.write("\t\t\t\t    <div class=\"col-sm-10\">\r\n");
      out.write("\t\t\t\t      <input type=\"password\" name=\"upwd\" id=\"upwd\" class=\"form-control\" id=\"email_add_input\" placeholder=\"请输入密码\">\r\n");
      out.write("\t\t\t\t      <span class=\"help-block\"></span>\r\n");
      out.write("\t\t\t\t    </div>\r\n");
      out.write("\t\t\t\t  </div>\r\n");
      out.write("\t\t\t\t  <center style=\"margin-left: 90px;\">\r\n");
      out.write("\t\t\t\t\t  <div class=\"has-success\">\r\n");
      out.write("\t\t\t\t\t\t  <div class=\"checkbox\">\r\n");
      out.write("\t\t\t\t\t\t    <label>\r\n");
      out.write("\t\t\t\t\t\t      <input type=\"checkbox\" id=\"checkboxSuccess\" value=\"option1\" checked=\"checked\">\r\n");
      out.write("\t\t\t\t\t\t                我已阅读并同意《职业培训质量提升平台服务协议》\r\n");
      out.write("\t\t\t\t\t\t    </label>\r\n");
      out.write("\t\t\t\t\t\t  </div>\r\n");
      out.write("\t\t\t\t\t  </div>\r\n");
      out.write("\t\t\t\t\t  <br />\r\n");
      out.write("\t\t\t\t\t  </center>\r\n");
      out.write("\t\t\t\t\t  <button type=\"button\" onclick=\"myregist()\" class=\"btn btn-primary\">确认注册</button>\r\n");
      out.write("\t\t\t\t\t  &nbsp;\r\n");
      out.write("\t\t\t\t\t  <a href=\"homePage.jsp\">\r\n");
      out.write("\t\t\t     \t  \t<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">取消</button>\r\n");
      out.write("\t\t\t\t\t  </a>\r\n");
      out.write("\t\t\t\t\t  \r\n");
      out.write("\t\t\t   </form><br /><br />\r\n");
      out.write("\t\t\t   <div>\r\n");
      out.write("\t\t        <p class=\"text-primary\">\r\n");
      out.write("\t\t        \t<a href=\"userLogin.jsp\">\r\n");
      out.write("\t\t        \t\t<button type=\"button\" class=\"btn btn-link\">已有账号，去登录</button>\r\n");
      out.write("\t\t        \t</a>\r\n");
      out.write("\t\t        </p>\r\n");
      out.write("\t\t      </div>\r\n");
      out.write("\t\t\t   </center>\r\n");
      out.write("        \t</div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u9\" class=\"text\" style=\"display:none; visibility: hidden\">\r\n");
      out.write("          <p><span></span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u10\" class=\"ax_default heading_1\">\r\n");
      out.write("        <div id=\"u10_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u11\" class=\"text\"><br /><br /><br />\r\n");
      out.write("          <p><span>用户注册</span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("\r\n");
      out.write("      <!-- Unnamed (矩形) -->\r\n");
      out.write("      <div id=\"u12\" class=\"ax_default shape\">\r\n");
      out.write("        <div id=\"u12_div\" class=\"\"></div>\r\n");
      out.write("        <!-- Unnamed () -->\r\n");
      out.write("        <div id=\"u13\" class=\"text\">\r\n");
      out.write("          <p><span>LO</span></p><p><span>GO</span></p>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("   \r\n");
      out.write("  </body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

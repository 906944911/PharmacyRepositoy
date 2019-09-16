<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="javax.servlet.http.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="en" class="no-js">
<head>
<meta charset="utf-8">
<title>登陆</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- CSS -->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/supersized.css">
<link rel="stylesheet" href="css/style.css">
<!--加载验证码的css-->




</head>

<body oncontextmenu="return true">

	<div class="page-container">
		<h1>高校药房管理系统</h1>

		<div>
			<input type="text" name="username" class="username" placeholder="用户名"
				id="aname" autocomplete="off" />
		</div>
		<div>
			<input type="password" name="apassword" id="apassword"
				class="password" placeholder="密码" oncontextmenu="return false"
				onpaste="return false" />
		</div>
		<button id="submit" type="button" onclick="submit()">进入</button>



		<!-- Javascript -->
		<script src="http://apps.bdimg.com/libs/jquery/1.6.4/jquery.min.js"
			type="text/javascript"></script>
		<script src="css/supersized.3.2.7.min.js"></script>
		<script src="css/supersized-init.js"></script>
		<!--离开输入密码框验证显示出来-->
		<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
		<script>
			function submit() {
				var u = $("#aname").val();
				var p = $("#apassword").val();
				$.ajax({
					url : 'Servlet?op=login',
					data : {
						"aname" : u,
						"apwd" : p
					},
					dataType : "json",
					type : 'POST',
					success : function(data) {
						if (data.data == 0) {
							alert("用户名或密码错误");
						} else {
							window.location.href = "manage.jsp";
						}

					}
				});

			}
		</script>
</body>
</html>


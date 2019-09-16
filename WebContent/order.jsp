<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单查询</title>
<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	function FmtStatus(value, row, index) {
		var s = "";
		if (value == "否") {
			var data = $("#dealTable").datagrid('getData');
			var sid = data.rows[index]['cid'];
			var url = "Servlet?op=accomplish&cid=" + sid;
			$("#url").val(url);
			s += '<a href="#" onclick="accomplish()" >点击完成进货</a>';
		} else {
			s += "已完成";
		}
		return s;
	}

	function accomplish(){
		var url = $("#url").val();
		$.ajax({
			url : url ,
			dataTpye : 'json',
			type : 'POST',
			success : function(data){
				alert("配药完成");
				$("#dealTable").datagrid("reload");
			}
		});
	}
	
	function FmtDo(value, row, index) {
		var data = $("#dealTable").datagrid('getData');
		var did = data.rows[index]['cid'];
		var url = "Servlet?op=lookOrderDetail&cid=" + did;
		var s = '<a href='+url+' >查看详情</a>';
		return s;
	}

</script>
<!-- JSP 指令 （静态引入） -->
<%@ include file="/easyui/easyuiLink.jsp"%>

</head>
<%
	String path = application.getContextPath();
%>
<body>

	<!-- 
	使用 easyui 的 datagrid 控件，以 AJAX 的方式查询数据 ，
	easyui 控件接收 JSON 格式的数据
-->


	<script type="text/javascript">
		$(function() {
			//创建data_grid
			url = "Servlet?op=queryDeal";
			$("#dealTable").datagrid({
				url : url, //数据来源   
				//列的定义
				columns : [ [ {
					field : 'cid',
					title : '处方编号',
					width : 50,
					align : 'center'
				}, {
					field : 'sickname',
					title : '病人',
					width : 70,
					align : 'center'
				}, {
					field : 'doctorname',
					title : '医生',
					width : 70,
					align : 'center'
				}, {
					field : 'yaojishiname',
					title : '药剂师',
					width : 70,
					align : 'center'
				}, {
					field : 'chufangdate',
					title : '处方日期',
					width : 70,
					align : 'center',
				}, {
					field : 'peiyaodate',
					title : '配药日期',
					width : 120,
					align : 'center',
				}, {
					field : 'ispeiyao',
					title : '是否配药',
					formatter : FmtStatus,
					width : 70,
					align : 'center',
				}, {
					field : 'lookSale',
					title : '查看详情',
					formatter : FmtDo,
					width : 70,
					align : 'center',
				} ] ],


				fitColumns : true,//列自适应宽度，不能和冻结列同时设置为true
				idField : 'cid',//主键列
				//rownumbers : true,//显示行号
				//singleSelect : true,//是否单选
				remoteSort : false,//是否服务器端排序，设成false，才能客户端排序

			});
		})
	</script>
	<div id="tb" style="padding: 5px; height: auto">
		<input type="text"  id="url" style="display: none;">&nbsp;&nbsp;
	</div>
	<table id="dealTable">

	</table>


</body>
</html>

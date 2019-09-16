<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单详情</title>

<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	function fmtAccount(value, row, index) {
		//用来计算总额度
		var totalaccount = $("#totalaccount").html();
		totalaccount = parseFloat(totalaccount);
		var data = $("#commodityTable").datagrid('getData');
		var cpromotionprice = data.rows[index]['price'];
		var buynum = data.rows[index]['num'];
		var account = cpromotionprice * buynum;
		account = parseFloat(account);
		totalaccount += account;
		$("#totalaccount").html(totalaccount);
		return account;
	}

	function cancel() {
		//交易取消，删除buy购物车的东西并返回到buy.jsp
		$.ajax({
			url : "Servlet?op=deleteBuy",
			dataType : "json",
			type : "POST",
			success : function(data) {
				if (data.code == 1) {
					$("#editdelete").dialog('close');
					window.location.href = "buy.jsp";
				} else {
					window.location.href = "buy.jsp";
				}
			}
		});

	}

	function success() {
		var dtotalaccount = $("#totalaccount").html();
		var sickname = $("#sickname").val();
		if (sickname == "" || sickname == null) {
			alert("请输入病人名字");
			return;
		}
		$.ajax({
			url : "Servlet?op=addorder",
			data : {
				"mount" : dtotalaccount,
				"sickname" : sickname
			},
			dataType : "json",
			type : "POST",
			success : function(data) {
				alert(data.data);
				window.location.href = "buy.jsp";
			}
		});
	}

	function openDelete(index) {
		// 打开窗口
		$("#editdelete").dialog('open');
	}
</script>
<!-- JSP 指令 （静态引入） -->
<%@ include file="easyui/easyuiLink.jsp"%>

</head>
<%
	String path = application.getContextPath();
%>
<body>
	<!-- 
	使用 easyui 的 datagrid 控件，以 AJAX 的方式查询数据 ，
	easyui 控   件接收 JSON 格式的数据
-->
	<script type="text/javascript">
		$(function() {
			//创建data_grid
			url = "Servlet?op=querybuy";
			$("#commodityTable").datagrid({
				url : url, //数据来源   
				//冻结列

				//列的定义
				columns : [ [ {
					field : 'yid',
					title : '商品编号',
					width : 70,
					align : 'center'
				}, {
					field : 'yname',
					title : '名称',
					width : 400,
					align : 'center'
				}, {
					field : 'num',
					title : '数量',
					width : 50,
					align : 'center',
				}, {
					field : 'unit',
					title : '计量单位',
					width : 70,
					align : 'center',
				}, {
					field : 'price',
					title : '单价',
					width : 70,
					align : 'center',
				}, {
					field : 'mount',
					title : '总额',
					formatter : fmtAccount,
					width : 70,
					align : 'center',
				} ] ],

				fitColumns : true,//列自适应宽度，不能和冻结列同时设置为true
				//rownumbers : true,//显示行号
				//singleSelect : true,//是否单选
				remoteSort : false,//是否服务器端排序，设成false，才能客户端排序
				toolbar : '#tb'
			});
		})
	</script>


	<table id="commodityTable">

	</table>
	<div align="center">
		病人姓名：<input type="text" id="sickname" style="width: 100px"><br>
		总计：<span id="totalaccount">0</span><br> <input type="button"
			value="交易完成" id="success" onclick="success()"
			style="width: 100px; height: 30px"> <input type="button"
			value="交易取消" id="failure" onclick="openDelete()"
			style="width: 100px; height: 30px">
	</div>

	<div id="editdelete" class="easyui-dialog" title="取消交易"
		style="width: 300px; height: 200px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<table>
			<tr>
				<td align="center">您确定要取消本次交易吗？</td>
			</tr>
			<br>
			<br>
			<tr>
				<td align="right" colspan="3"><a class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" style="width: 100px"
					onclick="cancel()">确定</a> <a class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'" style="width: 100px"
					onclick='$("#editdelete").dialog("close");'>取消</a></td>
			</tr>
		</table>
	</div>

</body>
</html>


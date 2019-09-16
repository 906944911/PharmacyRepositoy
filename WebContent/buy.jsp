<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>药品信息</title>

<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	function fmtDo(value, row, index) {
		var s = '<input type="text" id="'+index+'" value="" style="width: 20px"/>';
		s += '<input type="button" onclick="add(' + index + ')" value="+">';
		s += '<input type="button" onclick="sub(' + index
				+ ')" value="-">&nbsp;&nbsp;';
		return s;
	}

	function add(index) {
		var txt = document.getElementById(index);
		var a = txt.value;
		a++;
		txt.value = a;
	}
	function sub(index) {
		var txt = document.getElementById(index);
		var a = txt.value;
		if (a != 0) {
			a--;
			txt.value = a;
		} else {
			txt.value = 0;
		}
	}
	
	function fmtBuy(value, row, index) {
		return '<input type="button"  onclick="buy(' + index + ')" value="购买">';
	}

	function buy(index) {
		var data = $("#commodityTable").datagrid('getData');
		var kucun = data.rows[index]['ynum'];
		//得到选购数量
		var txt = document.getElementById(index);
		var buynum = txt.value;
		//如果库存小于购买数量则不允许购买
		if(buynum==""){
			alert("所选数量不能为空哦");
			return;
		}
		if(buynum==0){
			alert("所选数量不能为0哦");
			return;
		}
		if (kucun < buynum) {
			alert("库存不足");
			return;
		}
		var yid = data.rows[index]['yid'];
		var cname = data.rows[index]['yname'];
		var cprice = data.rows[index]['yprice'];
		var unit = data.rows[index]['yunit'];
		var url = 'Servlet?op=addbuy';
		$.ajax({
			url : url,
			data : {
				"yid" : yid,
				"yname" : cname,
				"price" : cprice,
				"num" : buynum,
				"unit" : unit,
			},
			dataType : "json",
			type : 'POST',
			success : function(data) {
				alert("已加入购物车")
			}
		});
	}

	
	function conditionSearch() {
		$(function() {
			//创建data_grid
			var cname = $("#cname").val();
			url = "Servlet?op=queryCommodity&yname=" + cname;
			$("#commodityTable").datagrid({
				url : url, //数据来源   
				//冻结列

				//列的定义
				columns : [ [ {
					field : 'yid',
					title : '编号',
					width : 50,
					align : 'center'
				}, {
					field : 'yname',
					title : '名称',
					width : 400,
					align : 'center'
				}, {
					field : 'yunit',
					title : '计量单位',
					width : 70,
					align : 'center',
				}, {
					field : 'ynum',
					title : '库存',
					width : 50,
					align : 'center',
				}, {
					field : 'ystockprice',
					title : '进货价',
					width : 70,
					align : 'center',
				}, {
					field : 'yprice',
					title : '售价',
					width : 70,
					align : 'center',
				}, {
					field : 'update',
					title : '购买数量',
					width : 70,
					formatter : fmtDo,
					align : 'center'
				}, {
					field : 'buy',
					title : '购买',
					formatter : fmtBuy,
					width : 70,
					align : 'center',
				} ] ],

				fitColumns : true,//列自适应宽度，不能和冻结列同时设置为true
				idField : 'yid',//主键列
				//rownumbers : true,//显示行号
				//singleSelect : true,//是否单选
				remoteSort : false,//是否服务器端排序，设成false，才能客户端排序

			});
		})
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
			url = "Servlet?op=queryCommodity";
			$("#commodityTable").datagrid({
				url : url, //数据来源   
				//冻结列

				//列的定义
				columns : [ [ {
					field : 'yid',
					title : '编号',
					width : 50,
					align : 'center'
				}, {
					field : 'yname',
					title : '名称',
					width : 400,
					align : 'center'
				}, {
					field : 'yunit',
					title : '计量单位',
					width : 70,
					align : 'center',
				}, {
					field : 'ynum',
					title : '库存',
					width : 50,
					align : 'center',
				}, {
					field : 'ystockprice',
					title : '进货价',
					width : 70,
					align : 'center',
				}, {
					field : 'yprice',
					title : '售价',
					width : 70,
					align : 'center',
				}, {
					field : 'update',
					title : '购买数量',
					width : 70,
					formatter : fmtDo,
					align : 'center'
				}, {
					field : 'buy',
					title : '购买',
					formatter : fmtBuy,
					width : 70,
					align : 'center',
				} ] ],
				fitColumns : true,//列自适应宽度，不能和冻结列同时设置为true
				idField : 'yid',//主键列
				//rownumbers : true,//显示行号
				//singleSelect : true,//是否单选
				remoteSort : false,//是否服务器端排序，设成false，才能客户端排序

			});
		})
	</script>

	<div id="tb" style="padding: 5px; height: auto">
		<form>
			<input type="text" placeholder="药品名称" name="cname" id="cname">&nbsp;&nbsp;
			<a class="easyui-linkbutton" plain="true" onclick="conditionSearch()">药品查询</a>&nbsp;&nbsp;
			<a class="easyui-linkbutton"  href="buyDetail.jsp" style="height:  30px">去结账</a>
		</form>
	</div>
	<table id="commodityTable">

	</table>


</body>
</html>


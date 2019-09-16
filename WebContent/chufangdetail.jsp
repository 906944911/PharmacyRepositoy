<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>处方详情</title>

<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	function cancel() {
		window.location.href = "order.jsp";
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
	easyui 控   件接收 JSON 格式的数据
-->

	<table id="commodityTable" class="easyui-datagrid" title="订单销售详情"
		data-options="
			fitColumns:true,
			singleSelect:true,
			method:'post',
			toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'yid',width:100,align:'center'">名称</th>
				<th data-options="field:'yname',width:100,align:'center'">名称</th>
				<th data-options="field:'num',width:100,align:'center'">数量</th>
				<th data-options="field:'unit' ,width:100,align:'center'">单位</th>
				<th data-options="field:'price' ,width:100,align:'center'">单价</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${chufangList }" var="cf">
				<tr>
					<td>${cf.yid }</td>
					<td>${cf.yname }</td>
					<td>${cf.num }</td>
					<td>${cf.unit }</td>
					<td>${cf.price }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


	<div align="center">
	<br><br>
		<input type="button" value="返回" id="failure" onclick="cancel()"
			style="width: 100px; height: 30px">
	</div>

</body>
</html>

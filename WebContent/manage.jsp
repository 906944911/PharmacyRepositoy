<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>高校药房管理系统</title>
<%@ include file="/easyui/easyuiLink.jsp"%>

<style type="text/css">
.easyui-linkbutton {
	margin-top: 5px;
	width: 90%;
}
</style>

<script type="text/javascript">
	function addTab(title, href) {

		if ($('#tbs').tabs("exists", title) == false) {
			var contentStr;
			//创建显示内容的子框架（子window）
			if (href) {
				contentStr = '<iframe scrolling="no" frameborder="0"  src="'
						+ href + '" style="width:100%;height:100%;"></iframe>';
			} else {
				contentStr = '无内容';
			}
			//添加标签页
			$('#tbs').tabs("add", {
				title : title,
				closable : true,
				content : contentStr
			});
		} else {
			//选择已经打开的标签页进行刷新
			$('#tbs').tabs('select', title);
		}
	}
</script>

</head>
<body class="easyui-layout">


	<div data-options="region:'north'" style="overflow: hidden;">
		<table style="width: 100%">
			<tr>
				<td width="20px"><img alt="Logo"
					src="easyui/themes/icons/large_chart.png"></td>
				<td>
					<h2 style="margin: 1px; color: #333">高校药房管理系统</h2>
				</td>
				<td align="right" style="padding: 10px 11px"><span>
						${sessionScope.atype}:[${sessionScope.aname}]，欢迎你进入高校药房管理系统！ </span><br>
					&nbsp;&nbsp;<a href="Servlet?op=zhuxiao">退出登陆</a></td>
			</tr>
		</table>
	</div>
	<div class="easyui-accordion" data-options="region:'west',split:true"
		title="收起" style="width: 200px;">
		<div title="药品管理" style="text-align: center">
			<a href="#" class="easyui-linkbutton"
				onclick="addTab(this.innerText,'commodity.jsp')"
				data-options="iconCls:'icon-search'">药品信息</a>
		</div>
		<div title="处方管理" style="text-align: center">
			<a href="#" class="easyui-linkbutton"
				onclick="addTab(this.innerText,'buy.jsp')"
				data-options="iconCls:'icon-print'">开处方</a> <a href="#"
				class="easyui-linkbutton"
				onclick="addTab(this.innerText,'order.jsp')"
				data-options="iconCls:'icon-search'">查看处方</a>
		</div>
		<div title="用户管理" style="text-align: center">
			<a href="#" class="easyui-linkbutton"
				onclick="addTab(this.innerText,'adminLimit.jsp')"
				data-options="iconCls:'icon-search'">用户管理</a>
		</div>
	</div>
	<div id="tbs" class="easyui-tabs"
		data-options="region:'center',iconCls:'icon-ok'">
		<div>管理首页</div>
	</div>

	<div data-options="region:'south'"
		style="text-align: center; padding: 3px">
		<span>版权信息：高校药房管理系统</span>
	</div>
</body>
</html>
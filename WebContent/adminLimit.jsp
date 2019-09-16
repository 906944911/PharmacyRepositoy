<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户查询</title>
<script type="text/javascript" src="jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	function fmtDo(value, row, index) {
		var s = '<a href="#" onclick="openEdit(' + index + ')">重置密码</a>';
		s += "&nbsp;&nbsp;";
		s += '<a href="#" onclick="openDelete(' + index + ')">删除</a>';
		return s;
	}

	function updatesave() {
		var aid = $("#updateaid").val();
		var atype = $("#updateatype").val();
		var atelephone = $("#updateatelephone").val();
		$.ajax({
			url : "Servlet?op=updateAdmin",
			data : {
				"aid" : aid,
				"atype" : atype,
				"atelephone" : atelephone
			},
			dataType : "json",
			type : "POST",
			success : function(data) {
				if (data.code == 1) {
					$("#editUpdate").dialog("close");
					$("#limitTable").datagrid("reload");
				} else {
					alert(data.data);
				}
			}
		});
	}

	function addsave() {
		var aname = $("#addaname").val();
		var atelephone = $("#addatelephone").val();
		var atype = $("#addatype").val();
		$.ajax({
			url : "Servlet?op=addAdmin",
			data : {
				"aname" : aname,
				"atelephone" : atelephone,
				"atype" : atype,
			},
			dataType : "json",
			type : "POST",
			success : function(data) {
				if (data.code == 1) {
					$("#editAdd").dialog("close");
					$("#limitTable").datagrid("reload");
				} else {
					alert(data.data);
				}
			}
		});
	}

	function deleteSure() {
		var aid = $("#aid").val();
		var url = "Servlet?op=deleteAdmin&aid=" + aid;
		$.ajax({
			url : url,
			dataType : "json",
			type : "POST",
			success : function(data) {
				alert(data.data);
				$("#editDelete").dialog("close");
			}
		});
	}

	function openDelete(index) {
		var data = $("#limitTable").datagrid('getData');
		var aid = data.rows[index]['aid'];
		$("#aid").val(aid);
		$("#editDelete").dialog("open");
	}

	function openEdit(index) {
		// 打开窗口

		var data = $("#limitTable").datagrid('getData');
		var aid = data.rows[index]["aid"];
		var url = "Servlet?op=resetPwd&aid=" + aid
		$.ajax({
			url : url,
			dataType : "json",
			type : "POST",
			success : function(data) {
				alert(data.data);
			}
		});

	}

	function conditionSearch() {
		var aname = $("#aname").val();
		var atelephone = $("#atelephone").val();
		var atype = $("#atype").val();
		url = "Servlet?op=queryAdmin&aname=" + aname + "&atelephone="
				+ atelephone + "&atype=" + atype;
		$(function() {
			//创建data_grid
			$("#limitTable").datagrid({
				url : url, //数据来源   
				//冻结列

				//列的定义
				columns : [ [ {
					field : 'aid',
					title : '编号',
					width : 50,
					align : 'center'
				}, {
					field : 'aname',
					title : '姓名',
					width : 70,
					align : 'center'
				}, {
					field : 'atelephone',
					title : '电话',
					width : 100,
					align : 'center'
				}, {
					field : 'atype',
					title : '职位',
					width : 70,
					align : 'center',
				}, {
					field : 'operation',
					title : '操作',
					formatter : fmtDo,
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
	easyui 控件接收 JSON 格式的数据
-->

	<div id="editAdd" class="easyui-dialog" title="添加员工"
		style="width: 600px; height: 400px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<table>
			<tr>
				<td>姓名：</td>
				<td width="250px"><input class="easyui-textbox" id="addaname"
					style="width: 100%"></td>
			</tr>
			<tr>
				<td>电话：</td>
				<td><input class="easyui-textbox" id="addatelephone"
					type="text" style="width: 100%"></td>
			</tr>
			<tr>
				<td>职位：</td>
				<td><input class="easyui-textbox" id="addatype" type="text"
					style="width: 100%"></td>
			</tr>
			<tr>
				<td align="right" colspan="3"><a class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" style="width: 100px"
					onclick="addsave()">保存</a> <a class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'" style="width: 100px"
					onclick='$("#editAdd").dialog("close");'>取消</a></td>
			</tr>
		</table>

	</div>

	<div id="editUpdate" class="easyui-dialog" title="权限分配"
		style="width: 600px; height: 300px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<table>
			<tr>
				<td>工号：</td>
				<td width="250px"><input class="" id="updateaid"
					readonly="readonly" style="width: 100%"></td>
			</tr>
			<tr>
				<td>姓名：</td>
				<td width="250px"><input class="" id="updateaname"
					readonly="readonly" style="width: 100%"></td>
			</tr>
			<tr>
				<td>职位：</td>
				<td><input class="" id="updateatype" type="text"
					style="width: 100%"></td>
			</tr>
			<tr>
				<td>电话：</td>
				<td><input class="" id="updateatelephone" type="text"
					style="width: 100%"></td>
			</tr>
			<tr>
				<td align="right" colspan="3"><a class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" style="width: 100px"
					onclick="updatesave()">保存</a> <a class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'" style="width: 100px"
					onclick='$("#editUpdate").dialog("close");'>取消</a></td>
			</tr>
		</table>
	</div>

	<div id="editDelete" class="easyui-dialog" title="删除员工"
		style="width: 400px; height: 200px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<table>
			<tr align="left">
				<td>确定要删除该员工吗？</td>
			</tr>
			<br>
			<br>
			<tr align="center">
				<td align="right" colspan="3"><a class="easyui-linkbutton"
					data-options="iconCls:'icon-save'" style="width: 100px"
					onclick="deleteSure()">删除</a> <a class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'" style="width: 100px"
					onclick='$("#editDelete").dialog("close");'>取消</a></td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
		$(function() {
			//创建data_grid
			url = "Servlet?op=queryAdmin";
			$("#limitTable").datagrid({
				url : url, //数据来源   
				//冻结列

				//列的定义
				columns : [ [ {
					field : 'aid',
					title : '编号',
					width : 50,
					align : 'center'
				}, {
					field : 'aname',
					title : '姓名',
					width : 70,
					align : 'center'
				}, {
					field : 'atelephone',
					title : '电话',
					width : 100,
					align : 'center'
				}, {
					field : 'atype',
					title : '职位',
					width : 70,
					align : 'center',
				}, {
					field : 'operation',
					title : '操作',
					formatter : fmtDo,
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
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"
			onclick="$('#editAdd').dialog('open');">添加人员</a>
		<form>
			<input type="text" placeholder="名字" name="aname" id="aname">&nbsp;&nbsp;
			<input type="text" placeholder="职位" name="atype" id="atype">
			<input type="text" id="aid" style="display: none;"> <a
				class="easyui-linkbutton" plain="true" onclick="conditionSearch()">查询</a>
		</form>
	</div>
	<table id="limitTable">

	</table>


</body>
</html>

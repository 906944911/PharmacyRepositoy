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
		return '<a href="#" onclick="openUpdate(' + index + ')">修改信息</a>';
	}

	function fmtAdd(value, row, index) {
		return '<a href="#" onclick="openAddInventory(' + index + ')">添加库存</a>';
	}

	function openAddInventory(index) {
		//权限管理
		var data = $("#commodityTable").datagrid('getData');
		var cid = data.rows[index]['yid'];
		var cname = data.rows[index]['yname'];
		var cnum = data.rows[index]['ynum'];
		var yunit = data.rows[index]['yunit'];

		$("#Inventoryyid").val(cid);
		$("#Inventoryyname").val(cname);
		$("#Inventoryyunit").val(yunit);
		$("#Inventoryynum").val(cnum);
		$("#editAddInventory").dialog('open');

	}

	function openUpdate(index) {
		//权限管理
		var data = $("#commodityTable").datagrid('getData');
		var cid = data.rows[index]['yid'];
		var cname = data.rows[index]['yname'];
		var cprice = data.rows[index]['yprice'];
		var cnum = data.rows[index]['ynum'];
		var yunit = data.rows[index]['yunit'];
		var upystockprice = data.rows[index]['ystockprice'];

		$("#upcid").val(cid);
		$("#upcname").val(cname);
		$("#upcprice").val(cprice);
		$("#upcnum").val(cnum);
		$("#upyunit").val(yunit);
		$("#upystockprice").val(upystockprice);
		$("#editUpdate").dialog('open');

	}

	function saveUpdate() {
		var cid = $("#upcid").val();
		var cname = $("#upcname").val();
		var cprice = $("#upcprice").val();
		var yunit = $("#upyunit").val();
		$.ajax({
			url : "Servlet?op=updateCommodity",
			data : {
				"yid" : cid,
				"yname" : cname,
				"yprice" : cprice,
				"yunit" : yunit
			},
			dataTpye : "json",
			type : "POST",
			success : function(data) {
				if (data.code == 0) {
					alert("修改失败，请与管理员联系...");
				} else {
					alert("修改成功");
					$("#editUpdate").dialog("close");
					$("#commodityTable").datagrid("reload");
				}
			}
		});
	}

	function AddInventorysave() {
		var yid = $("#Inventoryyid").val();
		var addnum = $("#addnum").val();
		//判断该会员号是否已经存在
		$.ajax({
			url : "Servlet?op=InventoryYaopin",
			type : 'POST',
			dataType : 'json',
			data : {
				"yid" : yid,
				"addnum" : addnum
			},
			success : function(data) {
				// 使用eval函数将 json 字符串转成 对象 d
				if (data.code == 1) {
					alert(data.data);
					$("#editAddInventory").dialog("close");
					$("#commodityTable").datagrid("reload");
				} else {
					alert(data.data);
				}
			}
		});
	}
	
	function save() {
		var yunit = $("#addyunit").val();
		var yname = $("#addyname").val();
		var ystockprice = $("#addystockprice").val();
		var yprice = $("#addyprice").val();
		$.ajax({
			url : "Servlet?op=addYaopin",
			type : 'POST',
			dataType : 'json',
			data : {
				"yunit" : yunit,
				"yname" : yname,
				"ystockprice" : ystockprice,
				"yprice" : yprice
			},
			success : function(data) {
				// 使用eval函数将 json 字符串转成 对象 d
				if (data.code == 1) {
					alert(data.data);
					$("#editAdd").dialog("close");
					$("#commodityTable").datagrid("reload");
				} else {
					alert(data.data);
				}
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
					title : '修改信息',
					width : 70,
					formatter : fmtDo,
					align : 'center'
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
					field : 'addInventory',
					title : '添加库存',
					width : 70,
					formatter : fmtAdd,
					align : 'center',
				}, {
					field : 'update',
					title : '修改信息',
					width : 70,
					formatter : fmtDo,
					align : 'center'
				} ] ],
				fitColumns : true,//列自适应宽度，不能和冻结列同时设置为true
				idField : 'yid',//主键列
				//rownumbers : true,//显示行号
				//singleSelect : true,//是否单选
				remoteSort : false,//是否服务器端排序，设成false，才能客户端排序

			});
		})
	</script>


	<div id="editAdd" class="easyui-dialog" title="添加药品"
		style="width: 400px; height: 300px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<form action="" id="form1">
			<table>
				<tr>
					<td>药名：</td>
					<td width="250px"><input class="easyui-textbox" id="addyname"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>单位：</td>
					<td><input class="easyui-textbox" id="addyunit" type="text"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>进货价：</td>
					<td><input class="easyui-textbox" id="addystockprice"
						type="text" style="width: 100%"></td>
				</tr>
				<tr>
					<td>售价：</td>
					<td><input class="easyui-textbox" id="addyprice" type="text"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td align="right" colspan="3"><a class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" style="width: 100px"
						onclick="save()">保存</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" style="width: 100px"
						onclick='$("#editWin").dialog("close");'>取消</a></td>
				</tr>
			</table>
		</form>

	</div>


	<div id="editAddInventory" class="easyui-dialog" title="添加药品库存"
		style="width: 400px; height: 300px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<form action="" id="form1">
			<table>
			<tr>
					<td>药品编号：</td>
					<td width="250px"><input class="" id="Inventoryyid" readonly="readonly"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>药名：</td>
					<td width="250px"><input class="" id="Inventoryyname" readonly="readonly"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>单位：</td>
					<td><input class="" id="Inventoryyunit" type="text" readonly="readonly"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>库存：</td>
					<td><input class="" id="Inventoryynum" readonly="readonly"
						type="text" style="width: 100%"></td>
				</tr>
				<tr>
					<td>新增数量：</td>
					<td><input class="" id="addnum" type="text"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td align="right" colspan="3"><a class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" style="width: 100px"
						onclick="AddInventorysave()">保存</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" style="width: 100px"
						onclick='$("#editWin").dialog("close");'>取消</a></td>
				</tr>
			</table>
		</form>

	</div>

	<div id="editUpdate" class="easyui-dialog" title="修改信息"
		style="width: 400px; height: 550px; padding: 10px"
		data-options="iconCls:'icon-save',closed:true,modal:true">
		<form action="Servlet" id="form1">
			<input type="hidden" id="op" name="op" value="addNewCommodity">
			<input type="hidden" id="id" name="cid" value="">

			<table>
				<tr>
					<td>编号：</td>
					<td width="250px"><input class="" id="upcid"
						readonly="readonly" name="cname" style="width: 100%"></td>
				</tr>
				<tr>
					<td>商品名称：</td>
					<td width="250px"><input class="" id="upcname"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td>进货单价：</td>
					<td><input class="" id="upystockprice" readonly="readonly"
						type="text" style="width: 100%"></td>
				</tr>
				<tr>
					<td>售价：</td>
					<td><input class="" id="upcprice" type="text"
						style="width: 100%"></td>
				</tr>

				<tr>
					<td>计量单位：</td>
					<td><input class="" id="upyunit" type="text"
						style="width: 100%"></td>
				</tr>
				<tr>
					<td align="right" colspan="3"><a class="easyui-linkbutton"
						data-options="iconCls:'icon-save'" style="width: 100px"
						onclick="saveUpdate()">保存</a> <a class="easyui-linkbutton"
						data-options="iconCls:'icon-cancel'" style="width: 100px"
						onclick='$("#editUpdate").dialog("close");'>取消</a></td>
				</tr>
			</table>
		</form>

	</div>
	<div id="tb" style="padding: 5px; height: auto">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"
			onclick="$('#editAdd').dialog('open');">添加药品</a>
		<form>
			<input type="text" placeholder="药品名称" name="cname" id="cname">&nbsp;&nbsp;
			<a class="easyui-linkbutton" plain="true" onclick="conditionSearch()">药品查询</a>
		</form>
	</div>
	<table id="commodityTable">

	</table>


</body>
</html>


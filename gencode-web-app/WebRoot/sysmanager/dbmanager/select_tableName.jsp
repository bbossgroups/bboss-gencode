<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%


		
	String dbname = (String) request.getParameter("dsource");
	String selected_tablename = request.getParameter("tablename");
	
	dbname = dbname == null ? "" : dbname;
	selected_tablename = selected_tablename == null ? ""
			: selected_tablename;

%>
<html>
	<head>
		<title>选择数据库表</title>
		<%@ include file="/include/css.jsp"%>
		 
	</head>

	<body>
		<form name="dictList" method="post">
			<input type="hidden" name="dbname" value="<%=dbname%>">
			<input type="hidden" name="selected_tablename" value="<%=selected_tablename%>">
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="thin">
				<tr valign='top'>
					<td height='30' colspan="5">
						<img src='<%=request.getContextPath()%>/include/images/edit.gif' width="16" height="16" border=0
							align='absmiddle'>
						&nbsp;
						<strong>选择数据库表</strong>
					</td>
				</tr>
				<tr class="labeltable_middle_tr_01">
					<td nowrap>
						表名
						<input type="text" name="queryTableName" value="<%=selected_tablename%>" style="width:150px">
						<input type="button" value="查询" class="input" onclick="querytable()">
					</td>
				</tr>
			</table>
		</form>
		<iframe src="" name="tabelListFrame" frameborder="0" width="99%" height="300px"></iframe>
		<table cellspacing="1" cellpadding="0" border="0" width="100%">
			<tr height="18px" class="labeltable_middle_tr_01">
				<td align='center'></td>
				<td align='right'></td>
			</tr>
			<tr height="18px" class="labeltable_middle_tr_01">
				<td align='center'></td>
				<td align="center" colspan="1" nowrap>
					<input type="button" value="确定" class="input" onclick="setValue('tablename')">
					<input name="new" type="button" class="input" value="清除" onclick="removeValue('tablename')">
					<input name="new" type="button" class="input" value="关闭" onclick="setValue('tablename')">
				</td>
			</tr>
		</table>
	</body>
	<script>
        var opener = window.opener;
		function setValue(checkbox_name)
		{
			var returnValue = '';
            
			arr = tabelListFrame.document.getElementsByName(checkbox_name);
			for(var i=0; i<arr.length;i++)
			{
				if(arr[i].checked)
				{
					returnValue = arr[i].value;
				}
			}
            opener.queryTableData(returnValue);
			window.close();
		}
		
			    
 	    function selectOne(checkbox_name,e)
 	    {
 	        arr = document.getElementsByName(checkbox_name);
 	        for(var i=0;i<arr.length;i++)
 	        {
 	            if(arr[i].value==e.value)
 	            {
 	                arr[i].checked = true;
 	            }
 	            else
 	            {
 	                arr[i].checked = false;
 	            }
 	        }
 	    }
 	    function removeValue(checkbox_name)
 	    {
 	        tabelListFrame.removeValue(checkbox_name);
 	    }
 	    
 	    function querytable()
 	    {
 	        var path = "tableList.jsp?selected_tablename=<%=selected_tablename%>"; 	        
 	        document.dictList.target = "tabelListFrame";
 	        document.dictList.action = path;
 	        document.dictList.submit();
 	    }
 	    querytable();
 	</script>
</html>


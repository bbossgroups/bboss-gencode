<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%


		
	String dbname = (String) request.getParameter("dsource");
	
	dbname = dbname == null ? "" : dbname;
	

%>
<html>
	<head>
		<title>选择数据库表</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
		 
	</head>

	<body>
		<form name="dictList" method="post">
			<input type="hidden" name="dbname" value="<%=dbname%>">
			 
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="thin">
				<tr valign='top'>
					<td height='30' colspan="5">
						<img src='<%=request.getContextPath()%>/include/images/edit.gif' width="16" height="16" border=0
							align='absmiddle'>
						&nbsp;
						<strong>选择历史SQL</strong>
					</td>
				</tr>
				<tr class="labeltable_middle_tr_01">
					<td nowrap>
						SQL
						<input type="text" name="querySQLText" value="" style="width:150px">
						<input type="button" value="查询" class="input" onclick="querysql()">
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
					<input type="button" value="确定" class="input" onclick="setValue()">				
					<input name="new" type="button" class="input" value="关闭" onclick="closeWindow()">
				</td>
			</tr>
		</table>
	</body>
	<script>
        var opener = window.opener;
        var selectSQL ;
        function setselectSQL(selectSQL_){
            selectSQL = selectSQL_;
        }
		function setValue()
		{

             
            if(!selectSQL)
            {
                alert("选择历史sql！");
                return;
            }
			 
            opener.setSQL(selectSQL);
			window.close();
		}
        
        function closeWindow(){
            window.close();
        }
		
	 
 	    
 	    function querysql()
 	    {
 	        var path = "sqlList.jsp"; 	        
 	        document.dictList.target = "tabelListFrame";
 	        document.dictList.action = path;
 	        document.dictList.submit();
 	    }
        querysql();
 	</script>
</html>


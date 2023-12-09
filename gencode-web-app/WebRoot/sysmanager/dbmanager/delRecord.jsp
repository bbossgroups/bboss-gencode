<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	
	String dsource =request.getParameter("dsource");
	String tablename = request.getParameter("tablename");
	
	String []values = request.getParameterValues("checkObject");
	
	boolean flag = false;
	String errorMessage = "";
	
	if( dsource != null && !"".equals(dsource) && tablename != null && !"".equals(tablename))
	{
		DBUtil db = new DBUtil();
		try
		{
			db.setBatchDBName(dsource);		
			db.setAutoCommit(false);

			for(int i=0; i<values.length; i++)
			{
				String condition = values[i];
				if(condition != null && !condition.equals(""))
				{
					String sql = "delete from " + tablename + " where " + condition.replaceAll(","," and "); 
					db.addBatch(sql);
					
				}
			}
			//批量删除
			db.executeBatch();
			db.commitTransaction();
			flag = true;
		} 
		catch(Exception  e)
		{
			db.rollbackTransaction();
			flag = false;
			errorMessage = e.getMessage();
			e.printStackTrace();
		}
	}
		
 %>
 <html>
	<head>
		<title>状态信息</title>
		<%@ include file="/include/css.jsp"%>
	</head>
	<body>
		<br/>
		<div style="text-align:center">
		<%
			if(flag == true)
			{
		%>
           
			<font color='red'>删除成功!!!</font>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
		<%
			}
			else
			{
		%>
			<font color='red'>删除失败!!!<br/><br/>
			失败原因:</font><%=errorMessage%>
			<br/>
			<br/>
			<br/>
		<%
			}
		%>
			<br/>
			<input type="button" class="input" value="关闭" onclick="closeWindow()"/>
		</div>
	</body>
    <script lang="JavaScript">
        function closeWindow(){
            window.opener.refreshSelectTableList();
            window.close();
        }
       
    </script>
</html>

 
 

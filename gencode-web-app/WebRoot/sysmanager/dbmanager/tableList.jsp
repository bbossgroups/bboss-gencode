<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.frameworkset.util.RegexUtil"%>
<%
	String dbname = (String) request.getParameter("dbname");
	dbname = dbname == null ? "" : dbname;
	
	
	String selected_tablename = request.getParameter("selected_tablename");
	selected_tablename = selected_tablename == null ? "" : selected_tablename;
		
	String queryTableName = request.getParameter("queryTableName") == null ? "" : request.getParameter("queryTableName");
			
	List tableList = new ArrayList();
	List tableComments = new ArrayList();
	Set set = DBUtil.getTableMetaDatas(dbname);
	Iterator it = set.iterator();
	boolean searchNone = false;
	
	//查询的queryTableName放到第一位
	int similarCount = 0;
	while (it.hasNext()) 
	{
		TableMetaData metaData = (TableMetaData) it.next();
		String tname = metaData.getTableName();
		tableComments.add(metaData.getRemarks());
	
		boolean firstFlag = false;
			
		if (RegexUtil.isContain(tname, queryTableName)) 
		{
			similarCount++;
			firstFlag = true;
		}
		
		if(firstFlag)
		{
		    tableList.add(0,tname);
		}
		else
		{		    
		   tableList.add(tname);
		}
	}

	if (similarCount == 0) 
	{//没有一个匹配
		searchNone = true;
	}
%>
<html>
	<head>
		<title>选择数据库表</title>
		<%@ include file="/include/css.jsp"%>
	</head>

	<body>
		<form name="dictList" method="post">
			<table cellspacing="1" cellpadding="0" border="0" width=98%
				class="thin">
				<tr>
					<td class="headercolor" width="10">

					</td>
					<td class="headercolor" style="text-align:left">
						数据库表
					</td>
					<td class="headercolor" style="text-align:left">
						数据库表说明
					</td>
				</tr>
				<%
				if (searchNone) 
				{
				%>
				<tr>
					<td class="tablecells" nowrap="nowrap">

					</td>
					<td class="tablecells" colspan="2" style="text-align:left"
						nowrap="nowrap">
						<span style="color:red">没有找到和查询条件匹配的数据库表</span>
					</td>

				</tr>
				<%
					searchNone = false;
				}
					for (int i = 0; i < tableList.size(); i++)
					{
						String name = String.valueOf(tableList.get(i));
						String remarks = (String) tableComments.get(i);
				%>
				<tr>
					<td class="tablecells" nowrap="nowrap">
						<%
							if(selected_tablename.equals(name))
							{
						%>
							<input type="radio" name="tablename" checked="checked" style="text-align:left"
							onclick="selectOne('tablename',this)"  value="<%=name%>" width="10">
						<%
							}
							else
							{
						%>
							<input type="radio" name="tablename" style="text-align:left"
							onclick="selectOne('tablename',this)"  value="<%=name%>" width="10">
						<%
							}
						%>
						
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
						<%=name%>
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
						<%=remarks%>
					</td>
				</tr>
				<%
				   }
				%>
			</table>
		</form>
	</body>
	<script> 	    
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
 	      var arr = document.getElementsByName(checkbox_name);
 	       for(var i=0;i<arr.length;i++)
 	       { 	            
 	            arr[i].checked = false; 	            
 	        }
 	    }
 	</script>
</html>


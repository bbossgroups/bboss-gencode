
<%@page import="com.frameworkset.util.SimpleStringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<html>
	<head>
		<title>属性容器</title>
		<%@ include file="/include/css.jsp"%>
		


 <%

 	

 	String dsource = request.getParameter("dsource2");
 	String sql = request.getParameter("sqlContent");
 	

 	
 	if(null == dsource || null == sql 
 					|| "".equals(sql)  || "".equals(dsource) || 
 					"".equals(dsource.trim()) || "".equals(sql.trim()))
 	{
 					
 		out.print("查询条件不足,请检查是否选择数据源或是否输入了SQL语句!!!");
 		return ;
 	}
 	
 	//去掉sql空格
 	sql = sql.trim();
 	
	out.print(sql);
		
	boolean flag = false;	

	String errorMessage ="";
	
	//存取列名
	List columnList = null ;
	DBUtil db = new DBUtil();
	try
	{
		//执行sql语句
		
		db.executeSelect(dsource,sql,0,1);
		ResultSetMetaData resultMeta = db.getMeta();
		
		if(resultMeta != null) 
		{
	        columnList = new ArrayList();
			int size =resultMeta.getColumnCount();
			for(int i=1; i<=size; i++)
			{
				String columnName = resultMeta.getColumnName(i);
				columnList.add(columnName);
			}
		}
		flag = true;
	} catch(Exception e)
	{
		try
		{
			db.executeUpdate(dsource,sql);
			flag = true;
		}
		catch(Exception ex)
		{
			flag = false;
			errorMessage = e.getMessage();
			errorMessage = SimpleStringUtil.exceptionToString(e) +"<br>"+SimpleStringUtil.exceptionToString(ex);
			e.printStackTrace();
			ex.printStackTrace();
		}
		
		
		
	}
	
	
	//处理每页显示的记录数:默认是10
	
	String str_pageSize = request.getParameter("pageSize2");
	
	int pageSize = 10;
	
	if(str_pageSize != null && !"".equals(str_pageSize))
	{
		try
		{
			pageSize = Integer.parseInt(str_pageSize);
		}catch(NullPointerException e)
		{
			pageSize = 10;
		}
	}

  %>
  
  	<body class="contentbodymargin">
  		
  		<%
  		if(flag && columnList != null)
  		{
  		%>
  			<pg:pager statement="<%=sql %>" dbname="<%=dsource %>" isList="false" maxPageItems="<%=pageSize%>">
  				<pg:param name="sqlContent" value="<%=sql %>"/>
  				<pg:param name="dsource2" value="<%=dsource %>"/>
  				<pg:param name="pageSize2"/>
  				
  				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  					<tr class="labeltable_middle_td">
  					<%
  						for(int i=0; i<columnList.size(); i++)
  						{
  					%>	
  							<td height="20" size="3" class="headercolor"><%=(String)columnList.get(i) %></td>
  					<%
  						}
  					 %>	
  		 			<tr>
  		 			<pg:notify>
						<tr><td colspan="<%=columnList.size()+1%>"><font color='red'>没有记录</font></td></tr>
					</pg:notify>
					
					<pg:list>
					<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					  	<%
					  		for(int j=0; j<columnList.size(); j++)
					  		{
						%>
						<td>
							<pg:cell colName="<%=(String)columnList.get(j) %>"/>
						</td>
						<%
					  		}
					  	 %>
					</tr>
			   		</pg:list>
			   		<tr>
						<td colspan="<%=columnList.size()+1%>" height='20' size="3"  class="tablecells">
							 <pg:index/>&nbsp;&nbsp;
							</form>
						</td>
					</tr>
				</table>
			</pg:pager>	
  		<%
  			}
  			else if(flag && columnList == null)
  			{
  				out.print("<br/><br/>SQL执行成功!!!");
  			}
  			else
  			{
  				out.print("<br/><br/>请检测SQL语句是否有问题,操作失败---> " + errorMessage);
  			}
  		 %>
	</body>
</html>

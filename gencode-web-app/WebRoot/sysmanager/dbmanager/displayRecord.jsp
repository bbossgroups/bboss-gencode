<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.SQLException"%>



<%
	
	String dsource =request.getParameter("dsource");
	String tablename = request.getParameter("tablename");
	String []values = request.getParameterValues("checkObject");
	String pageSize = request.getParameter("pageSize");
		
	//存放列信息
	List columnList = null;
		

	boolean flag = false;
	
	
	if( dsource != null  && !"".equals(dsource) 
			&& tablename != null && !"".equals(tablename) 
			&& values!= null && !values.equals(""))
	{
			flag = true;
	}
 %>
<html>
<head>
		<title>属性容器</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
	 
	 
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
	<tr class="labeltable_middle_td">
			<td height="20" size="3" class="headercolor">
				修改数据
			</td>
	</tr>
</table>
 <form method="post" action="updRecord.jsp">
 	<input type="hidden" name="pageSize" value="<%=pageSize%>"/>
	<table width="98%" border="0" align="center" cellpadding="1" cellspacing="1">  
	  <tr>
	    <td>
	    	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		      <tr>
		        <td width="11">&nbsp;</td>
		        <td background="../../../image/title_bj_1.jpg"><span class="STYLE2">&nbsp;</span>
		          <div  onClick="window.close();"  style=" cursor:hand; text-decoration:underline" align="center"></div></td>
		        <td background="../../../image/title_bj_1.jpg"><div align="center"><span class="STYLE2"></div></td>
		        <td background="../../../image/title_bj_1.jpg"><a href="javascript:void(0)"></a></td>
		        <td width="7">&nbsp;</td>
		      </tr>
	    	</table>
	    </td>
	  </tr>
	    <%
	    	if(flag == true)
	    	{
	    		if(values.length > 0 && values[0] != null && !values[0].equals(""))
	    		{
	    			DBUtil db = new DBUtil();
	    			String sql ="";
	    			sql = "select * from " + tablename + " where " + values[0];
	    			try
	    			{
	    				db.executeSelect(dsource,sql);
		    			ResultSetMetaData resultMeta = db.getMeta();
		    			
		    			//获取列名
		    			if(resultMeta != null)
		    			{
		    				columnList = new ArrayList();
							int size =resultMeta.getColumnCount();
							for(int i=1; i<=size; i++)
							{
								String columnName = resultMeta.getColumnName(i);
								String columnType = resultMeta.getColumnTypeName(i);
								columnList.add(columnName + "|" + columnType);		
							}
							
							//记录值
		    				if(db.size() > 0)
		    				{
		    					for(int i=0; i< columnList.size(); i++)
		    					{
		    						String fieldNameAndType = (String) columnList.get(i);
		    						int location = fieldNameAndType.indexOf("|");
			 						String fieldName = fieldNameAndType.substring(0,location);
			 						String fieldType = fieldNameAndType.substring(location+1); 
			 						
			 						if(fieldType.equals("DATE"))
			 						{
			 %>
									 	<tr>
											<td><%=fieldName %></td>
											<td><input type="text" name="<%=fieldNameAndType %>" onclick='showdate(document.all("<%=fieldNameAndType %>"))' size="40" readonly="readonly" value="<%=db.getString(0,fieldName)%>"/></td>
										</tr>
			 <%
			 						}
			 						else
			 						{
			 %>
			 							<tr>
											<td>
												<%=fieldName %>
											</td>
											<td>
												<%
													if(values[0].indexOf(fieldName) != -1)
			 										{
			 									%>
			 										<input type="text" name="<%=fieldNameAndType %>" size="40" readonly="readonly" value="<%=db.getString(0,fieldName)%>"/>
			 									<%
			 										}
			 										else
			 										{
			 									%>
			 										<input type="text" name="<%=fieldNameAndType %>"  size="40" value="<%=db.getString(0,fieldName)%>"/>
			 									<%
			 										}
												 %>
											</td>
										</tr>
			 <%
			 						}
		    					}
		    %>
		    							<tr>
							           	   <td align="center">
									               <input type="hidden" name="dsource" value="<%=dsource %>"/>
									               <input type="hidden" name="tablename" value="<%=tablename %>"/>
									               <input type="hidden" name="keyValue" value="<%=values[0]%>"/>
									               <input type="submit" class="input" value="保存">
									        </td>
									        <td align="left">
									               <input type="reset" class="input"  value="重置">
							               </td>
							           </tr>   
		    <%
		    				}
		    			}
	    			}
	    			catch(SQLException e)
	    			{
	    				e.printStackTrace();
	    			}
	    		}				
			}	    		
	     %>
	</table>
</form>
</body>
</html>

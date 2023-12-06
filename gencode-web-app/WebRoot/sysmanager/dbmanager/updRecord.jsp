<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.sql.SQLException"%>

<%
	String dsource =request.getParameter("dsource");
	String tablename = request.getParameter("tablename");
	String value = request.getParameter("keyValue");
	
	String pageSize = request.getParameter("pageSize");
	
	String sql ="";
	
	boolean flag = false;
	
	String errorMessage = "";
	
	if(dsource != null && !"".equals(dsource) && tablename != null && !"".equals(tablename)
		&&  value != null && !"".equals(value))
		{
			Enumeration paramNameEnum = request.getParameterNames();
			while(paramNameEnum.hasMoreElements())
			{
				String paramName = (String) paramNameEnum.nextElement();
				if( !"dsource".equals(paramName) && !"tablename".equals(paramName) && !"keyValue".equals(paramName) && !"pageSize".equals(paramName)) 
					{
						String fieldNameAndType = (String) paramName;
						
		    			int location = fieldNameAndType.indexOf("|");	    			
			 			String fieldName = fieldNameAndType.substring(0,location);
			 			String fieldType = fieldNameAndType.substring(location+1); 
			 			
			 			if(fieldType.equals("DATE"))
			 			{
			 				String dateValue = request.getParameter(paramName);
			 				
			 				if(dateValue != null &&  !dateValue.trim().equals(""))
			 				{
			 					if(dateValue.indexOf(":") != -1)
			 					{
			 						sql += fieldName + "=to_date('" + dateValue.substring(0,dateValue.lastIndexOf(".")) +"','yyyy-mm-dd hh24:mi:ss'),"; 
			 					}
			 					else
			 					{
			 						sql += fieldName + "=to_date('" + dateValue +" 00:00:00','yyyy-mm-dd hh24:mi:ss'),"; 
			 					}
			 				}		
			 		
			 			}
			 			else
			 			{
			 				String dateValue = request.getParameter(paramName);

							if(dateValue != null && !dateValue.equals(""))
			 				{
			 					sql += fieldName + "='" + dateValue + "',";
			 				}		
			 			}
			 			
						
					}
		}
		
		if(!sql.equals(""))
		{
			
			String sq = "update " + tablename + " set " + sql.substring(0,sql.lastIndexOf(",")) + " where " + value;
			
			System.out.println(sq);
			try
			{
				DBUtil db = new DBUtil();
				//db.execute(sq);
				db.executeUpdate(sq);
				flag = true;
			}
			catch(SQLException e)
			{
				flag = false;
				errorMessage = e.getMessage();
				e.printStackTrace();
			}	
		}
	}
 %>

 <script language="javascript">
 	if(<%=flag%> == true)
 	{
 		alert('修改成功!!!');
 	}
 	else
 	{
 		alert("修改失败!!!");	
 	}
 	window.location.href = "selectedtabList.jsp?dsource=<%=dsource%>&table_name=<%=tablename%>&pageSize=<%=pageSize%>";
 </script>


<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>

<%
	    boolean flag = false ;
	    
	    String db = (String) request.getParameter("db");
	    //获取选中的行的参数值
		String[] tablesName = request.getParameterValues("checkboxOne") ;
		
		if(db != null && !db.trim().equals("")  
						&& tablesName != null && tablesName.length > 0)
		{
			try
			{
				TableInfoManager tableInfoManager = new TableInfoManagerImpl();
				tableInfoManager.deletesByTableNames(db,tablesName);
				flag = true ;
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				flag = false ;
			}	
		}				
%>

<script type="text/javascript">
	if(<%=flag%>)
	{
		alert("删除成功!");
	}
	else
	{
		alert("删除失败!");
	}
	window.parent.location.href = window.parent.location.href ;
</script>



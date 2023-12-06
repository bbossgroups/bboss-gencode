<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>


<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>


<%


		
		String dbName = request.getParameter("dbName");
		
		List tablesList = null;
		
		if(dbName != null && !dbName.equals(""))
		{
			//获取TableInfo表中没有数据表名称
			try
			{
				TableInfoManager tableInfoManager = new TableInfoManagerImpl();
				tablesList =  tableInfoManager.getTablesByDBName(dbName,false);
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		if(tablesList == null)
		{
			tablesList = new ArrayList();
		}		
		
%>

		<script language="javascript">
		var operselect = parent.document.getElementById("tableName");
		var options_ = operselect.options;
		var length = options_.length;
		try
		{
			
			for(var i = 0; i < length - 1; i ++)
			{
				operselect.removeChild(options_(1));
			}

		}
		catch(e)
		{
			alert(e);
		}
	     
	     <%
				if(tablesList.size() >0)
				{
					for(int i=0; i<tablesList.size(); i++)
					{
						String tableName = (String) tablesList.get(i);
		%>
							var option = new Option();
							option.value ='<%=tableName%>';
			    			option.text ='<%=tableName%>';
			    			operselect.add(option);
		<%
					}
				
				}	     		
	     
	     %>		
		</script>
		

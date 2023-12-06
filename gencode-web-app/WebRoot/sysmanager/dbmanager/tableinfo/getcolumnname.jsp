<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>


<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.frameworkset.common.poolman.sql.PrimaryKeyMetaData"%>


<%


		
		String dbName = request.getParameter("dbName");
		String tableName = request.getParameter("tableName");
		
		//存放数据源下的数据表的列值信息
		List keyColumnList = new ArrayList();
		if(dbName != null && !dbName.equals("")
							&& tableName != null && !tableName.equals(""))
		{
			try
			{
				DBUtil db = new DBUtil();
				//TableMetaData tableMetaData = db.getTableMetaData(dbName,tableName);
				
				Set keyMetaDataSet = db.getPrimaryKeyMetaDatas(dbName,tableName);
		
				for (Iterator iter = keyMetaDataSet.iterator(); iter.hasNext();) 
				{
					PrimaryKeyMetaData primaryKeyMetaData = (PrimaryKeyMetaData) iter.next();
					keyColumnList.add(primaryKeyMetaData.getColumnName());
				}		
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
				
		
%>

		<script language="javascript">
		var operselect = parent.document.getElementById("keyName");
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
				if(keyColumnList.size() >0)
				{
					for(int i=0; i<keyColumnList.size(); i++)
					{
						String keyName = (String) keyColumnList.get(i);
		%>
							var option = new Option();
							option.value ='<%=keyName%>';
			    			option.text ='<%=keyName%>';
			    			operselect.add(option);
		<%
					}
				
				}	     		
	     
	     %>		
		</script>
		

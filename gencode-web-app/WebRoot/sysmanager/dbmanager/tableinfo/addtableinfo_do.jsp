
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoEntity"%>


<%
	    
	    boolean flag = false ;
	    
	    String dbName = request.getParameter("dbName");
		String tableName = request.getParameter("tableName");
		String keyName = request.getParameter("keyName");
		
		String keyIncrement = request.getParameter("keyIncrement");
		String currentKeyValue = request.getParameter("currentKeyValue");
		
		String keyGenerator = request.getParameter("keyGenerator");
		String keyPrefix = request.getParameter("keyPrefix");
		String keyType = request.getParameter("keyType");
		
		String errorMessage = "操作失败";
		
		try
		{
			dbName = dbName == null ? "" : dbName ;
			tableName = tableName == null ? "" : tableName;
			
			
			TableInfoManager tableInfoManager = new TableInfoManagerImpl();
			
			if(tableInfoManager.isExist(dbName,tableName))
			{
				errorMessage += ",失败原因:已经存在该表名";
				flag = false ;
			}
			else 
			{
				keyName = keyName == null ? "" : keyName;
			
				int keyInc = Integer.parseInt(keyIncrement);
				int currKeyValue = Integer.parseInt(currentKeyValue);
				
				keyGenerator = keyGenerator == null ? "" : keyGenerator ;
				keyPrefix = keyPrefix == null ? "" : keyPrefix ;
				keyType = keyType == null ? "" : keyType ;
				
				TableInfoEntity tableInfoEntity = new TableInfoEntity();
				
				tableInfoEntity.setTableName(tableName);
				tableInfoEntity.setTableKeyName(keyName);
				tableInfoEntity.setKeyIncrement(keyInc);
				tableInfoEntity.setCurrentKeyValue(currKeyValue);
				tableInfoEntity.setKeyGenerator(keyGenerator);
				tableInfoEntity.setKeyPrefix(keyPrefix);
				tableInfoEntity.setKeyType(keyType);
				
				
				tableInfoManager.saveTableInfo(dbName,tableInfoEntity);
				flag = true ;
			
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			flag = false ;
		}
				
%>

<script type="text/javascript">
	if(<%=flag%>)
	{
		alert("新增成功!");
	}
	else
	{
		alert("<%=errorMessage%>!");
	}
	 parent.document.all("save").disabled = false ;
	 parent.document.all("reset").disabled = false ;
	 parent.document.all("back").disabled = false;
</script>




<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoEntity"%>


<%
	    
	    boolean flag = false ;
	    
	    String errorMessage = "修改失败";
	    
	    String db = request.getParameter("db");
	    db = db == null ? "" : db ;
	    
		String tableName = request.getParameter("tableName");
		tableName = tableName == null ? "" : tableName;
		
		if(!db.trim().equals("") && !tableName.trim().equals(""))
		{
			String keyName = request.getParameter("keyName");
		
			String keyIncrement = request.getParameter("keyIncrement");
			String currentKeyValue = request.getParameter("currentKeyValue");
		
			String keyGenerator = request.getParameter("keyGenerator");
			String keyPrefix = request.getParameter("keyPrefix");
			String keyType = request.getParameter("keyType");	
			
			try
			{
				TableInfoManager tableInfoManager = new TableInfoManagerImpl();
				
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
				
				tableInfoManager.update(db,tableInfoEntity);
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
		alert("修改成功!");
	}
	else
	{
		alert("<%=errorMessage%>!");
	}
	 parent.document.all("save").disabled = false ;
	 parent.document.all("reset").disabled = false ;
	 parent.document.all("back").disabled = false;
</script>



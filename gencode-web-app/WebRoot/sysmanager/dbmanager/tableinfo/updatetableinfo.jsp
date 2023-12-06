
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoEntity"%>
<%@ page import="com.frameworkset.common.poolman.sql.TableMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.ColumnMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.PrimaryKeyMetaData"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
	    
	    String db = request.getParameter("db");
	    String tableName = request.getParameter("tablename");
	    
	    db = db == null ? "" : db;
		tableName = tableName == null ? "" : tableName;
	    
	    String keyName = "";
		String keyIncrement = "";
	    String currentKeyValue = "";
		String keyGenerator = "";
		String keyPrefix = "";
		String keyType = "";
			
			
	    
	    if(!db.trim().equals("")  && !tableName.trim().equals(""))
	    {
	    	try
	    	{
		    	TableInfoManager tableInfoManager = new TableInfoManagerImpl();
			    TableInfoEntity tableInfoEntity = tableInfoManager.getTableInfoEntity(db,tableName);	    	
			    
			    keyName = tableInfoEntity.getTableKeyName();
			    keyIncrement = tableInfoEntity.getKeyIncrement() +"";
			    currentKeyValue = tableInfoEntity.getCurrentKeyValue() + "";
			    keyGenerator = tableInfoEntity.getKeyGenerator();
			    keyPrefix = tableInfoEntity.getKeyPrefix();
			    keyType = tableInfoEntity.getKeyType();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
	    }
%>

<html>
	<head>     
    	<title>主键表的修改界面</title> 
		<%@ include file="/include/css.jsp"%>
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<script language="javaScript">
			function addInfo()
			{  
				 
				  var tableName = document.all.tableName.value ;
				  if(tableName =="")
				  {
				    alert("数据表的名称不能空！");
				    return false ;
				  }
				  
				   var keyName = document.all.keyName.value ;
				  if(keyName == "")
				  {
				  	alert('主键名称不能空!');
				  	return false ;
				  }
				  
				  
				  var keyType = document.all.keyType.value ;
				  if(keyType == "")
				  {
				  	alert("主键类型不能为空!");
				  	return false ;
				  }
				  
				  //当主键类型为sequence为时,自定义主键不能空
				  var keyGenerator = document.all.keyGenerator.value ;
				  if(keyType == "sequence")
				  {
				  	if(keyGenerator.replace(/\s/g,"") == "" || keyGenerator.length < 1)
				  	{
				  		alert("当主键类型为sequence时,自定义主键不能空!");
				  		return false ;
				  	}
				  }
				  
				  
				  
				  document.all("save").disabled = true ;
				  document.all("reset").disabled = true ;
				  document.all("back").disabled = true ;
				  
				  document.tableForm.action = "updatetableinfo_do.jsp";
				  document.tableForm.target = "hiddenFrame";
				  document.tableForm.submit();
			}
		</script>
	</head>

	<body class="contentbodymargin">
		<div id="contentborder">
			<form name="tableForm" action="" method="post"  >	
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr >    
					    <td align="center" class="detailtitle" width="15%" nowrap>数据源名称</td>
					    <td class="detailcontent" width="20%" nowrap>
					  		<input type="text" name="db" value="<%=db%>" size="35" readOnly="readOnly"/>  	
					    </td>	
					    
						<td align="center" class="detailtitle" width="15%" nowrap>数据表名称</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input type="text" name="tableName" value="<%=tableName%>" size="45" readOnly="readOnly"/>  	
					    </td>	   
					  </tr>
					  
					   <tr>
					  	<td align="center" class="detailtitle" width="15%" nowrap>主键名称</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<select name="keyName" id="keyName">
								<option value="">--请选择主键的名称--
								<%
									//获取表的字段信息
									DBUtil dbUtil = new DBUtil();
									Set keyMetaDataSet = dbUtil.getPrimaryKeyMetaDatas(db,tableName);
									for (Iterator iter = keyMetaDataSet.iterator(); iter.hasNext();) 
									{
										PrimaryKeyMetaData primaryKeyMetaData = (PrimaryKeyMetaData) iter.next();
										String columnName =primaryKeyMetaData.getColumnName();
								%>
     							<option value="<%=columnName%>" <%=keyName.equalsIgnoreCase(columnName) ? "selected" : ""%> ><%=columnName%>
								<%
									}		
												
								%>
							</select>
					    </td>
						<td class="detailcontent" width="15%" nowrap>主键类型</td>	   
						<td class="detailcontent" width="*" nowrap>
							<select name="keyType">
								<option value="">----请选择主键的类型----
								<option value="string" <%=keyType.equals("string") ? "selected" : ""%> >文本型
								<option value="int" <%=keyType.equals("int") ? "selected" : ""%> >数字型
								<option value="sequence" <%=keyType.equals("sequence") ? "selected" : ""%> >sequence
							</select>
						</td>
					  </tr> 
					  
					  <tr>
					    <td align="center" class="detailtitle" width="15%" nowrap>主键递增量</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<input name="keyIncrement" type="text" size="35" value="<%=keyIncrement%>"/>
					    </td>	
						<td align="center" class="detailtitle" width="15%" nowrap>主键当前值</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input name="currentKeyValue" type="text" size="45" value="<%=currentKeyValue%>"/>
						</td>
					  </tr>
					  
					  <tr>
					    <td align="center" class="detailtitle" width="15%" nowrap>自定义主键</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<input name="keyGenerator" type="text" size="35" value="<%=keyGenerator%>"/>
					    </td>	
						<td align="center" class="detailtitle" width="15%" nowrap>关键字前缀</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input name="keyPrefix" type="text" size="45" value="<%=keyPrefix%>"/>
					    </td>	
					  </tr>
					    
					  <tr>
					  	<td colspan="4" class="detailcontent" align="center" height="30">
					  		<input type="button" name="save" value="保存" class="input" onclick="addInfo()"/>&nbsp;&nbsp;
					  		<input type="reset" name="reset" value="重置" class="input"/>&nbsp;&nbsp;
					  		<input type="button" name="back" value="返回" class="input" onclick="window.close();"/>	
					  	</td>
					  </tr>
				</table>	
			</form>
		</div>
		<iframe src="" width="0" height="0" name="hiddenFrame"></iframe>
	</body>
</html>

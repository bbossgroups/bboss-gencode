
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManager"%>
<%@ page import="com.frameworkset.platform.dbmanager.TableInfoManagerImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%
	    
	    String db = (String)request.getParameter("db");
%>

<html>
	<head>     
    	<title>主键表的新增页面</title> 
		<%@ include file="/include/css.jsp"%>
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
				  
				  document.tableForm.action = "addtableinfo_do.jsp";
				  document.tableForm.target = "hiddenFrame";
				  document.tableForm.submit();
			}
			
			
			//根据选择的数据源名称,获取需要的数据表名称
			//function getOpTable()
			//{
				//var dbName = document.all.dbName.value ;
				//hiddenFrame.location.href = "gettablename.jsp?dbName="+ dbName ;
			//}
			
			//根据选择的数据源名及表名,获取所有列名
			function getOpColumn()
			{
				var dbName = document.all.dbName.value;
				var tableName = document.all.tableName.value ;
				hiddenFrame.location.href = "getcolumnname.jsp?dbName=" + dbName +"&tableName="+tableName;
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
					    	<input type="text" name="dbName" value="<%=db%>" readonly="readonly" size="35"/>
					    </td>	
					    
						<td align="center" class="detailtitle" width="15%" nowrap>数据表名称</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<select name="tableName" id="tableName" onchange="getOpColumn()">
								<option value="">&nbsp;&nbsp;--------请选择数据表名称--------&nbsp;&nbsp;
								<%							
									List tablesList = null;
									//获取TableInfo表中没有数据表名称
									try
									{
										TableInfoManager tableInfoManager = new TableInfoManagerImpl();
										tablesList =  tableInfoManager.getTablesByDBName(db,false);
									}catch(Exception e)
									{
										e.printStackTrace();
									}
									if(tablesList == null)
									{
										tablesList = new ArrayList();
									}
									
									if(tablesList.size() >0)
									{
										for(int i=0; i<tablesList.size(); i++)
										{
											String tableName = (String) tablesList.get(i);
							    %>
							    		<option value="<%=tableName%>"> <%=tableName%>
							    <%
										}
									}
								%>
							</select>
					    </td>	   
					  </tr>
					  
					  <tr>
					  	<td align="center" class="detailtitle" width="15%" nowrap>主键名称</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<select name="keyName" id="keyName">
								<option value="">--请选择主键的名称--
							</select>
					    </td>
						<td class="detailcontent" width="15%" nowrap>主键类型</td>	   
						<td class="detailcontent" width="*" nowrap>
							<select name="keyType">
								<option value="">----请选择主键的类型----
								<option value="string">文本型
								<option value="int">数字型
								<option value="sequence">sequence
							</select>
						</td>
					  </tr> 
					  
					  <tr>
					    <td align="center" class="detailtitle" width="15%" nowrap>主键递增量</td>
					    <td class="detailcontent" width="20%" nowrap>
					    	<input name="keyIncrement" type="text" size="35" value="1"/>
					    </td>	
						<td align="center" class="detailtitle" width="15%" nowrap>主键当前值</td>
					    <td class="detailcontent" width="*" nowrap>
					    	<input name="currentKeyValue" type="text" size="45" value="0"/>
						</td>
					  </tr>
					  
					  <tr>
					    <td align="center" class="detailtitle">自定义主键</td>
					    <td class="detailcontent">
					    	<input name="keyGenerator" type="text" size="35"/>
					    </td>	
						<td align="center" class="detailtitle">主键前缀</td>
					    <td class="detailcontent">
					    	<input name="keyPrefix" type="text" size="45"/>
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
		<iframe id="hiddenFrame" width="0" height="0" name="hiddenFrame"></iframe>
	</body>
</html>

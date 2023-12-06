
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Enumeration"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>




<%
	
	String tableName = request.getParameter("tableName");
	String keyName = request.getParameter("keyName");
	String keyType = request.getParameter("keyType");
	
	tableName = tableName == null ? "" : tableName;
	keyName = keyName == null ? "" : keyName;
	keyType = keyType == null ? "" : keyType ;
	
%>
<html>
	<head>
		<title>属性容器</title>
		
		<%@ include file="/include/css.jsp"%>
		<script language="JavaScript">	
			//清除查询条件
			function clearInfos()
			{
				tableInfoForm.tableName.value = "";
				tableInfoForm.keyName.value = "";
				tableInfoForm.keyType.options[0].selected = "selected" ;
			}
			
			//注意:该方法在 onload()加载  查询加载
			function query()
			{
				tableInfoForm.action = "tableinfoList.jsp?db=" + document.all.db.value;
				tableInfoForm.target = "queryList";	
				tableInfoForm.submit();
			}
		</script>
	<body class="contentbodymargin" onload="query()">
		
		<div id="contentborder" align="center">
			<form name="tableInfoForm" action="" method="post">
			<div>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
						<td width="10%" nowrap>数据源名称:</td>
						<td width="15%" nowrap>
							<select name="db">
								<%
									DBUtil db = new DBUtil();
									Enumeration enum_ =   db.getAllPoolnames();
									while(enum_.hasMoreElements())
									{
										String dbName = (String)enum_.nextElement();
								%>
									<option value="<%=dbName%>"> &nbsp;&nbsp;<%=dbName%>&nbsp;&nbsp;
								<%
									}
								%>
							</select>
						</td>
						<td width="10%" nowrap>表的名称:</td>
						<td width="15%" nowrap>
							<input type="text" name="tableName" size="20" value="<%=tableName%>"/>
						</td>
						<td width="10%" nowrap>主键名称:</td>
						<td width="10%" nowrap>
							<input type="text" name="keyName" size="15" value="<%=keyName%>"/>
						</td>
						<td width="10%" nowrap>主键类型:</td>
						<td width="18%" nowrap>
							<select name="keyType">
								<option value="">--请选择关键类型--
								<option value="string">文本型
								<option value="int">数字型
								<option value="sequence">sequence
							</select>
						</td>
						<td align="center">
							<input type="button" name="queryButton" value="查询" class="input" onclick="query()"/>&nbsp;&nbsp;
							<input type="button" name="resetButton" value="重置" class="input" onclick="clearInfos()"/>
						</td>
					</tr>
				</table>
			</div>
			<hr/>
			
			<iframe src="" name="queryList" frameborder="0" width="100%" height="480px">
	</body>
</html>


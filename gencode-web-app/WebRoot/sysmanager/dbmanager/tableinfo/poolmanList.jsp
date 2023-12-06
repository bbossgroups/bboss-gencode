
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Enumeration"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<html>
	<head>
		<title>属性容器</title>
		<%@ include file="/include/css.jsp"%>
		
		<script language="javascript" type="text/javascript">
			function lookInfo(name)
			{
				if(name != "")
				{
					window.open("${pageContext.request.contextPath}/monitor/dbmonitor_.jsp?ds="+name);
				}
			}
		</script>
	<body class="contentbodymargin">
		<br />
		<br />
		<div align="left">
			<table>
				<tr>
					<%
						DBUtil db = new DBUtil();
						Enumeration poolNames = db.getAllPoolnames();
						while (poolNames.hasMoreElements()) 
						{
							String poolName = (String) poolNames.nextElement();

				   %>
					<td>
						<img src="../../images/Datasource.gif" width="35" 
								height="35" style="cursor:hand" onclick="lookInfo('<%=poolName%>')" />
						<br />
						<%=poolName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				 <%
					   }
				 %>
				</tr>
			</table>
		</div>
	</body>
</html>


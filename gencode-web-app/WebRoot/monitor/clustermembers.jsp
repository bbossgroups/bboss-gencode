<%@page import="org.frameworkset.remote.EventUtils"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.frameworkset.common.poolman.monitor.PoolmanStatic"%>
<%@page import="com.frameworkset.common.poolman.monitor.PoolMonitorServiceImpl"%>
<%@page import="com.frameworkset.common.poolman.monitor.AbandonedTraceExt"%>
<%
/*
 * <p>Title: 监控集群节点信息</p>
 * <p>Description: 连接池使用情况</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: bboss</p>
 * @Date 2008-9-8
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page session="false" contentType="text/html; charset=UTF-8" language="java" import="java.util.List"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil,org.jgroups.Address"%>

<%@page import="java.util.*"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>		
<%

boolean remoteevent_enabled = EventUtils.remoteevent_enabled();
request.setAttribute("remoteevent_enabled", remoteevent_enabled);	
if(remoteevent_enabled)
{
	List<Address> addresses = EventUtils.getRPCAddresses();
	
	request.setAttribute("addresses", addresses);	
	request.setAttribute("localaddress", EventUtils.getLocalAddress());	
}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>集群节点监控</title>
<%@ include file="/include/css.jsp"%>

		<script type="text/javascript" language="Javascript">
		function flushBotton(){
			document.location = document.location;
		}
		
		
		</script>

		</head>

	<body >	
 
	<div class="title_box">
				<div class="rightbtn">
				<a href="javascript:void(0)" class="bt_small"  onclick="flushBotton()" id="addButton"><span>刷新页面</span></a>
				</div>
				<font color="blue">
				<strong>集群状态：<pg:true actual="${remoteevent_enabled }" evalbody="true"><pg:yes>启用</pg:yes><pg:no>关闭</pg:no></pg:true></strong>
				<strong>集群节点-共<pg:size requestKey="traceobjects"/>个活动节点</strong>
				</font>
				 		
	</div>
	 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="stable" id="tb">
		<tr> <td width="40%"><strong>当前节点: <font color="blue"><pg:notnull actual="${localaddress }" >${localaddress }</pg:notnull></strong></font></td></tr>
		<tr> <td width="40%"><strong>节点清单</strong>  </td></tr>
			<pg:list requestKey="addresses">
			<tr>
			 
			<td><pg:equal value="${localaddress }" evalbody="true" >
			<pg:yes><font color="red"><pg:cell/> </font></pg:yes>
			<pg:no><font color="green"><pg:cell/> </font></pg:no>
			</pg:equal></td>
			 </tr>
			</pg:list>
		</table>	
	


				</body>
</html>
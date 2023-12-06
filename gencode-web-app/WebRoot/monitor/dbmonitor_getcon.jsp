<%
/*
 * <p>Title: 监控连接池信息</p>
 * <p>Description: 连接池使用情况</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: bboss</p>
 * @Date 2008-9-8
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page session="false" contentType="text/html; charset=UTF-8" language="java" import="com.frameworkset.common.poolman.util.SQLManager"%>
<%@ page import="java.sql.Connection"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
		
<%
	Connection connection = SQLManager.getInstance().requestConnection();
	out.print(connection);
	connection.createStatement().execute("select 1 from listbean");
	out.println();
%>


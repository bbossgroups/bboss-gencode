
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.util.JDBCPoolMetaData"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
	
	String ds = request.getParameter("ds") ;
	
	DBUtil db = new DBUtil();
	
	JDBCPoolMetaData metaData = db.getJDBCPoolMetaData(ds);
	
%>
<html>
	<head>
		<title>数据源信息</title>
		<%@ include file="/include/css.jsp"%>
	</head>
	<body class="contentbodymargin">		
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
				<tr class="labeltable_middle_td">
					<!--设置分页表头-->
		    		<td height='20' class="headercolor" width="15%" nowrap>参数名称</td>
					<td height='20' class="headercolor" width="30%" nowrap>参数值</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>dbname</td>
					<td>
						<%=metaData.getDbname()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>loadmetadata</td>
					<td>
						<%=metaData.getLoadmetadata()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>jndiName</td>
					<td>
						<%=metaData.getJNDIName()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>driver</td>
					<td>
						<%=metaData.getDriver()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>url</td>
					<td>
						<%=metaData.getURL()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>username</td>
					<td>
						<%=metaData.getUserName()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>password</td>
					<td>
						<%=metaData.getPassword()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>txIsolationLevel</td>
					<td>
						<%=metaData.getTxIsolationLevel()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>nativeResults</td>
					<td>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>poolPreparedStatements</td>
					<td>
						
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>initialConnections</td>
					<td>
						<%=metaData.getInitialConnections()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>minimumSize</td>
					<td>
						<%=metaData.getMinimumSize()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>maximumSize</td>
					<td>
						<%=metaData.getMaximumSize()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>maximumSoft</td>
					<td>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>maxWait</td>
					<td>
						<%=metaData.getMaxWait()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>removeAbandoned</td>
					<td>
						<%=metaData.getRemoveAbandoned()%>
					</td>
				</tr>
				
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>userTimeout</td>
					<td>
						<%=metaData.getUserTimeout()%>
					</td>
				</tr>

            <tr>
                <td>TimeBetweenEvictionRunsMillis</td>
                <td height="25"><%=metadata.getTimeBetweenEvictionRunsMillis() %></td>
                <td>180秒</td>
                <td>回收空闲链接操作间隔时间,毫秒为单位，缺省为180秒</td>
            </tr>


            <tr>
                <td>MinEvictableIdleTimeMillis</td>
                <td height="25"><%=metadata.getMinEvictableIdleTimeMillis() %></td>
                <td>30分钟</td>
                <td>
                    单位：毫秒;
                    空闲链接回收时间，空闲时间超过指定的值时，将被回收;缺省为30分钟</td>
            </tr>

            <tr>
                <td>NumTestsPerEvictionRun</td>
                <td height="25"><%=metadata.getNumTestsPerEvictionRun() %></td>
                <td>5</td>
                <td>每次回收的链接数,回收进程每次最多回收的空闲链接数，缺省值是5</td>
            </tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>keygenerate</td>
					<td>
						<%=metaData.getKeygenerate()%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>活动连接数</td>
					<td>
						<%=db.getNumActive(ds)%>
					</td>
				</tr>
				<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
					<td>不活动连接数</td>
					<td>
						<%=db.getNumIdle(ds)%>
					</td>
				</tr>
		</table>
	</body>
</html>


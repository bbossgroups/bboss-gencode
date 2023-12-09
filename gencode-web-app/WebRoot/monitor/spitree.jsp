<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>

<%@ taglib prefix="tab" uri="/WEB-INF/pager-taglib.tld" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
/*
 * <p>Title: SPI服务监控树</p>
 * <p>Description: SPI服务监控树</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: bboss</p>
 * @Date 2008-9-8
 * @author biaoping.yin
 * @version 1.0
 */
 String rootpath = request.getContextPath();
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/include/treeview.css">
<%@ include file="/include/css.jsp"%>
		
		
	</head>

<body  >

 
<div id="contentborder" style="width=100%;height:89%;overflow:auto">
    <table>
        <tr><td align="left"> 
         <tree:tree tree="spitree"
    	           node="spitree.node"
    	           imageFolder="/monitor/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="#"
    			   target="configfileDetail" 
    			   mode="static-dynamic"> 
    			   <tree:treedata treetype="org.frameworkset.spi.monitor.SPITree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="SPI管理"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   enablecontextmenu="false"
    	                   />
    	          
    	</tree:tree>
         </td></tr>
    </table>
</div>
 
	

</body>
</html>
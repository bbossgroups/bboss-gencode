<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<!-- 
	描述:MS分页测试管理分页列表界面。
	作者:yin
	版权:bboss
	版本:v1.0 
	日期:2016-01-15 01:39:06
-->

<div id="customContent">
<pg:empty actual="${appBoms}" evalbody="true">
    <pg:yes>
	<div class="nodata">
	没有数据
	</div>
	</pg:yes>
	<pg:no>
		<pg:pager scope="request"  data="appBoms" desc="true" isList="false" containerid="custombackContainer" selector="customContent">
		<pg:param name="bm"/>
		<!-- 加入 class="tableOutline" 可控制表格宽度，滚动条展示 -->
		<div id="changeColor" >
		 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="stable" id="tb">
	        <pg:header>
	            <th align=center><input id="CKA" name="CKA" type="checkbox" 
								onClick="checkAll('CKA','CK')">
								</th>
				<th>序号</th>				
	       		<th><pg:message code="sqlserver.id"/></th>
	       		<th><pg:message code="sqlserver.appName"/></th>
	       		<th><pg:message code="sqlserver.appNameEn"/></th>
	       		<th><pg:message code="sqlserver.applyDomain"/></th>
	       		<pg:title sort="true" type="th" align="center" colName="BM"  titlecode="sqlserver.bm"/>
	       		<th><pg:message code="sqlserver.dbType"/></th>
	       		<th><pg:message code="sqlserver.departmentDevelop"/></th>
	       		<th><pg:message code="sqlserver.departmentMaintain"/></th>
	       		<th><pg:message code="sqlserver.description"/></th>
	       		<th><pg:message code="sqlserver.developTool"/></th>
	       		<th><pg:message code="sqlserver.domainUrl"/></th>
	       		<th><pg:message code="sqlserver.evolveDepart"/></th>
	       		<th><pg:message code="sqlserver.evolvePlan"/></th>
	       		<th><pg:message code="sqlserver.evolveStrategy"/></th>
	       		<th><pg:message code="sqlserver.mainDescription"/></th>
	       		<th><pg:message code="sqlserver.manageScope"/></th>
	       		<th><pg:message code="sqlserver.planType"/></th>
	       		<th><pg:message code="sqlserver.productManager"/></th>
	       		<th><pg:message code="sqlserver.rdType"/></th>
	       		<th><pg:message code="sqlserver.softLanguage"/></th>
	       		<th><pg:message code="sqlserver.softLevel"/></th>
	       		<th><pg:message code="sqlserver.startYear"/></th>
	       		<th><pg:message code="sqlserver.state"/></th>
	       		<th><pg:message code="sqlserver.structMode"/></th>
	       		<th><pg:message code="sqlserver.supplier"/></th>
	       		<th><pg:message code="sqlserver.sysManager"/></th>
	       		<th><pg:message code="sqlserver.versionNo"/></th>
				<th>操作</th>
	       	</pg:header>	
	      <pg:list>
	
	   		<tr onDblClick="viewAppBom('<pg:cell colName="id"   />')">
	   		        <td class="td_center">
	                    <input id="CK" type="checkbox" name="CK" onClick="checkOne('CKA','CK')" value="<pg:cell colName="id"   />"/>
	                    <input id="id" type="hidden" name="id" value="<pg:cell colName="id"   />"/></td>
	                <td><pg:rowid increament="1" offset="false"/></td>    
	                <td><pg:cell colName="id"  /></td>
	                <td><pg:cell colName="appName"  /></td>
	                <td><pg:cell colName="appNameEn"  /></td>
	                <td><pg:cell colName="applyDomain"  /></td>
	                <td><pg:cell colName="bm"  /></td>
	                <td><pg:cell colName="dbType"  /></td>
	                <td><pg:cell colName="departmentDevelop"  /></td>
	                <td><pg:cell colName="departmentMaintain"  /></td>
	                <td><pg:cell colName="description"  /></td>
	                <td><pg:cell colName="developTool"  /></td>
	                <td><pg:cell colName="domainUrl"  /></td>
	                <td><pg:cell colName="evolveDepart"  /></td>
	                <td><pg:cell colName="evolvePlan"  /></td>
	                <td><pg:cell colName="evolveStrategy"  /></td>
	                <td><pg:cell colName="mainDescription"  /></td>
	                <td><pg:cell colName="manageScope"  /></td>
	                <td><pg:cell colName="planType"  /></td>
	                <td><pg:cell colName="productManager"  /></td>
	                <td><pg:cell colName="rdType"  /></td>
	                <td><pg:cell colName="softLanguage"  /></td>
	                <td><pg:cell colName="softLevel"  /></td>
	                <td><pg:cell colName="startYear"  /></td>
	                <td><pg:cell colName="state"  /></td>
	                <td><pg:cell colName="structMode"  /></td>
	                <td><pg:cell colName="supplier"  /></td>
	                <td><pg:cell colName="sysManager"  /></td>
	                <td><pg:cell colName="versionNo"  /></td>
	        		
	                <td class="td_center"><a href="javascript:void(0)" id="readAppBom" onclick="viewAppBom('<pg:cell colName="id"  />')">查看</a><a href="javascript:void(0)" id="editAppBom" onclick="editAppBom('<pg:cell colName="id"  />')">编辑</a><a href="javascript:void(0)" id="delAppBom" onclick="delAppBom('<pg:cell colName="id"  />')">删除</a></td>    
	                 
	        </tr>
		 </pg:list>
	    </table>
	    </div>
		<div class="pages"><input type="hidden" value="<pg:querystring/>" id="querystring"/><pg:index tagnumber="10" sizescope="5,10,20,50,100"/></div>
	
	    </pg:pager>
	</pg:no>
</pg:empty> 
</div>		

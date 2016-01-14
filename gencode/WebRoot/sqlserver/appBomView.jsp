<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<!-- 
	描述:查看MS分页测试界面。
	作者:yin
	版权:bboss
	版本:v1.0 
	日期:2016-01-15 01:39:06
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>查看<pg:message code="sqlserver.sqlserver"/></title>
<%@ include file="/include/css.jsp"%>
</head>
<body>
		<div class="mcontent">
			<div id="searchblock">
				<pg:beaninfo requestKey="appBom">
				<form id="editForm" name="editForm">
				  						<table border="0" cellpadding="0" cellspacing="0"
						class="table4">
																								<tr>
												<th width=85px >
							<pg:message code="sqlserver.id"/>：
						</th>
						<td width=140px>
							<input id="id" name="id" type="text" value="<pg:cell colName="id"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.appName"/>：
						</th>
						<td width=140px>
							<input id="appName" name="appName" type="text" value="<pg:cell colName="appName"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.appNameEn"/>：
						</th>
						<td width=140px>
							<input id="appNameEn" name="appNameEn" type="text" value="<pg:cell colName="appNameEn"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.applyDomain"/>：
						</th>
						<td width=140px>
							<input id="applyDomain" name="applyDomain" type="text" value="<pg:cell colName="applyDomain"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.bm"/>：
						</th>
						<td width=140px>
							<input id="bm" name="bm" type="text" value="<pg:cell colName="bm"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.dbType"/>：
						</th>
						<td width=140px>
							<input id="dbType" name="dbType" type="text" value="<pg:cell colName="dbType"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.departmentDevelop"/>：
						</th>
						<td width=140px>
							<input id="departmentDevelop" name="departmentDevelop" type="text" value="<pg:cell colName="departmentDevelop"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.departmentMaintain"/>：
						</th>
						<td width=140px>
							<input id="departmentMaintain" name="departmentMaintain" type="text" value="<pg:cell colName="departmentMaintain"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.description"/>：
						</th>
						<td width=140px>
							<input id="description" name="description" type="text" value="<pg:cell colName="description"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.developTool"/>：
						</th>
						<td width=140px>
							<input id="developTool" name="developTool" type="text" value="<pg:cell colName="developTool"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.domainUrl"/>：
						</th>
						<td width=140px>
							<input id="domainUrl" name="domainUrl" type="text" value="<pg:cell colName="domainUrl"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.evolveDepart"/>：
						</th>
						<td width=140px>
							<input id="evolveDepart" name="evolveDepart" type="text" value="<pg:cell colName="evolveDepart"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.evolvePlan"/>：
						</th>
						<td width=140px>
							<input id="evolvePlan" name="evolvePlan" type="text" value="<pg:cell colName="evolvePlan"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.evolveStrategy"/>：
						</th>
						<td width=140px>
							<input id="evolveStrategy" name="evolveStrategy" type="text" value="<pg:cell colName="evolveStrategy"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.mainDescription"/>：
						</th>
						<td width=140px>
							<input id="mainDescription" name="mainDescription" type="text" value="<pg:cell colName="mainDescription"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.manageScope"/>：
						</th>
						<td width=140px>
							<input id="manageScope" name="manageScope" type="text" value="<pg:cell colName="manageScope"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.planType"/>：
						</th>
						<td width=140px>
							<input id="planType" name="planType" type="text" value="<pg:cell colName="planType"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.productManager"/>：
						</th>
						<td width=140px>
							<input id="productManager" name="productManager" type="text" value="<pg:cell colName="productManager"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.rdType"/>：
						</th>
						<td width=140px>
							<input id="rdType" name="rdType" type="text" value="<pg:cell colName="rdType"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.softLanguage"/>：
						</th>
						<td width=140px>
							<input id="softLanguage" name="softLanguage" type="text" value="<pg:cell colName="softLanguage"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.softLevel"/>：
						</th>
						<td width=140px>
							<input id="softLevel" name="softLevel" type="text" value="<pg:cell colName="softLevel"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.startYear"/>：
						</th>
						<td width=140px>
							<input id="startYear" name="startYear" type="text" value="<pg:cell colName="startYear"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.state"/>：
						</th>
						<td width=140px>
							<input id="state" name="state" type="text" value="<pg:cell colName="state"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.structMode"/>：
						</th>
						<td width=140px>
							<input id="structMode" name="structMode" type="text" value="<pg:cell colName="structMode"    />" readonly/>
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.supplier"/>：
						</th>
						<td width=140px>
							<input id="supplier" name="supplier" type="text" value="<pg:cell colName="supplier"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.sysManager"/>：
						</th>
						<td width=140px>
							<input id="sysManager" name="sysManager" type="text" value="<pg:cell colName="sysManager"    />" readonly/>
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.versionNo"/>：
						</th>
						<td width=140px>
							<input id="versionNo" name="versionNo" type="text" value="<pg:cell colName="versionNo"    />" readonly/>
						</td>
											</tr>	
																	
					</table>
				
				
				<div class="btnarea" >
					<a href="javascript:void(0)" class="bt_2" id="closeButton" onclick="closeDlg()"><span>退出</span></a>
				</div>	
				</form>
				</pg:beaninfo>
			</div>
			
  
  	</div>					
</body>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<!-- 
	描述:添加MS分页测试界面。
	作者:yin
	版权:bboss
	版本:v1.0 
	日期:2016-01-15 01:39:06
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>新增MS分页测试</title>
		<%@ include file="/include/css.jsp"%>
	</head>
	<body>
		<div class="form_box">
			<form id="addForm" name="addForm" method="post">
			
				<table border="0" cellpadding="0" cellspacing="0" class="table4">
																								<tr>
												<th width=85px >
							<pg:message code="sqlserver.id"/>：
						</th>
						<td width=140px>
															<input id="id" name="id" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.appName"/>：
						</th>
						<td width=140px>
															<input id="appName" name="appName" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.appNameEn"/>：
						</th>
						<td width=140px>
															<input id="appNameEn" name="appNameEn" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.applyDomain"/>：
						</th>
						<td width=140px>
															<input id="applyDomain" name="applyDomain" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.bm"/>：
						</th>
						<td width=140px>
															<input id="bm" name="bm" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.dbType"/>：
						</th>
						<td width=140px>
															<input id="dbType" name="dbType" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.departmentDevelop"/>：
						</th>
						<td width=140px>
															<input id="departmentDevelop" name="departmentDevelop" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.departmentMaintain"/>：
						</th>
						<td width=140px>
															<input id="departmentMaintain" name="departmentMaintain" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.description"/>：
						</th>
						<td width=140px>
															<input id="description" name="description" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.developTool"/>：
						</th>
						<td width=140px>
															<input id="developTool" name="developTool" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.domainUrl"/>：
						</th>
						<td width=140px>
															<input id="domainUrl" name="domainUrl" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.evolveDepart"/>：
						</th>
						<td width=140px>
															<input id="evolveDepart" name="evolveDepart" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.evolvePlan"/>：
						</th>
						<td width=140px>
															<input id="evolvePlan" name="evolvePlan" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.evolveStrategy"/>：
						</th>
						<td width=140px>
															<input id="evolveStrategy" name="evolveStrategy" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.mainDescription"/>：
						</th>
						<td width=140px>
															<input id="mainDescription" name="mainDescription" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.manageScope"/>：
						</th>
						<td width=140px>
															<input id="manageScope" name="manageScope" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.planType"/>：
						</th>
						<td width=140px>
															<input id="planType" name="planType" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.productManager"/>：
						</th>
						<td width=140px>
															<input id="productManager" name="productManager" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.rdType"/>：
						</th>
						<td width=140px>
															<input id="rdType" name="rdType" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.softLanguage"/>：
						</th>
						<td width=140px>
															<input id="softLanguage" name="softLanguage" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.softLevel"/>：
						</th>
						<td width=140px>
															<input id="softLevel" name="softLevel" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.startYear"/>：
						</th>
						<td width=140px>
															<input id="startYear" name="startYear" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.state"/>：
						</th>
						<td width=140px>
															<input id="state" name="state" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.structMode"/>：
						</th>
						<td width=140px>
															<input id="structMode" name="structMode" type="text" 								/>														
							
						</td>
																								</tr>						<tr>
												<th width=85px >
							<pg:message code="sqlserver.supplier"/>：
						</th>
						<td width=140px>
															<input id="supplier" name="supplier" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.sysManager"/>：
						</th>
						<td width=140px>
															<input id="sysManager" name="sysManager" type="text" 								/>														
							
						</td>
																							<th width=85px >
							<pg:message code="sqlserver.versionNo"/>：
						</th>
						<td width=140px>
															<input id="versionNo" name="versionNo" type="text" 								/>														
							
						</td>
											</tr>	
															</table>			
			
			<div class="btnarea" >
				<a href="javascript:void(0)" class="bt_1" id="addButton" onclick="dosubmit()"><span><pg:message code="sany.pdp.common.operation.add"/></span></a>
				<a href="javascript:void(0)" class="bt_2" id="resetButton" onclick="doreset()"><span><pg:message code="sany.pdp.common.operation.reset"/></span></a>
				<a href="javascript:void(0)" class="bt_2" id="resetButton" onclick="closeDlg()"><span><pg:message code="sany.pdp.common.operation.exit"/></span></a>
				<input type="reset" id="reset" style="display: none;" />
			</div>
			</form>
		</div>
	</body>
<script language="javascript">
var api = frameElement.api, W = api.opener;


   function dosubmit()
   {
		
		$.ajax({
		   type: "POST",
			url : "addAppBom.page",
			data :formToJson("#addForm"),
			dataType : 'json',
			async:false,
			beforeSend: function(XMLHttpRequest){
					var validated = $("#addForm").form('validate');
			      	if (validated){
			      		blockUI();	
			      		XMLHttpRequest.setRequestHeader("RequestType", "ajax");
			      	}
			      	else
			      	{			      		
			      		return false;
			      	}				 	
				},
			success : function(responseText){
				//去掉遮罩
				unblockUI();
				if(responseText=="success"){
					W.$.dialog.alert("新增记录成功",function(){	
							W.modifyQueryData();
							api.close();
					},api);													
				}else{
					W.$.dialog.alert("新增出错",function(){},api);
				}
			}
		  });
   	 }
function doreset(){
	$("#reset").click();
}
</script>
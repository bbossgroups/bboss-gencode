
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%
	//获取数据源名称
	String db = (String) request.getParameter("db");
%>
<html>
	<head>
		<title>属性容器</title>
		<%@ include file="/include/css.jsp"%>
		<script language="JavaScript">
			function addKeyInfo()
			{
				winuser = window.showModalDialog("addtableinfo.jsp?db=<%=db%>",
										 window,"dialogWidth:"+(650)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no");
				
					window.location.href = window.location.href ;
				
			}
			
			function updateKeyInfo()
			{
				
				var obj = document.getElementsByName("checkboxOne");
				
				var size = 0;
				var tablename = "";
				
				if(obj)
				{
					for(var i=0; i<obj.length; i++)
					{
						if(obj[i].checked)
						{
							size ++;
							tablename = obj[i].value ;
						}		
					}
				}
				
				if(size == 0)
				{
					alert("请选择要修改的记录!");
					return false ;
				}
				else if(size > 1)
				{
					alert("每次只能修改一条记录!");
					return false ;
				}
				
				winuser = window.showModalDialog("updatetableinfo.jsp?db=<%=db%>&tablename=" + tablename,window,"dialogWidth:"+(600)+"px;dialogHeight:"+(300)+"px;help:no;scroll:auto;status:no");
				
					window.location.href = window.location.href ;
			}
			
			
			
			function checkAll(totalCheck,checkName)
			{	//复选框全部选中
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
			   if(selectAll[0].checked==true)
			   {
				   for (var i=0; i<o.length; i++)
				   {
			      	  if(!o[i].disabled)
			      	  {
			      	  	o[i].checked=true;
			      	  }
				   }
			   }
			   else
			   {
				   for (var i=0; i<o.length; i++)
				   {
			   	  	  o[i].checked=false;
			   	   }
			   }
			}
			
			//单个选中复选框
			function checkOne(totalCheck,checkName)
			{
			   var selectAll = document.getElementsByName(totalCheck);
			   var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++)
				{
					if(!o[i].disabled){
						if (o[i].checked==false)
						{
							cbs=false;
						}
					}
				}
				if(cbs)
				{
					selectAll[0].checked=true;
				}
				else
				{
					selectAll[0].checked=false;
				}
			}	
			
				
			//删除操作
			function dealKeyInfo()
			{
			    
			    var obj = document.getElementsByName("checkboxOne");
			    var size = 0;
			    
			    if(obj)
			    {
			    	for(var i=0; i<obj.length; i++)
			    	{
			    		if(obj[i].checked)
			    		{
			    			size ++ ;	
			    		}
			    	}
			    }
			    
			    if (size > 0)
			    {
			    	
			    	var msg = "你确定要删除吗？(删除后是不可以再恢复的)";
		        	if(confirm(msg))
		        	{    
		        		
			            tableInfoOpForm.action = "deletetableinfo.jsp?db=<%=db%>";
			            tableInfoOpForm.target = "hiddenFrame";
						tableInfoOpForm.submit();
			        } 
			    }
			    else
			    {
			    	alert("至少要选择一条记录！");
			    	return false;
			   }
			}
		</script>
	<body class="contentbodymargin">
		<form action="" method="post" name="tableInfoOpForm">
			<div align="left">
				<input name="button" type="button" class="input"
	                                onclick="addKeyInfo()" value="新增">&nbsp;
				<input type="button" value="修改" class="input"
									onclick="updateKeyInfo()">&nbsp;
								  
				<input name="button" type="button" class="input"
									onclick="dealKeyInfo()" value="删除选中项">&nbsp;	
			</div>
			
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
				<pg:listdata dataInfo="com.frameworkset.platform.dbmanager.TableInfoSearchList" keyName="TableInfoSearchList" />
				<!--分页显示开始,分页标签初始化-->
				<pg:pager maxPageItems="15" scope="request" data="TableInfoSearchList" isList="false">
					<tr class="labeltable_middle_td">
						<!--设置分页表头-->
						<td class="headercolor" align=center>
			  				<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkboxOne')">
			  			</td>
			    		<td height='20' class="headercolor">表名称</td>
			    		<input class="text" type="hidden" name="selectId">
						<td height='20' class="headercolor">关键名称</td>
						<td height='20' class="headercolor">主键递增量</td>
						<td height='20' class="headercolor">主键当前值</td>
						<td height='20' class="headercolor">自定义主键</td>
						<td height='20' class="headercolor">关键字类型</td>
						<td height='20' class="headercolor">关键字前缀</td>
				</tr>
					<pg:param name="tableName"/>
					<pg:param name="keyName"/>
					<pg:param name="keyType"/>
					<pg:param name="db"/>
					
					<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有信息
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
					<pg:list>
						<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
							<td class="tablecells" align=center>
								<input onClick="checkOne('checkBoxAll','checkboxOne')" type="checkbox" name="checkboxOne" value="<pg:cell colName="tableName" defaultValue=""/>">
							</td>						      				
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="tableName" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="tableKeyName" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyIncrement" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="currentKeyValue" defaultValue="" />
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyGenerator" defaultValue=""/>
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyType" defaultValue=""/>
							</td>
							
							<td height='20' align=left class="tablecells">
								<pg:cell colName="keyPrefix" defaultValue=""/>
							</td>
							
						</tr>
					</pg:list>
					<tr height="30" class="labeltable_middle_tr_01">
						<td colspan=100 align='center'>
						  <pg:index />
						<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
					</tr>
				</pg:pager>
			</table>
		</form>
		<iframe src="" name="hiddenFrame" width="0" height="0"></iframe>
	</body>
</html>


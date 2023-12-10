<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="java.util.*"%>
<%@page import="com.frameworkset.common.poolman.sql.*"%>
<%@page import="com.frameworkset.common.poolman.util.*"%>
<%@taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<%

	
	String dsource = request.getParameter("dsource");
	String table_name = request.getParameter("table_name") ;
	
	//存放列名和类型: 列名|类型
	List columnNameAndTypeList = new ArrayList();
	
	if(dsource!=null && table_name != null && !"".equals(dsource) && !"".equals(table_name)){
		
		TableMetaData tableMeta  = SQLUtil.getTableMetaData(dsource,table_name);

		Set columnMetaDataSet = tableMeta.getColumns();
		
		Iterator iterator = columnMetaDataSet.iterator();
		
		for(;iterator.hasNext();){
			//将列名和类型存放在ArrayList中
			ColumnMetaData columnMetaData = (ColumnMetaData)iterator.next();	
			
			//String columnName = columnMetaData.getColumnName();
			//String columnType = columnMetaData.getTypeName();
			//String columnName_type = 	columnName +"_" + columnType;
			String columnName_type = columnMetaData.getColumnName() + "|" + columnMetaData.getTypeName();
			
			columnNameAndTypeList.add(columnName_type);
		}
	}
	
%>
 
 
<html>
	<head>
		<title>属性容器</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
		 
		 
			
		<tab:tabConfig/>
		 
		 
		<SCRIPT language="javascript">
			  var win;
			  var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
			  function getTables(e)
			  {
		      	var dsource = document.getElementById("dsource").value;
		        if(dsource !="")
		        {
					var path = "select_tableName.jsp?dsource=" + dsource + "&tablename=" + e.value;
					var win = window.open(path,window,featrue);
					/**
					if(!win)
					{
						e.value = '';
					}
					else
					{
						if(e.value != win)
						{
							e.value=win;
							var query = document.getElementById("query");
							//在获取表名的提交表单,从而确定是表的字段类型(注意:存在问题)
							 query.action = "tablesmanager.jsp";
							 query.target = "";
							query.submit();
						}
					}
                     */
				}
			}
            
            function queryTableData(tableName){
                var query = document.getElementById("query");
                //在获取表名的提交表单,从而确定是表的字段类型(注意:存在问题)
                var dsource = document.getElementById("dsource").value;
                
                query.action = "tablesmanager.jsp?dsource="+dsource +"&table_name="+tableName;
                query.target = "";
                query.submit();
            }
			
			function getFields(obj,index,targetObject)
			{
				var dsource = document.getElementById("dsource").value;
				var dname =  document.getElementById("table_name").value;
				if(dsource=='')
				{
					alert('请先选择数据库!!!!');
					return ;
				}
				
				if(dname == '')
				{
					alert('请选择数据库表!!!');
					return ;
				}
				
				
				var textOrDate = obj.options[obj.selectedIndex].value ;
	
				var arr = textOrDate.split("|");
							
				
				//对日期类型和非日期类型的处理				
				if(arr[1] == "DATE")
				{
				var strDate = "查询起止时间:" ;
					
				strDate += "<input type='text' name='startDate"+ index +"' size='10' onclick='showdate(document.all(\"startDate"+ index +"\"))' readonly='true'>";
				
				strDate +="到<input type='text' name='endDate"+ index +"' size='10' onclick='showdate(document.all(\"endDate"+ index +"\"))' readonly='true'>";

					
				document.getElementById("strOrDate" + index).innerHTML = strDate;
				}
				else
				{
					document.getElementById("strOrDate" + index).innerHTML = "请输入过滤条件:&nbsp;&nbsp;<input type='text' name='advancedvalue"+ index+ "'/>";
				}

			}
			
			var num = 1;
			function changeFlag(nFlag,condition)
			{
				//如果num是小于且状态为0返回
				if(num <=1 && nFlag == 0)
				{
					return;
				}
				if(nFlag == 1)
				{
					num ++;
				}else if(nFlag == 0)
				{
					num --;
				}
		
				if(num <1)
				{
					alert('no');
					return ;
				}
				
				var dataConditionsTable = document.getElementById("dataConditions")
                if(condition == 1){
                    var str = "";
                    //处理表的字段
                    str += "<tr><td colspan='2' height='30' valign='middle' align='center' width='255'>表字段:&nbsp;&nbsp;&nbsp;";

                    str += "<select name=advancedField" + num + " id=select" + num +"  onChange='getFields(this,"+ num +",document.getElementById(\"strOrDate"+ num +"\"))'>";
                    str += "<option value=''>--请选择表字段--" ;

                    <%
                            for(int i=0; i<columnNameAndTypeList.size(); i++)
                            {
                                String columnNameAndType = (String) columnNameAndTypeList.get(i);
                    %>
                    str += "<option value='<%=columnNameAndType%>'><%=columnNameAndType.substring(0,columnNameAndType.indexOf("|")) %>";
                    <%
                            }
                    %>
                    str +="</select></td>";
                    str += "<td colspan='2' height='30' valign='middle' align='center'> ";
                    str +="<div id='strOrDate"+ num +"'>请输入过滤条件:&nbsp;&nbsp;<input type='text' name='advancedvalue"+ num +"'/></div></td>";
                    str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
                    str += "<select name=logical"+ num+ "><option value='and' selected>并且<option value='or'>或者<option value='and not'>不包含 </option></select>";
                    str += "<input name='add' type='button' class='input' value='增加' onClick='changeFlag(1,1)'>&nbsp;&nbsp;"
                    str += "<input name='reduce' type='button' class='input' value='删除' onClick='changeFlag(0,0)'>";
                    str += "</td></tr>";
                    dataConditionsTable.insertAdjacentHTML("beforeend",str);
                    
                }
                else if(condition == 0){//删除当前行
                    event.target.parentElement.parentElement.remove();
                }
                /**
				 var str ="<table cellspacing='1' cellpadding='0' border='0' bordercolor='#EEEEEE' width=100% class='thin'>";
					for(var i=1; i<=num; i++)
					{
					
						//处理表的字段
						str += "<tr><td colspan='2' height='30' valign='middle' align='center' width='255'>表字段:&nbsp;&nbsp;&nbsp;";
						
							str += "<select name=advancedField" + i + " id=select" + i +"  onChange='getFields(this,"+ i +",document.getElementById(\"strOrDate"+ i +"\"))'>";
								str += "<option value=''>--请选择表字段--" ;
								
									<%
											for(int i=0; i<columnNameAndTypeList.size(); i++)
											{
												String columnNameAndType = (String) columnNameAndTypeList.get(i);
									%>
										str += "<option value='<%=columnNameAndType%>'><%=columnNameAndType.substring(0,columnNameAndType.indexOf("|")) %>";
									<%
											}
									%>
							str +="</select></td>";
							
							//处理文本框
							if(condition == 1)
							{
								if(i < num)
								{
									var selectObject  = document.getElementsByName("advancedField" +i)[0];
									var dateAndType = selectObject.options[selectObject.selectedIndex].value ;
									var arr = dateAndType.split("|");
									
									if(arr[1] == 'DATE')
									{
										if(document.all("startDate" + i) != null && document.all("endDate"+i) != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>查询起止时间:";
													str += "<input type='text' name='startDate"+ i +"' value='"+ document.getElementById('startDate'+ i ).value +"' size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "到<input type='text' name='endDate"+ i +"' value='"+ document.getElementById('endDate' +i).value +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>查询起止时间:";
													str += "<input type='text' name='startDate"+ i +"'  size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "到<input type='text' name='endDate"+ i +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
									}
									else
									{
										if(document.all("advancedvalue" + i) != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>请输入过滤条件:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"' value='"+ document.getElementsByName('advancedvalue'+i)[0].value +"'/>";
											str += "</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>请输入过滤条件:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"'/>";
											str += "</div></td>";
										}
									}
								}
								else if(i == num)
								{
									str += "<td colspan='2' height='30' valign='middle' align='center'> ";
									str +="<div id='strOrDate"+ i +"'>请输入过滤条件:&nbsp;&nbsp;<input type='text' name='advancedvalue"+ i +"'/></div></td>";
								}
							}
							else if(condition == 0)
							{
									var selectObject  = document.getElementsByName("advancedField" +i)[0];
									var dateAndType = selectObject.options[selectObject.selectedIndex].value ;
									var arr = dateAndType.split("|");
									
									if(arr[1] == 'DATE')
									{
										if(document.getElementById("startDate" + i) != null && document.getElementById("endDate"+i))
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>查询起止时间:";
													str += "<input type='text' name='startDate"+ i +"' value='"+ document.getElementById('startDate'+ i ).value +"' size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "到<input type='text' name='endDate"+ i +"' value='"+ document.getElementById('endDate' +i).value +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'>";
												str += "<div id='strOrDate"+ i +"'>查询起止时间:";
													str += "<input type='text' name='startDate"+ i +"'  size='10' onclick='showdate(document.all(\"startDate"+ i +"\"))' readonly='true'>";
													str += "到<input type='text' name='endDate"+ i +"' size='10' onclick='showdate(document.all(\"endDate"+ i +"\"))' readonly='true'>";
											str +="</div></td>";
										}
									}
									else
									{
										if(document.getElementsByName("advancedvalue" + i)[0] != null)
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>请输入过滤条件:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"' value='"+ document.getElementsByName('advancedvalue'+i)[0].value +"'/>";
											str += "</div></td>";
										}
										else
										{
											str += "<td colspan='2' height='30' valign='middle' align='center'> ";
												str +="<div id='strOrDate"+ i +"'>请输入过滤条件:&nbsp;&nbsp;";
													str += "<input type='text' name='advancedvalue"+ i +"'/>";
											str += "</div></td>";
										}
									}
							}
							
							
							//处理逻辑符
							if(i !=1)
							{
							
								str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
									str += "<select name=logical"+ i+ "><option value='and' selected>并且<option value='or'>或者<option value='and not'>不包含 </option></select>";
                                str += "<input name='add' type='button' class='input' value='增加' onClick='changeFlag(1,1)'>&nbsp;&nbsp;"
                                str += "<input name='reduce' type='button' class='input' value='减少' onClick='changeFlag(0,0)'>";
								str += "</td></tr>";
							
							}
							else 
							{
								str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
									str += "<input name='add' type='button' class='input' value='增加' onClick='changeFlag(1,1)'>&nbsp;&nbsp;"
									str += "<input name='reduce' type='button' class='input' value='减少' onClick='changeFlag(0,0)'>";
								str += "</td></tr>";
							}
					}
					
				str += "</table>";
				rememberSelectedField();
				rememberInputLogic();
				div1.innerHTML = str;
				selectField(condition);
				selectLogic();*/
				
			}
			
			var arrSelectIndex = "";
			function rememberSelectedField()
			{
				arrSelectIndex = "";
				for(var i=1;i<=num;i++)
				{
					var selectID = "select" + i;
					if (document.all( selectID ) != null)
					{
						arrSelectIndex += document.all( selectID ).selectedIndex + "|";
						
					}
				}
				//去除最后一个|字符
				if (arrSelectIndex.length > 1)
				{
					arrSelectIndex = arrSelectIndex.substring(0,arrSelectIndex.length - 1);
				}	
				
			}

			function selectField(condition)
			{
		
			    var arrIndex = arrSelectIndex.split('|');
				for(var i=1;i<= num;i++)
				{
					var selectID = "select" + i;
					//下拉框的长度
					var j = document.all( selectID ).length;
		
					if( j > i )
					{
						j = i-1;
					}
					else
					{
						j = j -1;
					}
		

					if(condition == 1)
					{	
						if(i == num)
						{
							document.all( selectID ).options(0).selected = true;
						}
						else
						{
							document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
						}
					}
					else if(condition == 0)
					{
						document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
					}
				}
			}
	
			var arrInputLogic = "";
			function rememberInputLogic()
			{
				arrInputLogic = "";
				for(var i=2;i<= num;i++)
				{
					var selectID = "logical" + i;
					if (document.all( selectID ) != null)
					{
					arrInputLogic += document.all( selectID ).value + "|";
					}
				}
				if (arrInputLogic.length > 1)
				{
					arrInputLogic = arrInputLogic.substring(0,arrInputLogic.length - 1);
				}	
			}

			function selectLogic()
			{
			   if (arrInputLogic=='') return;
				var arrIndex = arrInputLogic.split('|');
				for(var i=2;i<= num;i++)
				{
					if (arrIndex[i-2] != null && arrIndex[i-2] != '')
					{
						var selectID = "logical" + i;
						document.all( selectID ).value=arrIndex[i-2];
					}
				}
			}
			
			function checkData()
			{
					var dsource = document.getElementById("dsource").value;
					var query = document.getElementById("query");
					var table_name = document.getElementById("table_name").value;
				if(dsource=="" )
				{
					alert('请选择数据源!!!');
					document.getElementById("dsource").focus();
					return ;
				}
				if(table_name=="")
				{
					alert('请选择数据表!!!');
					document.getElementById("table_name").focus();
					return ;
				}
				
				if(validate("pageSize") == true)
				{
					document.getElementById("numCount").value = num;
					 query.action = "selectedtabList.jsp";
					 query.target = "queryList";
					query.submit();
				}
				else
				{
					return false;
				}
			}
			
			
			function checkSQLData()
			{
			    var dsource2 = document.getElementById("dsource2").value;	
				if(dsource2=="" )
				{
					alert('请选择数据源!!!');
					document.getElementById("dsource2").focus();
					return ;
				}
				 var sqlContent = document.getElementById("sqlContent").value;	
				if(sqlContent=="" || sqlContent.trim()=="")
				{
					alert('SQL语句不能为空!!!');
					document.getElementById("sqlContent").focus();
					return ;
				}
				
				if(validate("pageSize2")==true)
				{
					var sqlQuery = document.getElementById("sqlQuery")
					 sqlQuery.action = "sqltabList.jsp";
					 sqlQuery.target = "sqlList";
					sqlQuery.submit();
				}
				else
				{
					return false;
				}
			}	
			
			function validate(objectName)
		  	{
		  		var pageSizeNode = document.getElementById(objectName);
		  		var pageSizeValue = pageSizeNode.value;
		  		 		
		  		if(pageSizeValue =='')
		  		{
		  			alert("每页显示的记录条数不能为空!!!");
		  			pageSizeNode.value = 10;
		  			return false;
		  		}
		  		else if(pageSizeValue <= 0)
		  		{
		  			alert("每页记录条数必须是大于0!!!");
		  			pageSizeNode.value = 10;
		  			pageSizeNode.focus();
		  			return false;
		  		}
		  		else if(/^\d+$/.test(pageSizeValue) == false)
		  		{
		  			alert("每页记录条数必须是数字!!!");
		  			pageSizeNode.value = 10;
		  			pageSizeNode.focus();
		  			return  false;
		  		}
		  		return true;
		  	}
		</SCRIPT>
	</head>
	
	<body>
		<tab:tabContainer id="foo-menu-container" selectedTabPaneId="query-menu">
			<tab:tabPane id="query-menu" tabTitle="快速查询" lazeload="true">
				<form name="query" id="query" action="" method="post">
					<input type="hidden" name="numCount" id="numCount"/>
					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin">
						<tr valign='top'>
							<td height='30' valign='middle' colspan="5">
								<img src='<%=request.getContextPath() %>/include/images/edit.gif' width="16" height="16" border=0
									align='middle'>
								&nbsp;
								<strong>数据库表管理</strong>
							</td>
						</tr>
		
						<tr>
							<td colspan="1" height='30' valign='middle' align="center">
								数据源：
								<select name="dsource" id="dsource">
									<option value="">--请选择数据源--
									<%
										DBUtil db = new DBUtil();
										Enumeration dbPoolNameEnum = db.getAllPoolnames();
										
										for (; dbPoolNameEnum.hasMoreElements();) 
										{
											String dbPoolName = (String) dbPoolNameEnum.nextElement();
																
											String selected = dbPoolName.equals(dsource) ? "selected" : "";
											
									%>
									<option value="<%=dbPoolName%>" <%=selected %> >
										<%=dbPoolName%>
										<%
										}
										%>
								</select>
							</td>
		
						  <td colspan="2" height='30' valign='middle' align="center">
								请选择数据表:&nbsp;<input type="text" valign="middle" name="table_name" 
															value="<%=(table_name == null) ? "" : table_name%>" 
															id="table_name" align="center" readonly="readonly" 
															onclick="getTables(this)" size="35" />
						  </td>
						  <td colspan="1" height='30' valign='middle' align="center">
								每页显示记录数:<input name="pageSize" id="pageSize" type="text" value="6" size="15"/>
						  </td>
						 <td colspan="1" height='30' valign='middle' align="center">
							<input name="search" type="button" class="input" value="查询" onClick="checkData()"/>
						 </td>
						</tr>				
					</table>
					<br/>
					<br/>
					<div id="div1">
						<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin" id="dataConditions">
							<tr>
								<td colspan="2" height='30' valign='middle' align="center" width="255">
									表字段：&nbsp;&nbsp;&nbsp;
									<select name=advancedField1 id="select1" onChange="getFields(this,1,document.getElementById('strOrDate1'))">
										<option value="">--请选择表字段--
										<%
											for(int i=0; i<columnNameAndTypeList.size(); i++)
											{
												String columnNameAndType = (String) columnNameAndTypeList.get(i);
										%>
									  <option value="<%=columnNameAndType%>"><%=columnNameAndType.substring(0,columnNameAndType.indexOf("|")) %>
										<% 
											}
										 %>
									</select>
								</td>
								<td colspan="2" height='30' valign='middle' align="center">
									<div id="strOrDate1">
										请输入过滤条件:&nbsp;&nbsp;<input type="text" name="advancedvalue1"/>
									</div>
									
								</td>
								<td width="16%" height='30' colspan="1" align="center" valign='middle'>
									<input name="add" type="button" class="input" value="增加" onClick="changeFlag(1,1)">&nbsp;&nbsp;
									<input name="reduce" type="button" class="input" value="删除" onClick="changeFlag(0,0)">
							  </td>
							</tr>
						</table>
					</div>
				</form>
				<tab:iframe id="queryList" name="queryList" src="" frameborder="0" width="99%" height="350px"/>
			</tab:tabPane>
			
			<tab:tabPane id="sql-menu" tabTitle="数据库管理" lazeload="true">
				<form name="sqlQuery" id="sqlQuery" action="" method="post">
					<input type="hidden" name="numCount" id="numCount"/>
					<table cellspacing="1" cellpadding="0" border="0"
						bordercolor="#EEEEEE" width=98% class="thin">
						<tr valign='top'>
							<td height='30' valign='middle' colspan="5">
								<img src='<%=request.getContextPath() %>/include/images/edit.gif' width="16" height="16" border=0
									align='absmiddle'>
								&nbsp;
								<strong>数据库表管理</strong>
							</td>
						</tr>
		
						<tr>
							<td colspan="1" height='30' valign='middle' align="center" width="35%" nowrap>
								数据源：
								<select name="dsource2" id="dsource2">
									<option value="">--请选择数据源--
									<%
										DBUtil db2 = new DBUtil();
										Enumeration dbPoolNameEnum2 = db2.getAllPoolnames();
										
										for (; dbPoolNameEnum2.hasMoreElements();)
										 {
											String dbPoolName2 = (String) dbPoolNameEnum2.nextElement();
																
											String selected2 = dbPoolName2.equals(dsource) ? "selected" : "";
											
									%>
									<option value="<%=dbPoolName2%>" <%=selected2 %> >
										<%=dbPoolName2%>
										<%
										}
										%>
								</select>
							</td>
							<td colspan="1" valign='middle' align="center" width="15%" nowrap>
								每页显示记录数:&nbsp;<input name="pageSize2" id="pageSize2" type="text" value="6" size="8"/>
							</td>
							<td colspan="1" height='30' valign='middle' align="center" width="*" nowrap>
								<input name="search" type="button" class="input" value="执行" onClick="checkSQLData()"/>
								&nbsp;&nbsp;&nbsp;
								<input type="reset" class="input" value="重置"/>
							</td>
						</tr>
						<tr>
							<td colspan="1"  valign='middle' align="center">
								SQL语句:
							</td>
							<td colspan="2" valign='middle'>
								<textarea rows="5" name="sqlContent" id="sqlContent" cols="85"></textarea>
							</td>
						</tr>
					</table>
					<br/>
				<tab:iframe  id="sqlList" name="sqlList"  src="javascript:void(0)" frameborder="0" width="99%" height="350px"/>	
				 
			</tab:tabPane>
			
			<tab:tabPane id="tableinfo-menu" tabTitle="主键生成机制管理" lazeload="true">
				<tab:iframe id="tableinfo" name="tableinfo" src="tableinfo/tableinfoList_tab.jsp" frameborder="0" width="98%" height="550px"/>
			</tab:tabPane>
			
			<tab:tabPane id="poolmen-menu" tabTitle="连接池浏览" lazeload="true">
				<tab:iframe id="poolmen" name="poolmen" src="tableinfo/poolmanList.jsp" frameborder="0" width="100%" height="600px"/>
			</tab:tabPane>	
		</tab:tabContainer>
		<br/>
		<br/>	
	</body>
</html>

				

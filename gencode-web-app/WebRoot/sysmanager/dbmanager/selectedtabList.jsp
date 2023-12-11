
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.common.poolman.sql.PrimaryKeyMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.TableMetaData"%>
<%@ page import="com.frameworkset.common.poolman.sql.ColumnMetaData"%>
<%@ page import="com.frameworkset.common.poolman.util.SQLUtil"%>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.tag.pager.tags.PagerDataSet" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<html>
	<head>
		<title>属性容器</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
<%! 

	//获取更新和删除条件
	public String getCondition(String db,String tablename,PagerDataSet dataSet)
	{
		String cond = "";
		if(db != null && tablename != null && !db.equals("") && !tablename.equals(""))
		{
			Set set  =DBUtil.getPrimaryKeyMetaDatas(db,tablename);
			Iterator iterator = set.iterator();
			
			while(iterator.hasNext())
			{
				PrimaryKeyMetaData keyMetaData = (PrimaryKeyMetaData) iterator.next();
				String columnName = keyMetaData.getColumnName();
				String value = dataSet.getString(columnName);
				if(cond.equals(""))
				{
					cond += columnName + "= '" + value + "'";
				}
				else 
				{
					cond += " , " + columnName +" = '" + value + "'";
				}
			}
		}
		return cond.trim();
	}
    
    
	//获取condition field names;
	public List<Integer> getConditionIndexes(javax.servlet.http.HttpServletRequest httpServletRequest)
	{
		List<Integer> fields = new ArrayList<>();
        Enumeration paramNames = httpServletRequest.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            if(paramName.startsWith("advancedField")){
                String idx = paramName.substring("advancedField".length());
                fields.add(Integer.parseInt(idx));
            }
           
        }
		return fields;
	}
 %>

 <%

 	String str_numCount = request.getParameter("numCount");
 	String dsource = request.getParameter("dsource");
 	String tablename = request.getParameter("table_name");
 	 		 	
 	int numCount = 0;
 	
 	String sql = request.getParameter("sql"); 	
 	
 	if(sql == null || sql.equals(null) || sql.equals(""))
 	{
 		String condition = "";
 		if(dsource != null && tablename != null && !"".equals(dsource) && !"".equals(tablename))
 		{
             List<Integer> conditionIndexes = getConditionIndexes(request);
	 		if(conditionIndexes != null && conditionIndexes.size() > 0 )
	 		{
	 			 
	 			
	 			for(int i=0; i<conditionIndexes.size() ; i++)
	 			{
                     int idx = conditionIndexes.get(i);
	 				String fieldNameAndType = request.getParameter("advancedField" + idx);
	 				if(fieldNameAndType != null && !fieldNameAndType.equals(""))
	 				{
	 					int location = fieldNameAndType.indexOf("|");
		 				String fieldName = fieldNameAndType.substring(0,location);
		 				String fieldType = fieldNameAndType.substring(location+1); 
		 				
		 				String logical = request.getParameter("logical" +idx);	 				
		 				logical = logical ==null ? "" : logical;
	
		 				//处理日期类型
		 				if(fieldType.equals("DATE"))
		 				{
		 					String startDate = request.getParameter("startDate"+idx);
		 					String endDate = request.getParameter("endDate" + idx);
		 					
		 					if(startDate != null && !startDate.equals(""))
		 					{
		 						
		 						condition += logical + " " + fieldName + ">=to_date('" + startDate +" 00:00:00','yyyy-mm-dd hh24:mi:ss') ";
		 						if(endDate != null && !endDate.equals(""))
		 						{
		 							condition += "and " + fieldName + "<=to_date('" + endDate +" 23:59:59','yyyy-mm-dd hh24:mi:ss') ";
		 						}	 				
		 					}
		 				}
		 				else
		 				{
		 					String value = request.getParameter("advancedvalue" + idx);
							if(value !=null && !value.equals(""))
							{
								condition += logical + " " + fieldName + " like '%" + value + "%' ";
							}
		 				}	
	 				}
	 			}
	 		}
	 		
	 		if(!condition.equals("")) 
	 		{
	 			condition = condition.trim();
	 			if(condition.startsWith("and"))
	 			{
	 				condition = condition.substring(4);
	 			}
	 			else if(condition.startsWith("or"))
	 			{
	 				condition = condition.substring(3);
	 			}
	 			sql = "select * from " + tablename + " where " + condition;
	 		}
	 		else
	 		{
	 			sql = "select * from " + tablename;
	 		}
 		}
 	}
 	
 	out.print(sql);
 	
 	boolean flag  = false;
 	//存取列名
	List columnList = null ;
	try
	{
		//执行sql语句
		DBUtil db = new DBUtil();
		db.execute(dsource,sql);
		ResultSetMetaData resultMeta = db.getMeta();
		
		if(resultMeta != null) 
		{
	        columnList = new ArrayList();
			int size =resultMeta.getColumnCount();
			for(int i=1; i<=size; i++)
			{
				String columnName = resultMeta.getColumnName(i);
				columnList.add(columnName);
			}
		}
		flag = true;
	} catch(Exception e)
	{
		flag = false;
		e.printStackTrace();
		
	}
	
	
	//处理每页显示的记录数:默认是10
	String str_pageSize = request.getParameter("pageSize");
	int pageSize = 10;
	if(str_pageSize != null && !"".equals(str_pageSize))
	{
		try
		{
			pageSize = Integer.parseInt(str_pageSize);
		}catch(NumberFormatException e)
		{
			pageSize = 10;
		}
	}
	
 %>
 <script type="text/javascript">
  	function selectAll()
  	{
  		var delall = document.getElementById("all");
  		var del = document.getElementsByName("checkObject");	
  		
  		if(delall.checked ==true)
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = true;
  			}
  		}else 
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = false;
  			}
  		}
  	}
  	
  	function checkDelAll()
  	{
  		var del = document.getElementsByName("checkObject");
  		var delall = document.getElementById("all");

  		var size = 0;
  		for(var i=0; i<del.length; i++)
  		{
  			if(del[i].checked == true)
  			{
  				size ++ ;
  			}
  		}
  		if(size == 0)
  		{
  			alert('至少选择一行!!!!');
  			return ;
  		}
  		else if(size == 1)
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				if(del[i].value =='')
  				{
  					alert('此语句不能删除(无主键信息)!!!');
  					del[i].checked = false;
  					return;
  				}
  			}
  		}
  		 		
  		var dsource = form1.dsource.value;
  		var tablename = form1.tablename.value;
  		
  		if(dsource == "" || tablename =="")
  		{
  			alert("缺少参数,不能删除该表的相关信息!!!");
  			return ;
  		}
  		
  		if(confirm('您确定要删除所选的行吗?(删除后就不能恢复!)'))
  		{	
  			document.form1.action = "delRecord.jsp";
  			document.form1.target = "_del";
            var featrue = "dialogWidth=100px;dialogHeight=100px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;

            var popupWin = window.open('delRecord.jsp','_del',featrue);    
  			document.form1.submit();
  			
  			<%--document.location.href="selectedtabList.jsp?dsource=<%=dsource%>&table_name=<%=tablename%>&pageSize=<%=pageSize%>";--%>
  		}
  		else 
  		{
  			for(var i=0; i<del.length; i++)
  			{
  				del[i].checked = false;
  			}
  			delall.checked = false;
  			return;
  		}
  	}
    function refreshSelectTableList(){
        document.location.href="selectedtabList.jsp?dsource=<%=dsource%>&table_name=<%=tablename%>&pageSize=<%=pageSize%>";
    } 
  	
  	function checkUpd()
  	{
  		var selectAll = document.getElementById("all");
  		var updateObjects = document.getElementsByName("checkObject");
  		var size = 0;
  		for(var i=0; i<updateObjects.length; i++)
  		{
  			if(updateObjects[i].checked == true)
  			{
  				size ++;
  			}
  		}
  		
  		if(size == 0)
  		{
  			alert('请先选择对象进行修改!!!');
  			return ;
  		} 
  		else if(size > 1)
  		{
  			alert('每次只能修改一条记录!!!');
  			if(selectAll.checked == true)
  			{
  				selectAll.checked = false;
  			}
  			for(var i=0; i<updateObjects.length;i++)
  			{
  				updateObjects[i].checked = false;
  			}
  			return ;
  		}
  		else if(size == 1)
  		{
  			for(var i=0; i<updateObjects.length; i++)
  			{
  				if(updateObjects[i].value =='')
  				{
  					alert('此语句不能修改(无主键信息)!!!');
  					updateObjects[i].checked = false;
  					return;
  				}
  			}
  		}
  		
  		
  		
  		if(confirm('您确定要修改所选的行吗?(修改后就不能恢复!)'))
  		{
  			form1.action = "displayRecord.jsp";
  			form1.submit();
  		}else
  		{
  			for(var i=0; i<updateObjects.length; i++)
  			{
  				updateObjects[i].checked = false;
  			}
  			
  			return;
  		}
  	}  	
  </script>
 <body class="contentbodymargin">
  		<form action="" method="post" name="form1">
	  		<span>
	  			<input type="button" class="input" style="width:100" name="add" value="删除所选" onclick="checkDelAll()"/>&nbsp;&nbsp;
	  			<input type="button" class="input" name="update" style="width:100" value="修改" onclick="checkUpd()"/>
	  			<input type="hidden" name="sql" value="<%=sql %>"/>
	  			
	  			
	  			<!-- 删除和更新需要的参数 -->
	  			<input type="hidden" name="dsource" value="<%=dsource %>"/>
	  			<input type="hidden" name="tablename" value="<%=tablename %>"/>
	  			<input type="hidden" name="pageSize" value="<%=pageSize%>"/>
	  			
	  			<!-- 用于分页的参数 -->
	  			<input type="hidden" name="table_name" value="<%=tablename %>"/>
	  			
	  		</span>	
	  		
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
		<%
			if(flag)
			{
		 %>
			    <pg:pager statement="<%=sql%>" 
	    		  dbname="<%=dsource %>" isList="false" maxPageItems="<%=pageSize %>" >
	    		  <pg:param name="sql"/>
	    		  <pg:param name="pageSize"/>
	    		  <pg:param name="table_name" value="<%=tablename %>"/>
	    		  <pg:param name="dsource" value="<%=dsource %>"/>
	    		  
	    		  
	    		  
	    		  
				<tr class="labeltable_middle_td">
					<td height="20" size="3" class="headercolor">
						<input type="checkbox" size="3" name="all" id="all" onclick="selectAll()"/>
					</td>
					<%
  						for(int i=0; i<columnList.size(); i++)
  						{
  					%>	
  							<td height="20" size="3" class="headercolor"><%=(String)columnList.get(i) %></td>
  					<%
  						}
  					 %>	
				</tr>
				
				<pg:notify>
				<tr><td colspan="<%=columnList.size()+1%>"><font color='red'>没有记录</font></td></tr>
				</pg:notify>
				<pg:list>
					<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
						<td height='20' size="3" align="center" class="tablecells">
							<input type="checkbox" size="3" name="checkObject" value="<%=getCondition(dsource,tablename,dataSet) %>"/>
						</td>
						<%
					  		for(int j=0; j<columnList.size(); j++)
					  		{
					  		
						%>
						<td>
							<pg:cell colName="<%=(String)columnList.get(j) %>"/>
						</td>
						<%
					  		}
					  	 %>
					</tr>
			   </pg:list>
				<tr>
					<td colspan="<%=columnList.size()+1%>" height='20' size="3"  class="tablecells">
						<pg:index/>
					</td>
				</tr>
				</pg:pager>
			<% }%>
			</table>
		</form>
	</body>
</html>

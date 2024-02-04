
<%@page import="com.frameworkset.util.SimpleStringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<html>
	<head>
		<title>属性容器</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
		


 <%

 	

 	String dsource = request.getParameter("dsource2");
 	String sql = request.getParameter("sqlContent");
 	
    String isDDLQuery_ = request.getParameter("isDDLQuery");
 	
 	if(null == dsource || null == sql 
 					|| "".equals(sql)  || "".equals(dsource) || 
 					"".equals(dsource.trim()) || "".equals(sql.trim()))
 	{
 					
 		out.print("查询条件不足,请检查是否选择数据源或是否输入了SQL语句!!!");
 		return ;
 	}
 	
 	//去掉sql空格
 	sql = sql.trim();
 	
	out.println(sql);
    
    
    String sql_l = sql.toLowerCase();
    boolean isDDLQuery = isDDLQuery_ != null && isDDLQuery_.equals("true") || sql_l.startsWith("show ")  || sql_l.startsWith("desc ");
    String isDDL_ = request.getParameter("isDDL");
    boolean isDDL = isDDL_ != null && isDDL_.equals("true") || sql_l.startsWith("create ")  || sql_l.startsWith("alert ") || sql_l.startsWith("drop ");
    boolean isSelect = sql_l.startsWith("select ") || sql_l.startsWith("with ") || sql_l.startsWith("show ")  || sql_l.startsWith("desc ");
    if(!isSelect && isDDLQuery){
        isSelect = true;
    }
        
    out.println("<br>管理查询SQL: "+isDDLQuery);
    out.println("<br>管理DDL SQL: "+isDDL);
   
    
	boolean flag = false;	

	String errorMessage ="";
	
	//存取列名
	List columnList = null ;
	DBUtil db = new DBUtil();
    
	try
	{
		//执行sql语句
		if(isDDL){
            db.executeUpdate(dsource,sql);
			flag = true;
		}
		else if(isSelect){
            if(!isDDLQuery){
                db.executeSelect(dsource,sql,0,1);
            }
            else{
                 db.executeSelect(dsource,sql);
            }
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
        }
        else {
            db.executeUpdate(dsource,sql);
			flag = true;
        }
	} catch(Exception e)
	{
       
		 
			flag = false;
			errorMessage = e.getMessage();
			errorMessage = SimpleStringUtil.exceptionToString(e) ;
            e.printStackTrace();
		
		
		
	}
	
	
	//处理每页显示的记录数:默认是10
	
	String str_pageSize = request.getParameter("pageSize2");
	
	int pageSize = 10;
	
	if(str_pageSize != null && !"".equals(str_pageSize))
	{
		try
		{
			pageSize = Integer.parseInt(str_pageSize);
		}catch(NullPointerException e)
		{
			pageSize = 10;
		}
	}
     boolean isPagine = true;
    if(pageSize <= 0 ||  sql_l.startsWith("show ")  || sql_l.startsWith("desc ")){
        isPagine = false;
    }
    out.println("<br>isPagine:"+isPagine);
    

  %>
  
  	<body class="contentbodymargin">
  		
  		<%
  		if(flag && columnList != null)
  		{
  		%>
  			<pg:pager statement="<%=sql %>" dbname="<%=dsource %>" isList="<%=!isPagine %>" maxPageItems="<%=pageSize%>">
  				<pg:param name="sqlContent" encode="true" value="<%=sql %>"/>
  				<pg:param name="dsource2" value="<%=dsource %>"/>
  				<pg:param name="pageSize2"/>
  				
  				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  					<tr class="labeltable_middle_td">
  					<%
  						for(int i=0; i<columnList.size(); i++)
  						{
  					%>	
  							<td height="20" size="3" class="headercolor"><%=(String)columnList.get(i) %></td>
  					<%
  						}
  					 %>	
  		 			<tr>
  		 			<pg:notify>
						<tr><td colspan="<%=columnList.size()+1%>"><font color='red'>没有记录</font></td></tr>
					</pg:notify>
					
					<pg:list>
					<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
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
							 <pg:index/>&nbsp;&nbsp;
							</form>
						</td>
					</tr>
				</table>
			</pg:pager>	
  		<%
  			}
  			else if(flag )
  			{
  				out.print("<br/><br/>SQL执行成功!!!");
  			}
  			else
  			{
  				out.print("<br/><br/>请检测SQL语句是否有问题,操作失败---> <textarea rows=\"20\" cols=\"400\">" + errorMessage+"</textarea>");
  			}
  		 %>
	</body>
</html>

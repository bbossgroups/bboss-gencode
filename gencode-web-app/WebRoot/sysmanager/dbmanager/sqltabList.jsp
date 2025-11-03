
<%@page import="com.frameworkset.util.SimpleStringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.common.poolman.SQLExecutor"%>

<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="java.util.Date" %>

<html>
	<head>
		<title>属性容器</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/include/css.jsp"%>
		


 <%

 	

 	String dsource = request.getParameter("dsource2");
 	String sql = request.getParameter("sqlContent");
 	
  
 	
 	if(null == dsource || null == sql 
 					|| "".equals(sql)  || "".equals(dsource) || 
 					"".equals(dsource.trim()) || "".equals(sql.trim()))
 	{
 					
 		out.print("查询条件不足,请检查是否选择数据源或是否输入了SQL语句!!!");
 		return ;
 	}
     //记录历史sql
     String id = sql.hashCode()+"_"+dsource;
    int count =  SQLExecutor.queryObjectWithDBName(Integer.class,"gencode","select count(1) from sql_history where dbname=? and id=?",dsource,id);
    if(count <= 0){
        SQLExecutor.insertWithDBName("gencode","insert into sql_history(id,sql_text,DBNAME,CREATETIME) values(?,?,?,?)",id,sql,dsource,new Date().getTime());
    }
    else{
        SQLExecutor.updateWithDBName("gencode","update  sql_history set CREATETIME = ? where id =?",new Date().getTime(),id);
    }
 	
 	//去掉sql空格
 	sql = sql.trim();
 	
	out.println(sql);
    
    String isDDLQuery_ = request.getParameter("isDDLQuery");
    String isDataquery_ = request.getParameter("isDataquery");
    String isDDL_ = request.getParameter("isDDL");
    String sql_l = sql.toLowerCase();
    boolean isDDLQuery = false;
    if( sql_l.startsWith("show ")  || sql_l.startsWith("desc ")) // isDDLQuery_ != null && isDDLQuery_.equals("true") 
        isDDLQuery = true;
    
    boolean isDDL = false;
    if( sql_l.startsWith("create ")  || sql_l.startsWith("alert ") || sql_l.startsWith("drop ") || sql_l.startsWith("truncate ") 
        || sql_l.startsWith("delete ") || sql_l.startsWith("insert ")
         || sql_l.startsWith("update ") ) //(isDDL_ != null && isDDL_.equals("true")) 
        isDDL = true;
    boolean isSelect = false;
    if(sql_l.startsWith("select ") || sql_l.startsWith("with "))// || (isDataquery_ != null && isDataquery_.equals("true"));
        isSelect = true;
    
     if(!isDDLQuery && !isDDL && !isSelect){
         if(isDDLQuery_ != null && isDDLQuery_.equals("true") ){
             isDDLQuery = true;
         }
         else if(isDDL_ != null && isDDL_.equals("true")){
             isDDL = true;
         }
         else if(isDataquery_ != null && isDataquery_.equals("true")){
             isSelect = true;
         }
     }
  
    out.println("<br>数据查询: "+isSelect);    
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
//            db.executeSelect(dsource,sql,0,1);
//            ResultSetMetaData resultMeta = db.getMeta();
//            
//            if(resultMeta != null) 
//            {
//                columnList = new ArrayList();
//                int size =resultMeta.getColumnCount();
//                for(int i=1; i<=size; i++)
//                {
//                    String columnName = resultMeta.getColumnLabel(i);
//                    columnList.add(columnName);
//                }
//            }
            flag = true;
        }
		else if(isDDLQuery){
            
            db.executeSelect(dsource,sql);
           
            ResultSetMetaData resultMeta = db.getMeta();
            
            if(resultMeta != null) 
            {
                columnList = new ArrayList();
                int size =resultMeta.getColumnCount();
                for(int i=1; i<=size; i++)
                {
                    String columnName = resultMeta.getColumnLabel(i);
                    columnList.add(columnName);
                }
            }
            flag = true;
        }
        else {
//            db.executeUpdate(dsource,sql);
//			flag = true;
            out.println("<br>不能从sql识别出操作类型，默认采用管理DDL操作");
            db.executeUpdate(dsource,sql);
			flag = true;
           
            return;
        }
	} catch(Exception e)
	{
       
		 
			flag = false;
			errorMessage = SimpleStringUtil.exceptionToString(e) ;
		
		
		
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
  		if(flag && isSelect)
  		{
              try{
  		%>
  			<pg:pager statement="<%=sql %>" dbname="<%=dsource %>" isList="<%=!isPagine %>" 
                      maxPageItems="<%=pageSize%>">
  				<pg:param name="sqlContent" encode="true" value="<%=sql %>"/>
  				<pg:param name="dsource2" value="<%=dsource %>"/>
  				<pg:param name="pageSize2"/>
  				
  				<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
  					<tr class="labeltable_middle_td">
  					<%
  					    columnList = pager_info.getColumnList();
                          if(columnList == null){
                              columnList = new ArrayList();
                          }
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
                catch(Exception e){
                    errorMessage = SimpleStringUtil.exceptionToString(e) ;
                    out.print("<br/><br/>请检测SQL语句是否有问题,操作失败---> <textarea rows=\"20\" cols=\"400\">" + errorMessage+"</textarea>");
                }
  			}
  			else if(flag )
  			{
                  if(!isSelect) {
                      out.print("<br/><br/>SQL执行成功!!!");
                  }
                  else{
                      out.print("<br/><br/>SQL执行成功：没有查询到满足条件的数据！");
                  }
  			}
  			else
  			{
  				out.print("<br/><br/>请检测SQL语句是否有问题,操作失败---> <textarea rows=\"20\" cols=\"400\">" + errorMessage+"</textarea>");
  			}
  		 %>
	</body>
</html>

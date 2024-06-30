<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.frameworkset.util.SimpleStringUtil"%>

<%@ page import="com.frameworkset.common.poolman.SQLExecutor"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.frameworkset.util.RegexUtil"%>
<%
	String dbname = (String) request.getParameter("dbname");
	dbname = dbname == null ? "" : dbname;
	
	
 
		
	String querySQLText = request.getParameter("querySQLText") == null ? "" : request.getParameter("querySQLText");
    String querySql = "select * from sql_history where DBNAME=?";
    List<Map> datas = null;
    if(querySQLText != null && !querySQLText.equals("")){
        querySql = querySql + " and sql_text like ?  order by CREATETIME desc";
        out.print(querySql);
        datas = SQLExecutor.queryListWithDBName(Map.class,"gencode",querySql,dbname,"%"+querySQLText+"%");
       
    }
    else{
        querySql = querySql + " order by CREATETIME desc";
        out.print(querySql);
        datas = SQLExecutor.queryListWithDBName(Map.class,"gencode",querySql,dbname);
    }
    
    
     boolean searchNone = false;
	if (datas == null || datas.size() == 0) 
	{//没有一个匹配
		searchNone = true;
	}
%>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>选择历史sql</title>
		<%@ include file="/include/css.jsp"%>
	</head>

	<body>
		<form name="dictList" method="post">
			<table cellspacing="1" cellpadding="0" border="0" width=98%
				class="thin">
				<tr>
					<td class="headercolor" width="10">

					</td>
					<td class="headercolor" style="text-align:left">
						sql
					</td>
					 
				</tr>
				<%
				if (searchNone) 
				{
				%>
				<tr>
					<td class="tablecells" nowrap="nowrap">

					</td>
					<td class="tablecells"  style="text-align:left"
						nowrap="nowrap">
						<span style="color:red">没有找到符合条件的sql</span>
					</td>

				</tr>
				<%
				 
				}
					for (int i = 0; i < datas.size(); i++)
					{
//                        System.out.println(SimpleStringUtil.object2json(datas.get(i)));
						String sql_text = String.valueOf(datas.get(i).get("sql_text"));
                        String ID = String.valueOf(datas.get(i).get("ID"));
						
				%>
				<tr>
					<td class="tablecells" nowrap="nowrap">
						
							<input type="radio" name="sqlId"  style="text-align:left"
							onclick="selectOne('sqlId',this)"  value="<%=ID%>" width="10">
						
						
					</td>
					<td class="tablecells" style="text-align:left" nowrap="nowrap">
                        <textarea rows="5" cols="120" id="<%=ID%>"><%=sql_text%></textarea>
					</td>
				 
				</tr>
				<%
				   }
				%>
			</table>
		</form>
	</body>
	<script>
 	    function selectOne(checkbox_name,e)
 	    {
 	        let sqlId = e.value;
            selectSQL = document.getElementById(sqlId).value;
            parent.setselectSQL(selectSQL)
 	    }
 	 
 	</script>
</html>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<!-- 
	描述:MS分页测试管理主界面。
	作者:yin
	版权:bboss
	版本:v1.0 
	日期:2016-01-15 01:39:06
-->
<head>
<title>MS分页测试管理</title>
<%@ include file="/include/css.jsp"%>

</head>
	<body>
		<div class="mcontent">
			
						<div id="searchblock">
				<div class="search_top">
					<div class="right_top"></div>
					<div class="left_top"></div>
				</div>
				
				<div class="search_box">
					<form id="queryForm" name="queryForm">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="left_box"></td>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										class="table2">
								
										
																																												<tr>
																							<th><pg:message code="sqlserver.bm"/>：</th>
												<td>
																									<input id="bm" name="bm" type="text"
															value="" class="w120"/>
																								</td>
												
												
																									<th>
													&nbsp;
												</th>
												<td>
													<a href="javascript:void(0)" class="bt_1" id="queryButton"><span>查询</span>
													</a>
													<a href="javascript:void(0)" class="bt_2" id="resetButton" onclick="doreset()"><span>重置</span>
													</a>
													<input type="reset" id="reset" style="display:none"/>
												</td>	
													
											</tr>
																																
									</table>
								</td>
								<td class="right_box"></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="search_bottom">
					<div class="right_bottom"></div>
					<div class="left_bottom"></div>
				</div>
			</div>
						<div class="title_box">
				<div class="rightbtn">
				<a href="javascript:void" class="bt_small" id="addButton"><span>新增</span></a>
				<a href="javascript:void" class="bt_small" id="delBatchButton"><span>批量删除</span></a>
				<a href="javascript:void" class="bt_small" id="exportButton"><span>导出</span></a>
				<input id="excelType" type="radio" name="excelType"   checked  >2003</input>
				<input  type="radio" name="excelType"  >2007</input>
				</div>
				
				<strong>MS分页测试 列表</strong>
				<img id="wait" src="<%=request.getContextPath()%>/include/images/wait.gif" />				
			</div>
			<div id="custombackContainer" style="overflow:auto">
			
			</div>
		</div>
	</body>
</html>
<script type="text/javascript">

<!--

$(document).ready(function() {
	bboss.pager.pagerevent = {   
			                            beforeload:function(opt){   
			                                //alert("beforeload containerid:"+opt.containerid);   
			                            },   
			                          afterload:function(opt){   
			                              //alert("afterload containerid:"+opt.containerid);   
	}};   

	 $("#wait").hide();
	 queryList();

    $('#queryButton').click(function() {
    	queryData();
    });
    $('#delBatchButton').click(function() {
    	delBatch();
    });
    $('#exportButton').click(function() {
    	exportExcel();
    });           
    
    $('#addButton').click(function() {  
  	 var url="<%=request.getContextPath()%>/sqlserver/toAddAppBom.page";
	 	 $.dialog({ id:'iframeNewId', title:'新增&nbsp;MS分页测试',width:740,height:560, content:'url:'+url});   			 		  
    });            
});

function queryList(){	
	$("#custombackContainer").load("queryListInfoAppBoms.page #customContent",function(){})
}

function containSpecial( s ) {  
	  var containSpecial = RegExp(/[(\ )(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\+)(\=)(\[)(\])(\{)(\})(\|)(\\)(\;)(\:)(\')(\")(\,)(\/)(\<)(\>)(\?)(\)]+/);      
   return ( containSpecial.test(s) );      
}

//查找
function queryData()
{	
	var bm=$("#bm").val();
		if( containSpecial(bm)){
		$.dialog.alert('查询字符串含有非法字符集,请检查输入条件！');
		return;
	}
		$("#custombackContainer").load("queryListInfoAppBoms.page #customContent",
	{ bm:bm},function(){});


}

function modifyQueryData()
{	
	if($("#querystring").val() != '')
		$("#custombackContainer").load("queryListInfoAppBoms.page?"+$("#querystring").val()+" #customContent");
	else
		$("#custombackContainer").load("queryListInfoAppBoms.page #customContent");
	
}
function editAppBom(id){
	var url="<%=request.getContextPath()%>/sqlserver/toUpdateAppBom.page?id="+id;
	$.dialog({ title:'修改MS分页测试信息',width:740,height:560, content:'url:'+url,lock: true}); 		
}
function viewAppBom(id){
	var url="<%=request.getContextPath()%>/sqlserver/getAppBom.page?id="+id;		
	$.dialog({ title:'查看MS分页测试信息',width:740,height:560, content:'url:'+url,lock: true}); 	
}
function doreset(){
	$("#reset").click();
}
function delAppBom(id){		
	$.dialog.confirm('确定要删除选中的MS分页测试记录吗?', function(){ 
		 $.ajax({
	 	 type: "POST",
		url : "<%=request.getContextPath()%>/sqlserver/deleteAppBom.page",
		data :{"id":id},
		dataType : 'json',
		async:false,
		beforeSend: function(XMLHttpRequest){
			 	XMLHttpRequest.setRequestHeader("RequestType", "ajax");
			},
		success : function(data){
	 		modifyQueryData();
	 		//alert("成功删除记录");
		}	
	  });
	}, function(){ 
		 
	});
		
	  
}
function delBatch(){
	var ids=[];
	var i = 0;
	 $("#tb tr:gt(0)").each(function() {	 
            if ($(this).find("#CK").get(0).checked == true) {
                 ids.push($(this).find("#id").val());                
                i++;
            }
              	 
       });
       if(i==0){
        $.dialog.alert('请选择需要删除的记录！');
        return false;
       }
     $.dialog.confirm('确定要删除选中的'+i+'条MS分页测试记录吗?', function(){
     	$.ajax({
		 	 	type: "POST",
				url : "<%=request.getContextPath()%>/sqlserver/deleteBatchAppBom.page",
				data :{"ids":ids},
				dataType : 'json',
				async:false,
				beforeSend: function(XMLHttpRequest){
					 	XMLHttpRequest.setRequestHeader("RequestType", "ajax");
					},
				success : function(data){
			 		modifyQueryData();
			 		//alert("成功删除记录");
				}	
			 });
      },function(){
      		
      });         
}

//-->
</script>

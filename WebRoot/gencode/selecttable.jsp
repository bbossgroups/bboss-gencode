<%@ page language="java" pageEncoding="utf-8" session="false"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<!-- BEGIN PAGE HEADER-->
 
<div class="portlet">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-gift"></i>选择数据源和数据库表
		</div>
		<div class="tools">
			<a href="javascript:;" class="collapse"> </a> <a
				href="#portlet-config" data-toggle="modal" class="config"> </a> <a
				href="javascript:;" class="reload"> </a> <a href="javascript:;"
				class="remove"> </a>
		</div>
	</div>
	<div class="portlet-body form">
		<!-- BEGIN FORM-->
		<form action="#" id="tableform" class="form-horizontal">
			<div class="form-body">
				<div class="alert alert-danger display-hide">
					<button class="close" data-close="alert"></button>
					You have some form errors. Please check below.
				</div>
				<div class="alert alert-success display-hide">
					<button class="close" data-close="alert"></button>
					Your form validation is successful!
				</div>
				<!-- END PAGE HEADER-->
				<!-- BEGIN PAGE CONTENT-->
				
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="control-label col-md-3">数据源<span
											class="required"> * </span></label>
							<div class="col-md-9">
								<select name="dbname" id="dbname" class="select2me form-control" onchange="ComponentsDropdowns.loadtables(event,'tableName')">
								<pg:list requestKey="dbs">
									<option value="<pg:cell colName="dbname"/>"><pg:cell colName="dbname"/></option>
								</pg:list>	
									
								</select> 
							</div>
						</div>
					</div>
					<!--/span-->
					<div class="col-md-6">
						<div class="form-group">
							<label class="control-label col-md-3">选择表 <span
											class="required"> * </span></label>
										
										
							<div class="col-md-9">
								<select name="tableName" id="tableName"   class="select2me form-control">
								<pg:list requestKey="tables">
									<option value="<pg:cell/>"><pg:cell/></option>
								</pg:list>	
									
								</select> 
							</div>
						</div>
					</div>
					<!--/span-->
				</div>

				<div class="row">
					<div class="col-md-12">
						<button type="submit" class="btn blue"> 进入表单配置</button>
						<a href="tableconfig.page"  class="btn blue ajaxify display-hide" id="tableconfig" formid="tableform"> 进入表单配置步骤</a>
						<a href="javascript:void(0);"  class="btn default" onclick="FormValidation.refreshdb('tableName',event)"> 刷新表结构</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<div class="portlet  ">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-edit"></i>数据源管理
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								<a href="#portlet-config" data-toggle="modal" class="config">
								</a>
								<a href="javascript:;" class="reload">
								</a>
								<a href="javascript:;" class="remove">
								</a>
							</div>
							<div class="actions">
								<div class="btn-group">
									<a class="btn default" href="#" data-toggle="dropdown">
									Columns <i class="fa fa-angle-down"></i>
									</a>
									<div id="ds_editable_column_toggler" class="dropdown-menu hold-on-click dropdown-checkboxes pull-right">
										
										<label><input type="checkbox" checked data-column="0"><pg:message code="数据源名称"/></label>
										<label><input type="checkbox" checked data-column="1"><pg:message code="数据源地址"/></label>
										<label><input type="checkbox" checked data-column="2"><pg:message code="数据源驱动"/></label>
										<label><input type="checkbox" checked data-column="3"><pg:message code="数据源用户"/></label>
										<label><input type="checkbox" checked data-column="4"><pg:message code="数据源口令"/></label>
										<label><input type="checkbox" checked data-column="5"><pg:message code="数据源校验sql"/></label>
										<label><input type="checkbox" checked data-column="6"><pg:message code="描述"/></label>
									</div>
								</div>
							</div>
						</div>
						<div class="portlet-body form">
						<form action="#" id="dsform" class="form-horizontal">
							<div class="form-body">
								<div class="alert alert-danger display-hide">
									<button class="close" data-close="alert"></button>
									You have some form errors. Please check below.
								</div>
								<div class="alert alert-success display-hide">
									<button class="close" data-close="alert"></button>
									Your form validation is successful!
								</div>
								<div class="table-toolbar">
									<div class="row">
										<div class="col-md-6">
											<div class="btn-group">
												<button id="ds_editable_new" class="btn blue">
												新增DS <i class="fa fa-plus"></i>
												</button>
											</div>
										</div>
										 
									</div>
								</div>
								<table class="table table-striped table-hover table-bordered" id="ds_editable">
								<thead>
								<tr>
									
									<th>
										 数据源名称
									</th>
									<th>
										 数据源地址
									</th>
									<th>
										 数据源驱动
									</th>
									<th>
										 数据源用户
									</th>
									<th>
										 数据源口令
									</th>
									<th>
										 数据源校验sql
									</th>
									<th>
										 描述
									</th>
									<th >
										 编辑
									</th>
									<th >
										 删除
									</th>
								</tr>
								</thead>
								<tbody>
								<pg:list requestKey="dbs">
								<tr>
									
									<td> 
										 <pg:cell colName="dbname"/>
									</td>
									<td>
										 <pg:cell colName="dburl"/>
									</td>
									<td>
										 <pg:cell colName="dbdriver"/>
									</td>
									<td>
										 <pg:cell colName="dbuser"/>
									</td>
									<td class="center">
										 <pg:cell colName="dbpassword"/>
									</td>
									<td>
										 <pg:cell colName="validationQuery"/>
									</td>
									<td class="center">
										 <pg:cell colName="dbdesc"/>
									</td>
									<td>
										<a class="edit" href="javascript:;">
										Edit </a>
									</td>
									<td>
										<a class="delete" href="javascript:;">
										Delete </a>
									</td>
								</tr>
										 
									</pg:list>	
								
								
								</tbody>
								</table>
							</div>
						</form>
						</div>
					</div>

<div class="portlet">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-gift"></i>代码生成记录
							</div>
							<div class="tools">
								<a href="#" class="collapse">
								</a>
								<a href="#portlet-config" data-toggle="modal" class="config">
								</a>
								<a href="#" id="reloadbuttom" data-url="genlist.page" class="reload">
								</a>
								<a href="#" class="fullscreen">
								</a>
								<a href="#" class="remove">
								</a>
							</div>
							<div class="actions">
								<div class="btn-group">
									<a class="btn default" href="#" data-toggle="dropdown">
									Columns <i class="fa fa-angle-down"></i>
									</a>
									<div id="gencodelist_column_toggler" class="dropdown-menu hold-on-click dropdown-checkboxes pull-right">
										<label><input type="checkbox" checked data-column="2">代码模块</label>
										<label><input type="checkbox" checked data-column="3"><pg:message code="gencode.author"/></label>
										<label><input type="checkbox" checked data-column="4"><pg:message code="gencode.company"/></label>
										<label><input type="checkbox" checked data-column="5"><pg:message code="gencode.tablename"/></label>
										<label><input type="checkbox" checked data-column="6"><pg:message code="gencode.dbname"/></label>
										<label><input type="checkbox" checked data-column="7"><pg:message code="gencode.createtime"/></label>
										<label><input type="checkbox" checked data-column="8"><pg:message code="gencode.updatetime"/></label>
									</div>
								</div>
							</div>
						</div>
						<div class="portlet-body portlet-empty">
						</div>
					</div>



<div class="note note-success">
							<h4 class="block">自动代码生成框架功能说明</h4>
							<p>根据模板，自动生成给定表的增、删、改、分页查询、列表查询、国际化功能对应的程序和配置文件：
							<ul>
								<li>1.mvc控制器</li>
								<li>2.业务组件</li>
								<li>3.实体类</li>
								<li>4.jsp文件 可以定制不同风格的界面模板，目前提供了平台的基础ui风格</li>
								<li>5.cxf webservice服务类文件</li>
								<li>6.hessian服务类文件</li>
								<li>7.sql配置文件</li>
								<li>8.ioc/mvc组件装配部署和服务发布配置文件.</li>
								<li>9.国际化属性文件和国际化配置</li>
								<li>10.readme.txt 代码和配置文件集成配置说明</li>
							</ul>
							</p>
							<p>所有文件存放在服务器指定的目录中</p>

						</div>
<!-- END PAGE CONTENT-->
<script>jQuery(document).ready(function() {
 TableAdvanced.init();
 FormValidation.initselecttableform();

});
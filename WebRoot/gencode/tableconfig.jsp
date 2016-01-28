<%@ page language="java" pageEncoding="utf-8" session="false"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<!-- BEGIN PAGE HEADER-->

<div id="ajax-modal" class="modal  container fade" tabindex="-1">
</div>
<a id="downfile" target="_blank" />
<div class="portlet">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-gift"></i> 数据源${dbname }-表${tableName } 配置
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
		<form action="#" id="configform" class="form-horizontal">
			<pg:empty actual="${tableName }" evalbody="true">
				<pg:yes>请选择表</pg:yes>
				<pg:no>

					<div class="form-body">
						<div class="alert alert-danger display-hide">
							<button class="close" data-close="alert"></button>
							You have some form errors. Please check below.
						</div>
						<div class="alert alert-success display-hide">
							<button class="close" data-close="alert"></button>
							Your form validation is successful!
						</div>
						<pg:beaninfo requestKey="controlparams">
							<h3 class="form-section">基本信息</h3>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">数据源</label>
										<div class="col-md-9">
											<input type="hidden" name="dbname" value="${dbname }">
											<input type="hidden" name="gencodeid" id="gencodeid"
												value="${gencodeid }">
											<p class="form-control-static">${dbname }</p>
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">表名称</label>
										<div class="col-md-9">
											<input type="hidden" name="tableName" value="${tableName }"
												class="form-control">
											<p class="form-control-static">${tableName }</p>
										</div>
									</div>
								</div>
								<!--/span-->
							</div>
							<!--/row-->


							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">模块名称 <span
											class="required"> * </span>
										</label>
										<div class="col-md-9">
											<input id="moduleName" name="moduleName" type="text"
												value="<pg:cell colName="moduleName"/>" class="form-control"
												placeholder="模块名称,国际化命名空间用到，mvc配置文件存放目录和名称用到">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">模块中文名称<span
											class="required"> * </span></label>
										<div class="col-md-9">
											<input id="moduleCNName" name="moduleCNName" type="text"
												value="<pg:cell colName="moduleCNName"/>"
												class="form-control" placeholder="模块中文名称">
										</div>
									</div>
								</div>
								<!--/span-->

								<!--/span-->
							</div>
							<div class="row">
								<pg:empty actual="${DEFAULT_SOURCEPATH }">
									<div class="col-md-6">

										<div class="form-group">
											<label class="control-label col-md-3">源码存放路径<span
												class="required"> * </span></label>
											<div class="col-md-9">

												<input id="sourcedir" name="sourcedir" type="text"
													value="<pg:cell colName="sourcedir"/>" class="form-control"
													placeholder="源码存放路径">

											</div>
										</div>
									</div>
								</pg:empty>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">包路径<span
											class="required"> * </span></label>
										<div class="col-md-9">
											<input id="packagePath" name="packagePath" type="text"
												value="<pg:cell colName="packagePath"/>"
												class="form-control" placeholder="包路径,例如：org.bboss.test">
										</div>
									</div>
								</div>
								<!--/span-->

								<!--/span-->
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">jsp相对路径</label>
										<div class="col-md-9">
											<input id="jsppath" name="jsppath" type="text"
												value="<pg:cell colName="jsppath"/>" class="form-control"
												placeholder="jsp相对路径，相对于WebRoot，例如：/test/sss">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group"><label class="control-label col-md-3">表名前缀截取</label>
										<div class="col-md-9">
											<div class="radio-list">
																			<pg:case colName="ignoreEntityFirstToken">
																				<label class="radio-inline"><input
																					type="radio" name="ignoreEntityFirstToken"
																					id="ignoreEntityFirstToken" value="1"
																					<pg:equal value="1">checked</pg:equal>>是</label>
																				<label class="radio-inline"><input
																					type="radio" name="ignoreEntityFirstToken"  
																					id="ignoreEntityFirstToken" value="0"
																					<pg:equal value="0">checked</pg:equal>>否</label>
																			</pg:case>
																		</div>
										</div></div>
								</div>
								<!--/span-->

								<!--/span-->
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">系统名称</label>
										<div class="col-md-9">
											<input id="system" name="system" type="text"
												class="form-control" placeholder="系统名称,只能使用英文名称，用于mvc配置文件存放相对路径和国际化属性文件中属性名称命名空间"
												value="<pg:cell colName="system"/>"><span
												class="help-block"><font color="blue">可选项 </font></span>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">

										<label class="control-label col-md-3">界面风格</label>
										<div class="col-md-9">
											<select class="form-control" id="theme" name="theme">
												<pg:case colName="theme">
													<option value="default"
														<pg:equal value="default">selected</pg:equal>>default</option>
													<option value="common"
														<pg:equal value="common">selected</pg:equal>>common</option>
													<!-- 													<option value="bootstrap" -->
													<!-- 														<pg:equal value="bootstrap">selected</pg:equal>>bootstrap</option> -->
													<!-- 													<option value="mobile" -->
													<!-- 														<pg:equal value="default">mobile</pg:equal>>mobile</option> -->
												</pg:case>
											</select><span
												class="help-block"><font color="blue">default:对应bboss平台通用界面风格  ，集成到bboss平台中运行<br> common：对应bboss通用风格模板，生成的代码与平台无关，只需要bboss框架，集成到<a href="https://github.com/bbossgroups/bboss-gencode/tree/master/gencode" target="_blank"><font color="red">gencode</font></a>子目录对应的eclipse工程中即可运行</font></span>
										</div>

									</div>
								</div>

								<!--/span-->
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">代码控制参数</label>
										<div class="col-md-9">
											<input type="hidden" id="controlParams" name="controlParams"
												class="form-control  select2"
												value="<pg:cell colName="controlParams" defaultValue="geni18n, clearSourcedir,genRPC,autopk,print"/>">
										</div>
									</div>
								</div>


								<div class="col-md-6">
									<div class="form-group">


										<label class="control-label col-md-3">excel版本号</label>
										<div class="col-md-9">
											<select class="form-control" id="excelVersion"
												name="excelVersion">
												<pg:case colName="excelVersion">
													<option value="-1" <pg:equal value="-1">selected</pg:equal>>不导出</option>
													<option value="2003"
														<pg:equal value="2003">selected</pg:equal>>2003</option>
													<option value="2007"
														<pg:equal value="2007">selected</pg:equal>>2007</option>
													<option value="2010"
														<pg:equal value="2010">selected</pg:equal>>2010</option>
													<option value="2013"
														<pg:equal value="2013">mobile</pg:equal>>2013</option>
												</pg:case>

											</select>
										</div>
									</div>
								</div>
								<!--/span-->

								<!--/span-->
							</div>


							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">唯一标识字段</label>
										<div class="col-md-9">
											<select class="form-control" id="primaryKeyName"
												name="primaryKeyName">
												<pg:list requestKey="fields">
													<option value="<pg:cell colName="columnname"/>"
														<pg:equal colName="columnname" expressionValue="{0.primaryKeyName}" evalbody="true">
															<pg:yes>selected</pg:yes>
															<pg:no><pg:true colName="pk">selected</pg:true></pg:no>
														</pg:equal>>
														<pg:cell colName="columnname" />
														</option>
												</pg:list>
											</select>
										</div>


									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">主键SEQ名称</label>
										<div class="col-md-9">
											<input id="pkname" name="pkname" type="text"
												class="form-control" placeholder="主键名称，没有不填"
												value="<pg:cell colName="pkname"/>"> <span
												class="help-block"><font color="blue">对应于tableinfo表中的table_name字段
											</font></span>
										</div>
									</div>
								</div>

								<!--/span-->

								<!--/span-->
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">分页机制</label>
										<div class="col-md-9">
											<div class="radio-list">
												<pg:case colName="pagineWithDBRownumberOver">
													<label class="radio-inline"><input
														type="radio" name="pagineWithDBRownumberOver"
														id="pagineWithDBRownumberOver" value="0"
														<pg:false>checked</pg:false>> 默认分页机制</label>
													<label class="radio-inline"><input
														type="radio" name="pagineWithDBRownumberOver"
														id="pagineWithDBRownumberOver" value="1"
														<pg:true>checked</pg:true>> Rownumber Over(Order By)</label>
												</pg:case>
											</div><span
												class="help-block"><font color="green">【默认分页机制】适用数据库oracle，mysql，maradb，sqlite，postgres 【Rownumber Over(Order By)】适用数据库oracle，mysql，maradb，sqlite，postgres，derby，mssql server2005/2008，db2
											</font></span>
										</div>


									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">指定DB操作数据源</label>
										<div class="col-md-9">
											<input id="daoDBName" name="daoDBName" type="text"
												class="form-control" placeholder="${dbname }"
												value="<pg:cell colName="daoDBName"/>"> <span
												class="help-block"><font color="blue">必须在poolman.xml文件中配置对应名称的数据源
											</font></span>
										</div>
									</div>
								</div>

								<!--/span-->

								<!--/span-->
							</div>
							<h3 class="form-section">版权信息</h3>
							<!--/row-->
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">作者<span
											class="required">*</span></label>
										<div class="col-md-9">
											<input type="text" id="author" name="author"
												value="<pg:cell colName="author"/>" class="form-control">
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">公司<span
											class="required">*</span></label>
										<div class="col-md-9">
											<input type="text" id="company" name="company"
												class="form-control" value="<pg:cell colName="company"/>">
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">版本号<span
											class="required">*</span></label>
										<div class="col-md-9">
											<input type="text" id="version" name="version"
												class="form-control"
												value="<pg:cell colName="version" defaultValue="v1.0"/>">
										</div>
									</div>
								</div>
								<!--/span-->

								<!--/span-->
							</div>
							 
							 
						</pg:beaninfo>
						<!--/row-->
						<h3 class="form-section">字段设置</h3>
						<!-- table -->
						<div class="table-scrollable">
							<table
								class="table table-striped table-bordered table-advance  dataTable no-footer"
								id="fieldlist">
								<thead>
									<tr>
										<th scope="col"><i class="fa fa-briefcase"></i>字段名称</th>

										<th scope="col"><i class="fa fa-shopping-cart">字段类型 </th>
										<th scope="col"><i class="fa fa-user">属性名称 </th>
										<th scope="col">java类型</th>
										<th scope="col">中文名称</th>



									</tr>
								</thead>
								<tbody id='content'>
									<pg:list requestKey="fields">

										<tr>

											<td><span class="row-details row-details-close"
												id="row_<pg:rowid/>"></span>&nbsp;&nbsp;<pg:cell
													colName="columnname" /><input type="hidden"
												name="columnname" class="form-control"
												value="<pg:cell colName="columnname"/>"><input
												type="hidden" name="rowid" class="form-control"
												value="<pg:rowid/>"></td>

											<td><pg:cell colName="columntype" /><input
												type="hidden" name="columntype" class="form-control"
												value="<pg:cell colName="columntype"/>"></td>
											<td><pg:cell colName="fieldName" /><input type="hidden"
												name="fieldName" class="form-control"
												value="<pg:cell colName="fieldName"/>"><input
												type="hidden" name="mfieldName" class="form-control"
												value="<pg:cell colName="mfieldName"/>"></td>
											<td><select class="form-control input-small select2me"
												name="type" id="type">
													<pg:case colName="type">
														<option value="String"
															<pg:equal value="String">selected</pg:equal>>String</option>
														<option value="long"
															<pg:equal value="long">selected</pg:equal>>long</option>
														<option value="Long"
															<pg:equal value="Long">selected</pg:equal>>Long</option>	
														<option value="int"
															<pg:equal value="int">selected</pg:equal>>int</option>
														<option value="Integer"
															<pg:equal value="Integer">selected</pg:equal>>Integer</option>	
														<option value="short"
															<pg:equal value="short">selected</pg:equal>>short</option>
														<option value="Short"
															<pg:equal value="Short">selected</pg:equal>>Short</option>	
														<option value="Timestamp"
															<pg:equal value="Timestamp">selected</pg:equal>>Timestamp</option>
														<option value="Date"
															<pg:equal value="Date">selected</pg:equal>>Date</option>
														<option value="UtilDate"
															<pg:equal value="UtilDate">selected</pg:equal>>UtilDate</option>
														<option value="double"
															<pg:equal value="double">selected</pg:equal>>double</option>
														<option value="Double"
															<pg:equal value="Double">selected</pg:equal>>Double</option>	
														<option value="float"
															<pg:equal value="float">selected</pg:equal>>float</option>
														<option value="Float"
															<pg:equal value="Float">selected</pg:equal>>Float</option>
														<!-- <option value="url"
															<pg:equal value="url">selected</pg:equal>>url</option>
														<option value="creditcard"
															<pg:equal value="creditcard">selected</pg:equal>>creditcard</option>
														<option value="email"
															<pg:equal value="email">selected</pg:equal>>email</option>
														<option value="file"
															<pg:equal value="file">selected</pg:equal>>file</option>
														<option value="idcard"
															<pg:equal value="idcard">selected</pg:equal>>idcard</option>
														<option value="textarea"
															<pg:equal value="textarea">selected</pg:equal>>textarea</option>
														<option value="htmleditor"
															<pg:equal value="htmleditor">selected</pg:equal>>htmleditor</option>
														<option value="word"
															<pg:equal value="word">selected</pg:equal>>word</option>
														<option value="excel"
															<pg:equal value="excel">selected</pg:equal>>excel</option>
														<option value="ppt"
															<pg:equal value="ppt">selected</pg:equal>>ppt</option>
														<option value="fuction"
															<pg:equal value="fuction">selected</pg:equal>>fuction</option> -->

													</pg:case>
											</select></td>
											<td><input type="text"
												placeholder="<pg:cell colName="fieldName"/>"
												name="fieldCNName" class="form-control  input-small"
												value="<pg:cell colName="fieldCNName"/>"></td>
										</tr>


										<tr id="detail_row_<pg:rowid/>" class="display-hide">
											<td colspan="5">
												<table class="table    ">
													<tbody>

														<tr>
															<td>
																<div class="form-group">
																	<label class="control-label col-md-3">日期格式</label>
																	<div class="col-md-9">
																		<select class="form-control  input-medium select2me"
																			name="dateformat" id="dateformat">
																			<pg:case colName="dateformat">
																				<option value=""
																					<pg:equal value="">selected</pg:equal>>空</option>
																				<option value="yyyy-MM-dd HH:mm:ss"
																					<pg:equal value="yyyy-MM-dd HH:mm:ss">selected</pg:equal>>yyyy-MM-dd
																					HH:mm:ss</option>
																				<option value="yyyy/MM/dd HH:mm:ss"
																					<pg:equal value="yyyy/MM/dd HH:mm:ss">selected</pg:equal>>yyyy/MM/dd
																					HH:mm:ss</option>
																				<option value="yyyy-MM-dd"
																					<pg:equal value="yyyy-MM-dd">selected</pg:equal>>yyyy-MM-dd</option>
																				<option value="yyyy/MM/dd"
																					<pg:equal value="yyyy/MM/dd">selected</pg:equal>>yyyy/MM/dd</option>
																			</pg:case>
																		</select>
																	</div>
																</div>
															</td>
															<td  ><div class="form-group">
																	<label class="control-label col-md-3">数字格式</label>
																	<div class="col-md-9">
																		<select class="form-control  input-medium select2me"
																			name="numformat" id="numformat">
																			<pg:case colName="numformat">
																				<option value=""
																					<pg:equal value="">selected</pg:equal>>无</option>
																				<option value="###,###"
																					<pg:equal value="###,###">selected</pg:equal>>###,###</option>
																				<option value="###,###.###"
																					<pg:equal value="###,###.###">selected</pg:equal>>###,###.###</option>
																				<option value="###,###.00"
																					<pg:equal value="###,###.00">selected</pg:equal>>###,###.00</option>
																			</pg:case>
																		</select>
																	</div>
																</div></td>
															<td><div class="form-group">
																	<label class="control-label col-md-3">类型校验</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="required">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_required"
																					id="<pg:rowid/>_required" value="1"
																					<pg:equal value="1">checked</pg:equal>>是 </label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_required"
																					id="<pg:rowid/>_required" value="0"
																					<pg:equal value="0">checked</pg:equal>>否 </label>
																			</pg:case>
																		</div>
																	</div>
																</div></td>

														</tr>
														<tr>
														<td><div class="form-group">
																	<label class="control-label col-md-3">查询条件</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="qcondition">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_qcondition"
																					id="<pg:rowid/>_qcondition" value="1"
																					<pg:equal value="1">checked</pg:equal>>是</label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_qcondition"
																					id="<pg:rowid/>_qcondition" value="0"
																					<pg:equal value="0">checked</pg:equal>>否</label>
																			</pg:case>
																		</div>
																	</div>
																</div></td>
															<td><div class="form-group">
																	<label class="control-label col-md-3">查询方式</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="qtype">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_qtype"
																					id="<pg:rowid/>_qtype" value="1"
																					<pg:equal value="1">checked</pg:equal>>模糊</label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_qtype"
																					id="<pg:rowid/>_qtype" value="0"
																					<pg:equal value="0">checked</pg:equal>>精确</label>
																			</pg:case>
																		</div>
																	</div>
																</div></td>
															<td><div class="form-group">
																	<label class="control-label col-md-3">范围查询</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="daterange">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_daterange"
																					id="<pg:rowid/>_daterange" value="1"
																					<pg:equal value="1">checked</pg:equal>>是</label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_daterange"
																					id="<pg:rowid/>_daterange" value="0"
																					<pg:equal value="0">checked</pg:equal>>否</label>
																			</pg:case>
																		</div>
																	</div>
																</div></td>
															
															

														</tr>
														<tr>

														<td>
																<div class="form-group">
																	<label class="control-label col-md-3">排序字段</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="sfield">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_sfield"
																					id="<pg:rowid/>_sfield" value="1"
																					<pg:equal value="1">checked</pg:equal>>是</label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_sfield" curpos="<pg:rowid/>"
																					id="<pg:rowid/>_sfield" value="0"
																					<pg:equal value="0">checked</pg:equal>>否</label>
																			</pg:case>
																		</div>
																	</div>
																</div>
															</td>
															<td>
															 
																<div class="form-group">
																	<label class="control-label col-md-3">默排字段 </label>																	
																	<div class="col-md-9"><div class="radio-list">
																				<pg:case colName="defaultsfield">
																					<label class="radio-inline"><input curpos="<pg:rowid/>"
																						type="radio" name="<pg:rowid/>_defaultsfield"
																						id="<pg:rowid/>_defaultsfield" value="1"
																						<pg:equal value="1">checked</pg:equal>>是</label>
																					
																				</pg:case>
																			</div>
																	
																</div>
															</div>	
															</td>
															
															<td><div class="form-group">
																	<label class="control-label col-md-3">排序方式</label>
																	<div class="col-md-9">
																		<div class="radio-list">
																			<pg:case colName="stype">
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_stype"
																					id="<pg:rowid/>_stype" value="1"
																					<pg:equal value="1">checked</pg:equal>>降序</label>
																				<label class="radio-inline"><input
																					type="radio" name="<pg:rowid/>_stype"
																					id="<pg:rowid/>_stype" value="0"
																					<pg:equal value="0">checked</pg:equal>>升序</label>
																			</pg:case>
																		</div>
																	</div>
																</div></td>
														</tr>
														<tr>
															
															<td><div class="form-group">
																	<label class="control-label col-md-3">列表字段</label>
																	<div class="col-md-9">
																		<input type="hidden" id="inlist" name="inlist"
																			class="form-control  select2  input-medium inlist"
																			value="<pg:cell colName="inlist" defaultValue="显示"/>">
																	</div>
																</div></td>
															<td><div class="form-group">
																	<label class="control-label col-md-3">编辑控制</label>
																	<div class="col-md-9">
																		<input type="hidden" id="editcontrolParams"
																			name="editcontrolParams"
																			class="form-control  select2  input-medium editcontrolParams"
																			value="<pg:cell colName="editcontrolParams" defaultValue="显示, 编辑"/>">
																	</div>
																</div></td>
																<td><div class="form-group">
																	<label class="control-label col-md-3">添加控制</label>
																	<div class="col-md-9">
																		<input type="hidden" id="addcontrolParams"
																			name="addcontrolParams"
																			class="form-control  select2  input-medium addcontrolParams"
																			value="<pg:cell colName="addcontrolParams" defaultValue="显示"/>">
																	</div>
																</div></td>
														</tr>
														<tr>
															
															<td><div class="form-group">
																	<label class="control-label col-md-3">查看控制</label>
																	<div class="col-md-9">
																		<input type="hidden" id="viewcontrolParams"
																			name="viewcontrolParams"
																			class="form-control  select2  input-small viewcontrolParams"
																			value="<pg:cell colName="viewcontrolParams" defaultValue="显示"/>"
																	</div>
																</div></td>
															<td colspan="2"><div class="form-group">
																	<label class="control-label col-md-3">默认值</label>
																	<div class="col-md-9">
																		<input type="text"
																			placeholder="<pg:cell colName="fieldName"/>"
																			name="defaultValue" class="form-control  input-small"
																			value="<pg:cell colName="defaultValue"/>">
																	</div>
																</div></td>
														</tr>
														<tr>


															
															<td>
																<div class="form-group">
																	<label class="control-label col-md-3">显示长度</label>
																	<div class="col-md-9">
																		<input type="text" placeholder="maxlength"
																			name="maxlength" class="form-control  input-small"
																			value="<pg:cell colName="maxlength"/>">
																	</div>
																</div>
															</td>
															<td colspan="2"><div class="form-group">
																	<label class="control-label col-md-3">替换串</label>
																	<div class="col-md-9">
																		<input type="text" placeholder="replace"
																			name="replace" class="form-control  input-small"
																			value="<pg:cell colName="replace"/>">
																	</div>
																</div></td>
														</tr>
														<tr>


															<td colspan="3" >
															<div class="col-md-12">
															<div class="form-group">
																<label class="control-label col-md-1">字段注释 
																</label>
																<div class="col-md-11">
																<textarea class="col-md-6 form-control" name="fieldComment" rows="6"><pg:cell colName="fieldComment" htmlEncode="true"/></textarea>
																</div>
															</div>
															</div>	
															</td>
															
															
														</tr>
													</tbody>
												</table> 
											</td>
										</tr>
									</pg:list>

								</tbody>
							</table>
						</div>

						<!-- /table -->
					</div>
					<div class="form-actions">
						<div class="row">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-offset-3 col-md-9">
									
										
										<button type="button" class="btn green"
											onclick="FormValidation.tempsave()">暂存</button>
										<button type="submit" class="btn green">生成代码</button>
										<pg:true actual="${fileexist }" evalbody="true">
											<pg:yes>
												<button type="button" class="btn green"
													onclick="TableAdvanced.readme('${gencodeid }',event)">查看部署说明</button>

											<button type="button" class="btn green" id="viewcode" onclick="window.open('viewCode.page?genid=${gencodeid }','viewsource')">查看源码 </button>		
												<button type="button" class="btn green" id="downcode" onclick="window.open('downcode.page?genid=${gencodeid }','_blank')">  下载</button>
												 
											</pg:yes>
											<pg:no>
												<button type="button" class="btn green  display-hide"
													id="readme">查看部署说明</button>
												<button type="button" class="btn green display-hide" id="viewcode" onclick="window.open('viewCode.page?genid=${gencodeid }','viewsource')">查看源码 </button>
											 
												<button type="button" class="btn green display-hide" id="downcode" onclick="window.open('downcode.page?genid=${gencodeid }','_blank')">  下载</button>
												 
											</pg:no>
										</pg:true>
									</div>
								</div>
							</div>
							<div class="col-md-6"></div>
						</div>
					</div>
				</pg:no>
			</pg:empty>
		</form>
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
<script>
	jQuery(document).ready(function() {
		FormValidation.inittableconfig(${fieldlens});
		UIExtendedModals.init();
		TableAdvanced.initfieldtablelist();
		
		 
	});
</script>

<!-- END PAGE CONTENT-->
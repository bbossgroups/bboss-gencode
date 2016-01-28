package org.frameworkset.gencode.entity;

import org.frameworkset.util.annotations.RequestParam;

public class ControlInfo {
	/**
	 * 存放生成的工程文件的根目录，规范化的存放代码工程的目录结构为： src-modulename WebRoot/modulename
	 * WebRoot/WEB-INF/conf/modulename
	 * 
	 */
	private String sourcedir;
	/**
	 * jsp相对于WebRoot的存放根路径（可选）
	 */
	private String system;
	private String jsppath;
	
	/**
	 * 业务模块的名称，根据模块名称生成存放java源码、前端界面和资源文件、配置文件的存放目录
	 */
	private String moduleName;
	/**
	 * 模块中文名称
	 */
	private String moduleCNName;
	/**
	 * 生成的模块java源码包根路径，同时会在下面建以下子目录： service 存放业务组件、持久层sql配置文件 entity 存放po类
	 * action 存放控制器类 webservice 存放webservice和hessian服务类
	 * 
	 */
	private String packagePath;
	private String tableName;
	/**
	 * 表主键名称，对应tableinfo表中的表名称
	 */
	private String pkname;

	private String controlParams;
	private String theme;
	private String queryFields;
	private String sortFields;

	private String entityName;

	private String dbname;

	private String company;
	private String author;
	private String version;
	private String primaryKeyName;
	private String daoDBName;
	/**
	 * pagineWithDBRownumberOver 1表示使用Rownumber Over分页机制，0表示默认分页机制
	 * 
	 * 如果pagineWithDBRownumberOver为1 ，则必须指定一个排序字段，否则视为普通分页机制处理
	 */
	private int pagineWithDBRownumberOver;
	/**
	 * 实体名称是否截取表名前缀，1 截取 0 不截取
	 * td_user: 1=User 0 TdUser
	 */
	@RequestParam(defaultvalue="1")
	private int ignoreEntityFirstToken = 1;
	public int getIgnoreEntityFirstToken() {
		return ignoreEntityFirstToken;
	}

	public void setIgnoreEntityFirstToken(int ignoreEntityFirstToken) {
		this.ignoreEntityFirstToken = ignoreEntityFirstToken;
	}

	/**
	 * 0:2003 1:2007 2:2010 2:2013
	 */
	private int excelVersion;

	public String getSourcedir() {
		return sourcedir;
	}

	public void setSourcedir(String sourcedir) {
		this.sourcedir = sourcedir;
	}

	public String getSystem() {
		return system;
	}

	public void setSystem(String system) {
		this.system = system;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getModuleCNName() {
		return moduleCNName;
	}

	public void setModuleCNName(String moduleCNName) {
		this.moduleCNName = moduleCNName;
	}

	public String getPackagePath() {
		return packagePath;
	}

	public void setPackagePath(String packagePath) {
		this.packagePath = packagePath;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getPkname() {
		return pkname;
	}

	public void setPkname(String pkname) {
		this.pkname = pkname;
	}

	public String getControlParams() {
		return controlParams;
	}

	public void setControlParams(String controlParams) {
		this.controlParams = controlParams;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getQueryFields() {
		return queryFields;
	}

	public void setQueryFields(String queryFields) {
		this.queryFields = queryFields;
	}

	public String getSortFields() {
		return sortFields;
	}

	public void setSortFields(String sortFields) {
		this.sortFields = sortFields;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}



	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public int getExcelVersion() {
		return excelVersion;
	}

	public void setExcelVersion(int excelVersion) {
		this.excelVersion = excelVersion;
	}

	public String getDbname() {
		return dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
	}

	public String getPrimaryKeyName() {
		return primaryKeyName;
	}

	public void setPrimaryKeyName(String primaryKeyName) {
		this.primaryKeyName = primaryKeyName;
	}

	public String getJsppath() {
		return jsppath;
	}

	public void setJsppath(String jsppath) {
		this.jsppath = jsppath;
	}

	 

	

	public String getDaoDBName() {
		return daoDBName;
	}

	public void setDaoDBName(String daoDBName) {
		this.daoDBName = daoDBName;
	}

	public int getPagineWithDBRownumberOver() {
		return pagineWithDBRownumberOver;
	}

	public void setPagineWithDBRownumberOver(int pagineWithDBRownumberOver) {
		this.pagineWithDBRownumberOver = pagineWithDBRownumberOver;
	}

	

}

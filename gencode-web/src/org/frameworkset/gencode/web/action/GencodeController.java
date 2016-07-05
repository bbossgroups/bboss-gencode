package org.frameworkset.gencode.web.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.frameworkset.cache.FileContentCache;
import org.frameworkset.gencode.core.GencodeServiceImpl;
import org.frameworkset.gencode.core.Util;
import org.frameworkset.gencode.entity.AnnoParam;
import org.frameworkset.gencode.entity.Annotation;
import org.frameworkset.gencode.entity.ConditionField;
import org.frameworkset.gencode.entity.ControlInfo;
import org.frameworkset.gencode.entity.Field;
import org.frameworkset.gencode.entity.FieldInfo;
import org.frameworkset.gencode.entity.ModuleMetaInfo;
import org.frameworkset.gencode.entity.SortField;
import org.frameworkset.gencode.web.entity.Datasource;
import org.frameworkset.gencode.web.entity.Gencode;
import org.frameworkset.gencode.web.entity.GencodeCondition;
import org.frameworkset.gencode.web.service.DatasourceException;
import org.frameworkset.gencode.web.service.GencodeException;
import org.frameworkset.gencode.web.service.GencodeService;
import org.frameworkset.soa.ObjectSerializable;
import org.frameworkset.util.annotations.PagerParam;
import org.frameworkset.util.annotations.ResponseBody;
import org.frameworkset.web.servlet.ModelMap;

import com.frameworkset.common.poolman.DBUtil;
import com.frameworkset.common.poolman.sql.TableMetaData;
import com.frameworkset.util.FileUtil;
import com.frameworkset.util.ListInfo;
import com.frameworkset.util.SimpleStringUtil;
import com.frameworkset.util.StringUtil;

public class GencodeController implements org.frameworkset.spi.InitializingBean,org.frameworkset.spi.DisposableBean{
	private static Logger log = Logger.getLogger(GencodeController.class);
	private GencodeService gencodeService;
	private FileContentCache fileCache = null;

	public @ResponseBody String addDatasource(Datasource datasource) {
		// 控制器
		try {
			if(StringUtil.isEmpty(datasource.getDbname()))
				return "数据源名称为空，请设置要添加的数据源名称!";
			if("gencode".equals(datasource.getDbname()))
			{
				return ("gencode为系统预留数据源名称，从修改为其他数据源名称!");
			}
			Datasource olddatasource = this.gencodeService.getDatasource(datasource.getDbname());
			if (olddatasource == null) {
				gencodeService.addDatasource(datasource);

			} else {
				DBUtil.stopPool(datasource.getDbname());
				datasource.setId(olddatasource.getId());
				datasource.setCreateDate(olddatasource.getCreateDate());
				datasource.setUpdateDate(System.currentTimeMillis());
				gencodeService.updateDatasource(datasource);
			}
			return "success";
		} catch (DatasourceException e) {
			log.error("add Datasource failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("add Datasource failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody String deleteDatasource(String dbname) {
		try {
			if(StringUtil.isEmpty(dbname))
				return "数据源名称为空，请选择要删除的数据源!";
			if("gencode".equals(dbname))
			{
				return ("gencode为系统预留数据源名称，不能删除!");
			}
			gencodeService.deleteDatasource(dbname);
			DBUtil.stopPool(dbname);
			return "success";
		} catch (DatasourceException e) {
			log.error("delete Datasource failed:", e);
			return StringUtil.formatBRException(e);
		} 
		 catch (RuntimeException e) {
				log.error("delete Datasource failed:", e);
				return StringUtil.formatBRException(e);
			}
		catch (Throwable e) {
			log.error("delete Datasource failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public String queryListDatasources(

	ModelMap model) throws DatasourceException {
		try {

			List<Datasource> datasources = gencodeService.queryListDatasources();
			model.addAttribute("datasources", datasources);
			return "path:queryListDatasources";
		} catch (DatasourceException e) {
			throw e;
		} catch (Exception e) {
			throw new DatasourceException("query Datasource failed:", e);
		}

	}

	public @ResponseBody List<Datasource> loadds() {

		return this.gencodeService.queryListDatasources();
	}

	public @ResponseBody String deleteGencode(String id) {
		try {
			gencodeService.deleteGencode(id);
			return "success";
		} catch (GencodeException e) {
			log.error("delete Gencode failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("delete Gencode failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody String deleteBatchGencode(String... ids) {
		try {
			gencodeService.deleteBatchGencode(ids);
			return "success";
		} catch (Throwable e) {
			log.error("delete Batch ids failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody String updateGencode(Gencode gencode) {
		try {
			gencodeService.updateGencode(gencode);
			return "success";
		} catch (Throwable e) {
			log.error("update Gencode failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public String getGencode(String id, ModelMap model) throws GencodeException {
		try {
			if(id == null || id.equals(""))
				return "path:getGencode";
			Gencode gencode = gencodeService.getGencode(id);
			model.addAttribute("gencode", gencode);
			return "path:getGencode";
		} catch (GencodeException e) {
			throw e;
		} catch (Throwable e) {
			throw new GencodeException("get Gencode failed::id=" + id, e);
		}

	}

	public String queryListInfoGencodes(GencodeCondition conditions,
			@PagerParam(name = PagerParam.SORT, defaultvalue = "CREATETIME") String sortKey,
			@PagerParam(name = PagerParam.DESC, defaultvalue = "true") boolean desc,
			@PagerParam(name = PagerParam.OFFSET) long offset,
			@PagerParam(name = PagerParam.PAGE_SIZE, defaultvalue = "10") int pagesize, ModelMap model)
					throws GencodeException {
		try {
			if (sortKey != null && !sortKey.equals("")) {
				conditions.setSortKey(sortKey);
				conditions.setSortDesc(desc);
			}
			String tablename = conditions.getTablename();
			if (tablename != null && !tablename.equals("")) {
				conditions.setTablename("%" + tablename + "%");
			}
			String author = conditions.getAuthor();
			if (author != null && !author.equals("")) {
				conditions.setAuthor("%" + author + "%");
			}
			ListInfo gencodes = gencodeService.queryListInfoGencodes(conditions, offset, pagesize);
			model.addAttribute("gencodes", gencodes);
			return "path:queryListInfoGencodes";
		} catch (GencodeException e) {
			throw e;
		} catch (Exception e) {
			throw new GencodeException("pagine query Gencode failed:", e);
		}

	}

	public String queryListGencodes(GencodeCondition conditions, ModelMap model) throws GencodeException {
		try {

			String tablename = conditions.getTablename();
			if (tablename != null && !tablename.equals("")) {
				conditions.setTablename("%" + tablename + "%");
			}
			String author = conditions.getAuthor();
			if (author != null && !author.equals("")) {
				conditions.setAuthor("%" + author + "%");
			}
			List<Gencode> gencodes = gencodeService.queryListGencodes(conditions);
			model.addAttribute("gencodes", gencodes);
			return "path:queryListGencodes";
		} catch (GencodeException e) {
			throw e;
		} catch (Exception e) {
			throw new GencodeException("query Gencode failed:", e);
		}

	}

	public @ResponseBody List<String> loadtables(String dbname) {
		if(StringUtil.isEmpty(dbname))
			return null;
		
		initDatasource(gencodeService.getDatasource(dbname));
		Set<TableMetaData> tableMetas = DBUtil.getTableMetaDatas(dbname);
		List<String> tables = new ArrayList<String>();
		if (tableMetas != null) {
			for (TableMetaData meta : tableMetas) {
				tables.add(meta.getTableName());
			}
		}
		return tables;
	}

	public @ResponseBody List<String> refreshtables(String dbname) {
		if(StringUtil.isEmpty(dbname))
			return null;
		initDatasource(gencodeService.getDatasource(dbname));
		DBUtil.refreshDatabaseMetaData(dbname);
		Set<TableMetaData> tableMetas = DBUtil.getTableMetaDatas(dbname);
		List<String> tables = new ArrayList<String>();
		if (tableMetas != null) {
			for (TableMetaData meta : tableMetas) {
				tables.add(meta.getTableName());
			}
		}
		return tables;
	}

	private void initDatasource(Datasource ds) {
		DBUtil.startNoPool(ds.getDbname(), ds.getDbdriver(), ds.getDburl(), ds.getDbuser(), ds.getDbpassword(),
				ds.getValidationQuery());
	}

	public String selecttable(ModelMap model, GencodeCondition conditions) {
		List<Datasource> ds = gencodeService.queryListDatasources();
		model.addAttribute("dbs", ds);
		Set<TableMetaData> tableMetas = null;
		if (ds != null && ds.size() > 0) {
			initDatasource(ds.get(0));
			tableMetas = DBUtil.getTableMetaDatas(ds.get(0).getDbname());
		}

		List<String> tables = new ArrayList<String>();
		if (tableMetas != null) {
			for (TableMetaData meta : tableMetas) {
				tables.add(meta.getTableName());
			}
		}
		String tablename = conditions.getTablename();
		if (tablename != null && !tablename.equals("")) {
			conditions.setTablename("%" + tablename + "%");
		}
		String author = conditions.getAuthor();
		if (author != null && !author.equals("")) {
			conditions.setAuthor("%" + author + "%");
		}
		List<Gencode> gencodes = gencodeService.queryListGencodes(conditions);

		model.addAttribute("gencodes", gencodes);
		model.addAttribute("tables", tables);

		return "path:selecttable";
	}

	public String tableconfig(String dbname, String tableName, ModelMap model) {
		if (tableName == null || tableName.equals("") || dbname == null || dbname.equals(""))
			return "path:tableconfig";
		initDatasource(gencodeService.getDatasource(dbname));
		TableMetaData tableMeta = DBUtil.getTableMetaData(dbname, tableName);
		model.addAttribute("table", tableMeta);
		model.addAttribute("tableName", tableName);
		model.addAttribute("dbname", dbname);
		if(!StringUtil.isEmpty(org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH ))
			model.addAttribute("DEFAULT_SOURCEPATH",  org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH );
		List<FieldInfo> fields = Util.getSimpleFields(tableMeta);
		model.addAttribute("fileexist", false);
		model.addAttribute("fields", fields);
		model.addAttribute("fieldlens", fields != null?fields.size():0);
		return "path:tableconfig";
	}

	public String tablereconfig(String gencodeid, ModelMap model) {
		if (gencodeid == null || gencodeid.equals(""))
			return "path:tableconfig";
		Gencode gencode = gencodeService.getGencode(gencodeid);
		if (gencode == null)
			return "path:tableconfig";
		model.addAttribute("gencode", gencode);
		model.addAttribute("tableName", gencode.getTablename());
		model.addAttribute("dbname", gencode.getDbname());
		initDatasource(gencodeService.getDatasource(gencode.getDbname()));
		ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
		String sourcedir = getSourcedir(controlInfo,gencode.getId());
		if (sourcedir != null && !sourcedir.equals("")) {
			File f = new File(sourcedir, controlInfo.getModuleName() + "/readme.txt");
			if (f.exists()) {
				model.addAttribute("fileexist", true);
				
			}
			else
				model.addAttribute("fileexist", false);
		}
		@SuppressWarnings("unchecked")
		List<FieldInfo> fields = ObjectSerializable.toBean(gencode.getFieldinfos(), List.class);
		TableMetaData tableMeta = DBUtil.getTableMetaData(gencode.getDbname(), gencode.getTablename());
		List<FieldInfo> dbfields = Util.getSimpleFields(tableMeta);
		fields = this.mergefields(fields, dbfields);//合并表字段信息
		if(!StringUtil.isEmpty(org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH ))
			model.addAttribute("DEFAULT_SOURCEPATH",  org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH );
		model.addAttribute("fields", fields);
		model.addAttribute("fieldlens", fields != null?fields.size():0);
		model.addAttribute("gencodeid", gencodeid);

		model.addAttribute("controlparams", controlInfo);
		return "path:tableconfig";
	}
	private List<FieldInfo> mergefields(List<FieldInfo> fields,List<FieldInfo> dbfields)
	{
		if(dbfields == null || dbfields.size() == 0)
		{
			if(fields == null || fields.size() == 0)
				return null;
			List<FieldInfo> deleted = new ArrayList<FieldInfo>();
			for(int i = 0; i < fields.size(); i ++)
			{
				FieldInfo field = fields.get(i);
				if(field.getMetatype() == FieldInfo.meta_tablecolumn)
				{
					deleted.add( field);
				}
			}
			for(int i = 0;  i < deleted.size(); i ++)
			{
				fields.remove(deleted.get(i));
			}
			return fields;
		}
		if(fields == null || fields.size() == 0)
			return dbfields;
			
		 
		List<FieldInfo> deleted = new ArrayList<FieldInfo>();
		List<FieldInfo> added = new ArrayList<FieldInfo>();
		//获取新加的字段
		for(int i = 0; i < fields.size(); i ++)
		{
			FieldInfo field = fields.get(i);
			boolean find = false;
			for(int j = 0; j < dbfields.size(); j ++)
			{
				FieldInfo dbfield = dbfields.get(j);
				if(field.getColumnname().equals(dbfield.getColumnname()))
				{
					if(!field.getColumntype().equals(dbfield.getColumntype()))
						field.setColumntype(dbfield.getColumntype());//更新类型
					find = true;
					break;
				}
				
							
			}
			if(!find)
			{
				if(field.getMetatype() == FieldInfo.meta_tablecolumn)
					deleted.add(field);
			}
		}
		
		for(int i = 0; i < dbfields.size(); i ++)
		{
			FieldInfo dbfield = dbfields.get(i);
			boolean find = false;
			for(int j = 0; j < fields.size(); j ++)
			{
				FieldInfo field = fields.get(j);
				if(field.getColumnname().equals(dbfield.getColumnname()))
				{
					
					find = true;
					break;
				}
				
							
			}
			if(!find)
			{
				added.add(dbfield);
			}
		}
		for(int i = 0;  i < deleted.size(); i ++)
		{
			fields.remove(deleted.get(i));
		}
		
		for(int i = 0;  i < added.size(); i ++)
		{
			fields.add(added.get(i));
		}
		//删除字段		

		return fields;
	}

	private void handleConditionFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			if (fieldInfo.getQcondition() == 1) {
				ConditionField bm = new ConditionField();
				this.convertField(gencodeService, fieldInfo, bm, Util.conditionEntity);
				// bm.setColumnname(fieldInfo.getColumnname());
				bm.setLike(fieldInfo.getQtype() == 1);
				// bm.setOr(true);
				gencodeService.addCondition(bm);
			}
		}
	}

	private void handlePK(GencodeServiceImpl gencodeService, List<FieldInfo> fields, ControlInfo controlInfo) {
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			Field f = new Field();
			convertPKField(gencodeService, fieldInfo, f, Util.other, controlInfo.getPrimaryKeyName());
		}
	}

	private void handleSortFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		SortField defaultSortField = null;
		SortField defaultSortfieldInfo = null;
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			if (fieldInfo.getSfield() == 1) {
				SortField id = new SortField();
				// id.setColumnname(fieldInfo.getColumnname());
				id.setDesc(fieldInfo.getStype() == 1);
				this.convertField(gencodeService, fieldInfo, id, Util.other);
				if(defaultSortfieldInfo == null)
					defaultSortfieldInfo = id;
				if(fieldInfo.getDefaultsfield() == 1)
				{
					defaultSortField = id;
				}
//				if (i == 0) {
//					id.setDefaultSortField(true);
//					gencodeService.setDefaultSortField(id);
//				}

				gencodeService.addSortField(id);
			}
		}
		
		if (defaultSortField != null) {
			gencodeService.setDefaultSortField(defaultSortField);
		}
		else if(defaultSortfieldInfo != null) 
		{
			defaultSortfieldInfo.setDefaultSortField(true);
			gencodeService.setDefaultSortField(defaultSortfieldInfo);
		}

	}

	private String extendType(String type) {
		if (type.equals("url") || type.equals("creditcard") || type.equals("email") || type.equals("file")
				|| type.equals("idcard") || type.equals("textarea") || type.equals("htmleditor") || type.equals("word")
				|| type.equals("excel") || type.equals("ppt") || type.equals("fuction")) {
			return "String";
		} else
			return type;
	}

	private void convertPKField(GencodeServiceImpl gencodeService, FieldInfo fieldInfo, Field f, int pagetype,
			String primaryKeyName) {
		if (!primaryKeyName.equals(fieldInfo.getColumnname()))
			return;
		f.setType(extendType(fieldInfo.getType()));
		f.setExtendType(fieldInfo.getType());
		f.setFieldCNName(fieldInfo.getFieldCNName());
		f.setColumntype(fieldInfo.getColumntype());
		if(!StringUtil.isEmpty(fieldInfo.getFieldComment()))
			f.setFieldComment(fieldInfo.getFieldComment());
		else if(!StringUtil.isEmpty(fieldInfo.getFieldCNName()))
		{
			f.setFieldComment(fieldInfo.getFieldCNName());
		}
		if (gencodeService.isGenI18n()) {
			if(!StringUtil.isEmpty(fieldInfo.getFieldCNName()))
				f.setFieldAsciiCNName(SimpleStringUtil.native2ascii(fieldInfo.getFieldCNName()));
			else
				f.setFieldAsciiCNName(fieldInfo.getFieldName());
		}

		f.setPk(true);
		if (gencodeService.getModuleMetaInfo().isAutogenprimarykey()) {
			Annotation anno = new Annotation();
			anno.setName("PrimaryKey");
			if (SimpleStringUtil.isNotEmpty(gencodeService.getModuleMetaInfo().getPkname())) {
				anno.addAnnotationParam("pkname", gencodeService.getModuleMetaInfo().getPkname(), AnnoParam.V_STRING);
			}
			f.addAnnotation(anno);

			gencodeService.addEntityImport("com.frameworkset.orm.annotation.PrimaryKey");
		}
		if (fieldInfo.getColumntype().equals("CLOB") || fieldInfo.getColumntype().equals("TEXT")) {
			Annotation anno = new Annotation();
			anno.setName("Column");
			anno.addAnnotationParam("type", "clob", AnnoParam.V_STRING);
			f.addAnnotation(anno);
			gencodeService.addEntityImport("com.frameworkset.orm.annotation.Column");
		} else if (fieldInfo.getColumntype().equals("BLOB")) {
			Annotation anno = new Annotation();
			anno.setName("Column");
			anno.addAnnotationParam("type", "blob", AnnoParam.V_STRING);
			gencodeService.addEntityImport("com.frameworkset.orm.annotation.Column");
			f.addAnnotation(anno);
		} else if (fieldInfo.getColumntype().startsWith("TIMESTAMP") || fieldInfo.getColumntype().equals("DATE")  || fieldInfo.getColumntype().equals("DATETIME"))
		// else if(fieldInfo.getType().equals("UtilDate") ||
		// fieldInfo.getType().equals("Timestamp") ||
		// fieldInfo.getType().equals("Date") )
		{
			f.setDatetype(true);
			if (!gencodeService.isNeedDateComponent())
				gencodeService.setNeedDateComponent(true);
			if (fieldInfo.getDateformat() != null && !fieldInfo.getDateformat().equals("")) {
				Annotation anno = new Annotation();
				anno.setName("RequestParam");
				anno.addAnnotationParam("dateformat", fieldInfo.getDateformat(), AnnoParam.V_STRING);

				gencodeService.addEntityImport("org.frameworkset.util.annotations.RequestParam");

				f.addAnnotation(anno);
			}
			 
		}
		if (fieldInfo.getType() != null) {
			if (fieldInfo.getType().equals("UtilDate")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.util.Date");
					f.setType("Date");

				} else {

					gencodeService.addEntityImport("java.util.Date");
					f.setType("Date");
				}
			} else if (fieldInfo.getType().equals("Timestamp")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.sql.Timestamp");

				} else {

					gencodeService.addEntityImport("java.sql.Timestamp");

				}
			} else if (fieldInfo.getType().equals("Date")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.sql.Date");

				} else {
					gencodeService.addEntityImport("java.sql.Date");

				}
			}
		}
		f.setMfieldName(fieldInfo.getMfieldName());
		f.setFieldName(fieldInfo.getFieldName());
		f.setColumnname(fieldInfo.getColumnname());

		f.setTypecheck(fieldInfo.getTypecheck() == 1);
		f.setDaterange(fieldInfo.getDaterange() == 1);
		f.setDateformat(fieldInfo.getDateformat());
		f.setNumformat(fieldInfo.getNumformat());

		f.setDefaultValue(fieldInfo.getDefaultValue());
		f.setReplace(fieldInfo.getReplace());
		f.setMaxlength(fieldInfo.getMaxlength());
		f.setMinlength(fieldInfo.getMinlength());
		if (Util.addpage == pagetype) {
			f.setEditable(fieldInfo.getEditcontrolParams().contains("编辑"));
			f.setRequired(fieldInfo.getAddcontrolParams().contains("必填"));
			f.setReadonly(fieldInfo.getEditcontrolParams().contains("只读"));
		} else if (Util.editpage == pagetype) // "显示","隐藏", "编辑", "必填","只读","忽略"
		{
			f.setEditable(fieldInfo.getEditcontrolParams().contains("编辑"));
			f.setRequired(fieldInfo.getEditcontrolParams().contains("必填"));
			f.setReadonly(fieldInfo.getEditcontrolParams().contains("只读"));

		}

		gencodeService.setPrimaryField(f);
		gencodeService.setPrimaryKeyName(f.getFieldName());

	}

	private Field convertField(GencodeServiceImpl gencodeService, FieldInfo fieldInfo, Field f, int pagetype) {
		f.setType(extendType(fieldInfo.getType()));
		f.setExtendType(fieldInfo.getType());
		f.setFieldCNName(fieldInfo.getFieldCNName());
		f.setColumntype(fieldInfo.getColumntype());
		if(!StringUtil.isEmpty(fieldInfo.getFieldComment()))
			f.setFieldComment(fieldInfo.getFieldComment());
		else if(!StringUtil.isEmpty(fieldInfo.getFieldCNName()))
		{
			f.setFieldComment(fieldInfo.getFieldCNName());
		}
		if (gencodeService.isGenI18n()) {
//			f.setFieldAsciiCNName(SimpleStringUtil.native2ascii(fieldInfo.getFieldCNName()));
			if(!StringUtil.isEmpty(fieldInfo.getFieldCNName()))
				f.setFieldAsciiCNName(SimpleStringUtil.native2ascii(fieldInfo.getFieldCNName()));
			else
				f.setFieldAsciiCNName(fieldInfo.getFieldName());
		}

		f.setPk(gencodeService.getPrimaryKeyColumnName() != null
				&& gencodeService.getPrimaryKeyColumnName().equals(fieldInfo.getColumnname()));
		if(Util.conditionEntity != pagetype)
		{
			if (f.isPk()) {
				if (gencodeService.getModuleMetaInfo().isAutogenprimarykey()) {
					Annotation anno = new Annotation();
					anno.setName("PrimaryKey");
					if (SimpleStringUtil.isNotEmpty(gencodeService.getModuleMetaInfo().getPkname())) {
						anno.addAnnotationParam("pkname", gencodeService.getModuleMetaInfo().getPkname(),
								AnnoParam.V_STRING);
					}
					f.addAnnotation(anno);
	
				}
			}
		}
		if (fieldInfo.getColumntype().equals("CLOB") || fieldInfo.getColumntype().equals("TEXT")) {
			if(Util.conditionEntity != pagetype)
			{
				Annotation anno = new Annotation();
				anno.setName("Column");
				anno.addAnnotationParam("type", "clob", AnnoParam.V_STRING);
				f.addAnnotation(anno);
				
				gencodeService.addEntityImport("com.frameworkset.orm.annotation.Column");
			}
		} else if (fieldInfo.getColumntype().equals("BLOB")) {
			if(Util.conditionEntity != pagetype)
			{
				Annotation anno = new Annotation();
				anno.setName("Column");
				anno.addAnnotationParam("type", "blob", AnnoParam.V_STRING);
				gencodeService.addEntityImport("com.frameworkset.orm.annotation.Column");
				f.addAnnotation(anno);
			}
		}

		else if (fieldInfo.getColumntype().startsWith("TIMESTAMP") || fieldInfo.getColumntype().equals("DATE")  || fieldInfo.getColumntype().equals("DATETIME"))
		// else if(fieldInfo.getType().equals("UtilDate") ||
		// fieldInfo.getType().equals("Timestamp") ||
		// fieldInfo.getType().equals("Date") )
		{

			f.setDatetype(true);
			if (!gencodeService.isNeedDateComponent())
				gencodeService.setNeedDateComponent(true);
			if (fieldInfo.getDateformat() != null && !fieldInfo.getDateformat().equals("")) {
				Annotation anno = new Annotation();
				anno.setName("RequestParam");
				anno.addAnnotationParam("dateformat", fieldInfo.getDateformat(), AnnoParam.V_STRING);

				gencodeService.addEntityImport("org.frameworkset.util.annotations.RequestParam");

				f.addAnnotation(anno);
			}
			
		}
		if (fieldInfo.getType() != null) {
			if (fieldInfo.getType().equals("UtilDate")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.util.Date");
					f.setType("Date");

				} else {

					gencodeService.addEntityImport("java.util.Date");
					f.setType("Date");
				}
			} else if (fieldInfo.getType().equals("Timestamp")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.sql.Timestamp");

				} else {

					gencodeService.addEntityImport("java.sql.Timestamp");

				}
			} else if (fieldInfo.getType().equals("Date")) {
				if (f instanceof ConditionField) {
					gencodeService.addConditionImport("java.sql.Date");

				} else {
					gencodeService.addEntityImport("java.sql.Date");

				}
			}
		}
		f.setMfieldName(fieldInfo.getMfieldName());
		f.setFieldName(fieldInfo.getFieldName());
		f.setColumnname(fieldInfo.getColumnname());

		f.setTypecheck(fieldInfo.getTypecheck() == 1);
		f.setDaterange(fieldInfo.getDaterange() == 1);
		f.setDateformat(fieldInfo.getDateformat());
		f.setNumformat(fieldInfo.getNumformat());

		f.setDefaultValue(fieldInfo.getDefaultValue());
		f.setReplace(fieldInfo.getReplace());
		f.setMaxlength(fieldInfo.getMaxlength());
		f.setMinlength(fieldInfo.getMinlength());
		if (Util.addpage == pagetype) {
			f.setEditable(fieldInfo.getEditcontrolParams().contains("编辑"));
			f.setRequired(fieldInfo.getAddcontrolParams().contains("必填"));
			f.setReadonly(fieldInfo.getEditcontrolParams().contains("只读"));
		} else if (Util.editpage == pagetype) // "显示","隐藏", "编辑", "必填","只读","忽略"
		{
			f.setEditable(fieldInfo.getEditcontrolParams().contains("编辑"));
			f.setRequired(fieldInfo.getEditcontrolParams().contains("必填"));
			f.setReadonly(fieldInfo.getEditcontrolParams().contains("只读"));

		}

		return f;

	}

	private void handleListFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		List<Field> listShowFields = new ArrayList<Field>();
		List<Field> listHiddenFields = new ArrayList<Field>();
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			String inlist = fieldInfo.getInlist();
			Field f = new Field();
			if (inlist != null) {

				if (inlist.contains("显示")) {

					convertField(gencodeService, fieldInfo, f, Util.listpage);
//					if (f.isPk()) {
//						listShowFields.add(0, f);
//					} else 
					{
						listShowFields.add(f);
					}
				} else if (inlist.contains("隐藏")) {

					convertField(gencodeService, fieldInfo, f, Util.listpage);
//					if (f.isPk()) {
//						listHiddenFields.add(0, f);
//					} else 
					{
						listHiddenFields.add(f);
					}
				} else if (inlist.contains("忽略") || inlist.trim().equals("")) {
					continue;
				}

			}

		}
		gencodeService.setListHiddenFields(listHiddenFields);
		gencodeService.setListShowFields(listShowFields);
	}

	private void handleAddFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		List<Field> addShowFields = new ArrayList<Field>();
		List<Field> addHiddenFields = new ArrayList<Field>();
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			String inlist = fieldInfo.getAddcontrolParams();
			if (inlist != null)
			{
				if (inlist.contains("显示")) {
					Field f = new Field();
					convertField(gencodeService, fieldInfo, f, Util.addpage);
//					if (f.isPk()) {
//						addShowFields.add(0, f);
//					} else 
					{
						addShowFields.add(f);
					}
				}				
				else if ( inlist.contains("隐藏")) {
					Field f = new Field();
					convertField(gencodeService, fieldInfo, f, Util.addpage);
//					if (f.isPk()) {
//						addHiddenFields.add(0, f);
//					} 
//					else 
					{
						addHiddenFields.add(f);
					}
				}
			}

		}
		gencodeService.setAddShowFields(addShowFields);
		gencodeService.setAddHiddenFields(addHiddenFields);
	}

	private void handleEntityFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		List<Field> entityFields = new ArrayList<Field>();
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			Field f = new Field();
			convertField(gencodeService, fieldInfo, f, Util.other);
			if (f.isPk())
				entityFields.add(0, f);
			else
				entityFields.add(f);

		}
		gencodeService.setEntityFields(entityFields);
	}

	private void handleEditorFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		List<Field> editShowFields = new ArrayList<Field>();
		List<Field> editHiddenFields = new ArrayList<Field>();
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			String inlist = fieldInfo.getEditcontrolParams();
			Field f = new Field();
			if (inlist != null) // "显示","隐藏", "编辑", "必填","只读","忽略"
			{
				if (inlist.contains("显示")) {
					convertField(gencodeService, fieldInfo, f, Util.editpage);
//					if (f.isPk())
//						editShowFields.add(0, f);
//					else
						editShowFields.add(f);
				} else if (inlist.contains("隐藏")) {
					convertField(gencodeService, fieldInfo, f, Util.editpage);
//					if (f.isPk())
//						editHiddenFields.add(0, f);
//					else
						editHiddenFields.add(f);
				} else {
					continue;
				}

			}

		}
		gencodeService.setEditShowFields(editShowFields);
		gencodeService.setEditHiddenFields(editHiddenFields);
	}

	private void handleViewFields(GencodeServiceImpl gencodeService, List<FieldInfo> fields) {
		List<Field> viewShowFields = new ArrayList<Field>();
		List<Field> viewHiddenFields = new ArrayList<Field>();
		for (int i = 0; fields != null && i < fields.size(); i++) {
			FieldInfo fieldInfo = fields.get(i);
			String inlist = fieldInfo.getViewcontrolParams();

			if (inlist != null )
			{
				if(inlist.contains("隐藏")) {
					Field f = new Field();
					convertField(gencodeService, fieldInfo, f, Util.viewpage);
					viewHiddenFields.add(f);
				} 
				else if (inlist.contains("显示")){
					Field f = new Field();
					convertField(gencodeService, fieldInfo, f, Util.viewpage);
//					if (f.isPk())
//						viewShowFields.add(0, f);
//					else
						viewShowFields.add(f);
				}
				else if(inlist.contains("忽略")) {
					
				}
				
			}
		}
		gencodeService.setViewShowFields(viewShowFields);
		gencodeService.setViewHiddenFields(viewHiddenFields);
	}

	private String getSourcedir(ControlInfo controlInfo,String gencodeid)
	{
		String path = "";
		if(StringUtil.isEmpty(org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH))
		{
			path = controlInfo.getSourcedir();// 生成文件存放的物理目录，如果不存在，会自动创建
		}
		else
		{
			path = StringUtil.getRealPath(org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH,gencodeid);
			
		}
		return path;
	}
	public @ResponseBody Map<String, String> gencode(ControlInfo controlInfo, List<FieldInfo> fields,
			String gencodeid) {
		Map<String, String> ret = new HashMap<String, String>();
		// 先保存配置信息，成功后再生成代码
		this.initDatasource(gencodeService.getDatasource(controlInfo.getDbname()));
		Gencode gencode = _tempsave(controlInfo, fields, gencodeid, ret);

		GencodeServiceImpl gencodeService = new GencodeServiceImpl(true);
		ModuleMetaInfo moduleMetaInfo = new ModuleMetaInfo();
		moduleMetaInfo.setTableName(controlInfo.getTableName());// 指定表名，根据表结构来生成所有的文件
		moduleMetaInfo.setPkname(controlInfo.getPkname());// 设置oracle
															// sequence名称，用来生成表的主键,对应TABLEINFO表中TABLE_NAME字段的值
		moduleMetaInfo.setSystem(controlInfo.getSystem());// lcjf,系统代码，如果指定了system，那么对应的jsp页面会存放到lcjf/area目录下面，对应的mvc组件装配文件存在在/WEB-INF/conf/lcjf下面，否则jsp在/area下，mvc组件装配文件存在在/WEB-INF/conf/area下
		moduleMetaInfo.setModuleName(controlInfo.getModuleName());// 指定模块名称，源码和配置文件都会存放在相应模块名称的目录下面
		moduleMetaInfo.setModuleCNName(controlInfo.getModuleCNName());// 指定模块中文名称
		moduleMetaInfo.setDatasourceName(controlInfo.getDbname());// 指定数据源名称，在poolman.xml文件中配置
		moduleMetaInfo.setPackagePath(controlInfo.getPackagePath());// java程序对应的包路径

		moduleMetaInfo.setAutogenprimarykey(controlInfo.getControlParams().contains("autopk"));
		// moduleMetaInfo.setServiceName("AreaManagerService");
		 moduleMetaInfo.setSourcedir(getSourcedir(  controlInfo,  gencode.getId()));// 生成文件存放的物理目录，如果不存在，会自动创建
		 
		moduleMetaInfo.setIgnoreEntityFirstToken(true); // 忽略表的第一个下滑线签名的token，例如表名td_app_bom中，只会保留app_bom部分，然后根据这部分来生成实体、配置文件名称
		moduleMetaInfo.setAuthor(controlInfo.getAuthor());// 程序作者
		moduleMetaInfo.setCompany(controlInfo.getCompany());// 公司信息
		moduleMetaInfo.setVersion(controlInfo.getVersion());// 版本信息
		moduleMetaInfo.setJsppath(controlInfo.getJsppath());
		moduleMetaInfo.setIgnoreEntityFirstToken(controlInfo.getIgnoreEntityFirstToken() == 1);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = format.format(new Date());
		moduleMetaInfo.setDate(date);// 指定日期
		gencodeService.setGenI18n(controlInfo.getControlParams().contains("geni18n"));// 生成国际化属性配置文件
		gencodeService.setGenRPCservice(controlInfo.getControlParams().contains("genRPC"));
		moduleMetaInfo.setClearSourcedir(controlInfo.getControlParams().contains("clearSourcedir"));// 是否清空源码目录
		gencodeService.setExcelVersion(controlInfo.getExcelVersion());
		gencodeService.setExportExcel(gencodeService.getExcelVersion() != -1);
		gencodeService.setTheme(controlInfo.getTheme());// 设置默认主题风格
		gencodeService.setModuleMetaInfo(moduleMetaInfo);
		gencodeService.setControlInfo(controlInfo);

		// 处理主键信息
		handlePK(gencodeService, fields, controlInfo);
		/************ 以下代码片段指定界面查询字段，以及查询条件组合方式、是否是模糊查询等 *******/
		handleConditionFields(gencodeService, fields);
		// ConditionField bm = new ConditionField();
		// bm.setColumnname("TABLENAME");
		// bm.setLike(true);
		// bm.setOr(true);
		// gencodeService.addCondition(bm);
		//
		// ConditionField bm1 = new ConditionField();
		// bm1.setColumnname("AUTHOR");
		// bm1.setLike(true);
		// bm1.setOr(true);
		// gencodeService.addCondition(bm1);

		/************ 以上代码片段指定界面查询字段，以及查询条件组合方式、是否是模糊查询等 ********/
		/************ 以下代码片段指定界面排序字段 **********************************/
		handleSortFields(gencodeService, fields);
		// SortField id = new SortField();
		// id.setColumnname("CREATETIME");
		// id.setDesc(true);
		// id.setDefaultSortField(true);
		// gencodeService.addSortField(id);
		/************ 以上代码片段指定界面排序字段 **********************************/

		handleListFields(gencodeService, fields);
		handleAddFields(gencodeService, fields);
		handleEditorFields(gencodeService, fields);
		handleViewFields(gencodeService, fields);
		handleEntityFields(gencodeService, fields);
		try {
			gencodeService.genCode();// 执行代码生成逻辑
			ret.put("result", "success");
		} catch (IllegalArgumentException e) {
			ret.put("result", e.getMessage());
			
		}
		 catch (Exception e) {
				ret.put("result", StringUtil.formatBRException(e));
				
			}
		return ret;

	}

	public @ResponseBody Map<String, String> tempsave(ControlInfo controlInfo, List<FieldInfo> fields,
			String gencodeid) {
		Map<String, String> ret = new HashMap<String, String>();
		_tempsave(controlInfo, fields, gencodeid, ret);
		return ret;
	}

	private Gencode _tempsave(ControlInfo controlInfo, List<FieldInfo> fields, String gencodeid, Map<String, String> ret) {
		// 控制器

		try {

			Gencode gencode = new Gencode();
			if (gencodeid == null || gencodeid.equals("")) {
				 
				gencode.setAuthor(controlInfo.getAuthor());
				gencode.setCompany(controlInfo.getCompany());
				gencode.setCreatetime(System.currentTimeMillis());
				gencode.setDbname(controlInfo.getDbname());
				gencode.setTablename(controlInfo.getTableName());
				gencode.setUpdatetime(gencode.getCreatetime());
				gencode.setControlparams(ObjectSerializable.toXML(controlInfo));
				gencode.setFieldinfos(ObjectSerializable.toXML(fields));
				gencode.setMoudleCNName(controlInfo.getModuleCNName());
				gencode.setMoudleName(controlInfo.getModuleName());
				gencodeService.addGencode(gencode);
				ret.put("gencodeid", gencode.getId());
			} else {
				
				gencode.setAuthor(controlInfo.getAuthor());
				gencode.setCompany(controlInfo.getCompany());
//				gencode.setCreatetime(System.currentTimeMillis());
				gencode.setDbname(controlInfo.getDbname());
				gencode.setTablename(controlInfo.getTableName());
				gencode.setUpdatetime(System.currentTimeMillis());
				gencode.setControlparams(ObjectSerializable.toXML(controlInfo));
				gencode.setFieldinfos(ObjectSerializable.toXML(fields));
				gencode.setMoudleCNName(controlInfo.getModuleCNName());
				gencode.setMoudleName(controlInfo.getModuleName());
				gencode.setId(gencodeid);
				gencodeService.updateGencode(gencode);
				ret.put("gencodeid", gencode.getId());
			}
			ret.put("result", "success");
			return gencode;
		} catch (GencodeException e) {
			log.error("add Gencode failed:", e);
			ret.put("result", StringUtil.formatBRException(e));
		} catch (Throwable e) {
			log.error("add Gencode failed:", e);
			ret.put("result", StringUtil.formatBRException(e));
		}
		return null;

	}

	public String index(ModelMap model) {
		// Set<TableMetaData> tableMetas = DBUtil.getTableMetaDatas("bspf");
		// model.addAttribute("tables", tableMetas);

		return "path:index";
	}

	/**
	 * 表单列表查询，配置历史
	 * 
	 * @param model
	 * @return
	 */
	public String formlist(ModelMap model) {
		return "path:formlist";
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	public String genlist(ModelMap model, GencodeCondition conditions) {
		String tablename = conditions.getTablename();
		if (tablename != null && !tablename.equals("")) {
			conditions.setTablename("%" + tablename + "%");
		}
		String author = conditions.getAuthor();
		if (author != null && !author.equals("")) {
			conditions.setAuthor("%" + author + "%");
		}
		List<Gencode> gencodes = gencodeService.queryListGencodes(conditions);
		for (int i = 0; gencodes != null && i < gencodes.size(); i++) {
			Gencode gencode = gencodes.get(i);

			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			String sourcedir = getSourcedir(controlInfo,gencode.getId());
			if (sourcedir != null && !sourcedir.equals("")) {
				File f = new File(sourcedir, controlInfo.getModuleName() + "/readme.txt");
				if (f.exists()) {
					gencode.setFileexist(true);
				}
			}
		}

		model.addAttribute("gencodes", gencodes);
		return "path:genlist";
	}

	public @ResponseBody String deletegencode(String genid) {

		Gencode gencode = gencodeService.getGencode(genid);
		if (gencode == null) {
			return "norecord";
		} else {
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {
				File f = new File(sourcedir);
				FileUtil.deleteFile(f.getAbsolutePath());
			}
			gencodeService.deleteGencode(genid);
		}
		return "success";
	}

	/**
	 * 查看源码
	 * @param genid
	 * @param model
	 * @return
	 */
	public String viewCode(String genid, ModelMap model)
	{
		if(genid == null || genid.equals(""))
			return null;
		model.addAttribute("genid",genid);
		Gencode gencode = gencodeService.getGencode(genid);
		if (gencode == null) {
			return null;
		} else {
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			String m = StringUtil.isEmpty(controlInfo.getModuleCNName())
					? controlInfo.getModuleName() : controlInfo.getModuleCNName();
			model.addAttribute("modulename", m);
			model.addAttribute("gencode",gencode);
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {
				File f = new File(sourcedir, controlInfo.getModuleName() + "/readme.txt");
				if (!f.exists()) {
					model.addAttribute("readme", "没有生成"+m+"代码部署说明文件：" + f.getAbsolutePath());
				} else {

					String content = null;
//					try {
//						content = FileUtil.getFileContent(f, "UTF-8");
//						model.addAttribute("readme", StringUtil.HTMLEncode(content));
						content = fileCache.getFileContent(f.getAbsolutePath(), "UTF-8", FileContentCache.HTMLNoBREncode);
						
						model.addAttribute("readme", content);
//					} catch (IOException e) {
//						// TODO Auto-generated catch block
//						log.error("readme failed:", e);
//						model.addAttribute("msg", StringUtil.exceptionToString(e));
//					}

				}
			} else {
				model.addAttribute("readme", "没有生成"+m+"代码部署说明");
			}
		}
		return "path:viewCode";
	}
	
	/**
	 * <?php
$records = array();
$records['nodes'] = array();

$id = isset($_REQUEST['id']) ? $_REQUEST['id'] : '0';
$level = 1;
if ($id != '0') {
	$id = explode(':', $id);
	$level = $id[1] + 1;
}

for($i = 1; $i < 6; $i++) {
	$id_ = time() + rand(1000, 20000) . ':' . ($level);
	$records['nodes'][] = array('id' => $id_, 'parent' => $id, 'name' => 'Node - ' . $level . ' - ' . $i, 'level' => $level, 'type' => 'folder');
}

echo json_encode($records);
?>


	 * @param id
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	public @ResponseBody Map<String,List<HashMap<String,Object>>> viewCodeFiles(String genid,String id, ModelMap model) throws IOException
	{
		HashMap<String,List<HashMap<String,Object>>> nodes = new HashMap<String,List<HashMap<String,Object>>>();
		
		
		if(StringUtil.isEmpty(id) || StringUtil.isEmpty(genid ) || id.indexOf("../") > 0)
			return nodes;
		
		Gencode gencode = gencodeService.getGencode(genid);
		if (gencode == null) {
			 
		} else {
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			model.addAttribute("modulename", StringUtil.isEmpty(controlInfo.getModuleCNName())
					? controlInfo.getModuleName() : controlInfo.getModuleCNName());
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {
			
				File f = new File(sourcedir, controlInfo.getModuleName());
				if (!f.exists()) {
					model.addAttribute("msg", "nofile:" + f.getAbsolutePath());
				} else {
					int level = 0;
					String parentPath = null;
					if(id.equals("0"))
					{
						level = 0;
					}
					else
					{
						String[] tokens= id.split(":");
						parentPath = tokens[0];
						level = Integer.parseInt(tokens[1]) + 1;
						f = new File(f,parentPath);
					}
					 
					List<HashMap<String,Object>> datas = new ArrayList<HashMap<String,Object>>();
					nodes.put("nodes", datas);
					String prepath = StringUtil.getRealPath(sourcedir, controlInfo.getModuleName());
					File[] fs = f.listFiles();
					if(fs != null && fs.length > 0)
					{
						for(File subf:fs)
						{
							String path = subf.getCanonicalPath().substring(prepath.length());
							HashMap<String,Object> node = new HashMap<String,Object>();
							node.put("id", path.replace('\\', '/')+":"+level);
							node.put("name", subf.getName());
							node.put("level", level);
							node.put("type", subf.isDirectory()?"folder":"file");							
							node.put("parent", id);
							datas.add(node);
						}
						 
					}
					

				}
			} 
		}
		
		 
		return nodes;
	}
	
	public String viewCodeFile(String genid,String path, ModelMap model) {
		if(StringUtil.isEmpty(genid) || StringUtil.isEmpty(path) || (path.indexOf("../") > 0))
		{
			model.addAttribute("msg", "参数非法");
			model.addAttribute("modulename", "");
			return "path:viewCodeFile";
		}
		Gencode gencode = gencodeService.getGencode(genid);
		path = path.split(":")[0];
		
			
		model.addAttribute("path", path);
		if (gencode == null) {
			model.addAttribute("msg", "norecord");
			model.addAttribute("modulename", "");
		} else {
			
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			model.addAttribute("modulename", StringUtil.isEmpty(controlInfo.getModuleCNName())
					? controlInfo.getModuleName() : controlInfo.getModuleCNName());
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {
				File f = new File(sourcedir, controlInfo.getModuleName() );
				f = new File(f,path);
				if (!f.exists()) {
					model.addAttribute("msg", "nofile:" + f.getAbsolutePath());
				} else {
					String filetype= f.getName().substring(f.getName().lastIndexOf('.')+1);
					model.addAttribute("filetype", filetype);
					String content = null;
//					try {
//						content = FileUtil.getFileContent(f, "UTF-8");
//						model.addAttribute("readme", StringUtil.HTMLEncode(content));
						content = fileCache.getFileContent(f.getAbsolutePath(), "UTF-8", FileContentCache.HTMLNoBREncode);
						
						model.addAttribute("code", content);
//					} catch (IOException e) {
//						// TODO Auto-generated catch block
//						log.error("readme failed:", e);
//						model.addAttribute("msg", StringUtil.exceptionToString(e));
//					}

				}
			} else {
				model.addAttribute("msg", "nofile");
			}
		}
		return "path:viewCodeFile";
	}
	public String readme(String genid, ModelMap model) {
		Gencode gencode = gencodeService.getGencode(genid);
		if (gencode == null) {
			model.addAttribute("msg", "norecord");
			model.addAttribute("modulename", "");
		} else {
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			model.addAttribute("modulename", StringUtil.isEmpty(controlInfo.getModuleCNName())
					? controlInfo.getModuleName() : controlInfo.getModuleCNName());
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {
				File f = new File(sourcedir, controlInfo.getModuleName() + "/readme.txt");
				if (!f.exists()) {
					model.addAttribute("msg", "nofile:" + f.getAbsolutePath());
				} else {

					String content = null;
//					try {
//						content = FileUtil.getFileContent(f, "UTF-8");
//						model.addAttribute("readme", StringUtil.HTMLEncode(content));
						content = fileCache.getFileContent(f.getAbsolutePath(), "UTF-8", FileContentCache.HTMLEncode);
						
						model.addAttribute("readme", content);
//					} catch (IOException e) {
//						// TODO Auto-generated catch block
//						log.error("readme failed:", e);
//						model.addAttribute("msg", StringUtil.exceptionToString(e));
//					}

				}
			} else {
				model.addAttribute("msg", "nofile");
			}
		}
		return "path:readme";
	}
	
	

	public @ResponseBody File downcode(String genid) {
		Gencode gencode = gencodeService.getGencode(genid);
		if (gencode == null) {
			return null;
		} else {
			ControlInfo controlInfo = ObjectSerializable.toBean(gencode.getControlparams(), ControlInfo.class);
			String sourcedir = getSourcedir(controlInfo,genid);
			if (sourcedir != null && !sourcedir.equals("")) {

				File f = new File(sourcedir, controlInfo.getModuleName());
				if (!f.exists()) {
					return null;
				} else {
					File ret = new File(sourcedir, controlInfo.getModuleName() + ".zip");
					if(ret.exists())
						return ret;
					FileUtil.zip(f, ret);
					return ret;
				}
					
			} else {
				return null;
			}
		}
	}

	@Override
	public void destroy() throws Exception {
		if(fileCache != null)
			fileCache.destroy();
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		fileCache = new FileContentCache();
		fileCache.start("Code Deploy Readme");
	}
	

	

}

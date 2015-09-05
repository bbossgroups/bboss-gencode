package org.frameworkset.gencode.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import org.apache.log4j.Logger;
import org.frameworkset.spi.BaseApplicationContext;
import org.frameworkset.spi.event.IocLifeCycleEventListener;

import com.frameworkset.common.poolman.SQLExecutor;
import com.frameworkset.common.poolman.util.SQLUtil;

public class GencodeIocLifeCycleEventListener implements IocLifeCycleEventListener {
	private static Logger log = Logger.getLogger(GencodeIocLifeCycleEventListener.class);
	private String sqlitepath;
	public GencodeIocLifeCycleEventListener() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void afterstart(BaseApplicationContext arg0) {
		// TODO Auto-generated method stub

	}
	public static void initConfgDB(String dbpath)
	{
		SQLUtil.startPool("gencode","org.sqlite.JDBC","jdbc:sqlite://"+dbpath,"root","root",
				 null,//"false",
				
				 null,// "READ_UNCOMMITTED",
				 "select 1",
				 "jndi-bigdata_conf" ,   
	        		10,
	        		10,
	        		20,
	        		true,
	        		false,
	        		null        ,false,false
	        		);
		String exist = "select 1 from BBOSS_GENCODE";
		
		try {
			SQLExecutor.queryObjectWithDBName(int.class,"gencode", exist);
		} catch (Exception e) {
			String tsql = "create table BBOSS_GENCODE (ID string,TABLENAME string,DBNAME string,FIELDINFOS CLOB,AUTHOR string,"
				       + "COMPANY string,"
				       + "CREATETIME number(10),"
				       + "UPDATETIME number(10),"
				       + "CONTROLPARAMS TEXT,"
				       + "  PRIMARY KEY (ID))";
			log.info("BBOSS_GENCODE table 不存在，创建BBOSS_GENCODE表："+tsql+"。",e);
			try {
				SQLExecutor.updateWithDBName("gencode",tsql);
				log.info("创建BBOSS_GENCODE表成功："+tsql+"。");
			} catch (SQLException e1) {
				log.info("创建BBOSS_GENCODE表失败："+tsql+"。",e1);
				e1.printStackTrace();
			}
		}
		
	}
	@Override
	public void beforestart() {
		File dbpath = new File(sqlitepath);
		try {
			
			initConfgDB(dbpath.getCanonicalPath());
			log.info("初始化数据库完毕："+dbpath.getCanonicalPath());
		} catch (IOException e) {
			log.error("初始化数据库失败：！",e);
		}

	}

	@Override
	public void init(Map<String, String> arg0) {
		sqlitepath = arg0.get("sqlitepath");

	}

}

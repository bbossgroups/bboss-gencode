package org.frameworkset.gencode.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import org.frameworkset.spi.BaseApplicationContext;
import org.frameworkset.spi.assemble.PropertiesContainer;
import org.frameworkset.spi.assemble.PropertiesUtil;
import org.frameworkset.spi.event.IocLifeCycleEventListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.frameworkset.common.poolman.SQLExecutor;
import com.frameworkset.common.poolman.util.SQLUtil;
import com.frameworkset.util.SimpleStringUtil;

public class GencodeIocLifeCycleEventListener implements IocLifeCycleEventListener {
	private static Logger log = LoggerFactory.getLogger(GencodeIocLifeCycleEventListener.class);
	private String sqlitepath;
	private String sourcepath;
	public GencodeIocLifeCycleEventListener() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void afterstart(BaseApplicationContext arg0) {
		// TODO Auto-generated method stub

	}
    
    private void initPath(){
        PropertiesContainer propertiesContainer = PropertiesUtil.getPropertiesContainer();
        String sqlitepathConfig = propertiesContainer.getProperty("sqlitepath" );
        String sourcepathConfig = propertiesContainer.getProperty("sourcepath" );
        if(SimpleStringUtil.isEmpty(org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH))
        {
            if(SimpleStringUtil.isEmpty(sqlitepathConfig)) {
                sqlitepath = webxmlSqlitepath;
            }
            else{
                sqlitepath = sqlitepathConfig;
            }
            log.info("sqlitepath:"+sqlitepath);
            org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH = sqlitepath;
        }
        else
            sqlitepath = org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH;

        if(SimpleStringUtil.isEmpty(org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH ))
        {
           if(SimpleStringUtil.isEmpty(sourcepathConfig)) {
               sourcepath = webxmlSourcepath;
           }
           else{
               sourcepath = sourcepathConfig;
           }
            log.info("default sourcepath:"+sourcepath);
            org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH = sourcepath;

        }
        else
            sourcepath = org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH ;        
        
    }
	public static void initConfgDB(String dbpath)
	{
		SQLUtil.startPool("gencode","org.sqlite.JDBC","jdbc:sqlite://"+dbpath,"root","root",
				 null,//"false",
				
				 null,// "READ_UNCOMMITTED",
				 "select 1",
				 "jndi-gencode_conf" ,   
	        		10,
	        		10,
	        		20,
	        		true,
	        		false,
	        		null        ,false,false
	        		);
		String exist = "select 1 from BBOSS_GENCODE";
		
		try {
			//SQLExecutor.updateWithDBName("gencode","drop table BBOSS_GENCODE");
			SQLExecutor.queryObjectWithDBName(int.class,"gencode", exist);
		} catch (Exception e) {
			String tsql = "create table BBOSS_GENCODE (ID string,TABLENAME string,DBNAME string,FIELDINFOS TEXT,AUTHOR string,"
				       + "COMPANY string,"
				       + "CREATETIME number(10),"
				       + "UPDATETIME number(10),"
				       + "CONTROLPARAMS TEXT,"
				       + "moudleName string,"
				       + "moudleCNName string,"
				       
				       + "  PRIMARY KEY (ID))";
			log.info("BBOSS_GENCODE table 不存在，创建BBOSS_GENCODE表："+tsql+"。");
			try {
				SQLExecutor.updateWithDBName("gencode",tsql);
				log.info("创建BBOSS_GENCODE表成功："+tsql+"。");
			} catch (SQLException e1) {
				log.info("创建BBOSS_GENCODE表失败："+tsql+"。",e1);
				e1.printStackTrace();
			}
		}
		
		exist = "select 1 from BBOSS_DATASOURCE";
		
		try {
			//SQLExecutor.updateWithDBName("gencode","drop table BBOSS_DATASOURCE");
			SQLExecutor.queryObjectWithDBName(int.class,"gencode", exist);
		} catch (Exception e) {
			String tsql = "create table BBOSS_DATASOURCE (ID string,DBNAME string,DBURL string,DBDRIVER string,validationQuery string,DBUSER string,DBPASSWORD string,"
				       + "dbdesc string,"
				       + "CREATETIME number(10),"
				       + "UPDATETIME number(10),  PRIMARY KEY (ID))";
			log.info("BBOSS_DATASOURCE table 不存在，创建BBOSS_DATASOURCE表："+tsql+"。");
			try {
				SQLExecutor.updateWithDBName("gencode",tsql);
				log.info("创建BBOSS_DATASOURCE表成功："+tsql+"。");
			} catch (SQLException e1) {
				log.info("创建BBOSS_DATASOURCE表失败："+tsql+"。",e1);
				e1.printStackTrace();
			}
		}
		
	}
	@Override
	public void beforestart() {
		
		try {
            initPath();
            File dbpath = new File(sqlitepath);
			initConfgDB(dbpath.getCanonicalPath());
			log.info("初始化数据库完毕："+dbpath.getCanonicalPath());
		} catch (IOException e) {
			log.error("初始化数据库失败："+sqlitepath,e);
		}

	}

    private String webxmlSqlitepath;
    private String webxmlSourcepath;
	@Override
	public void init(Map<String, String> config) {
        webxmlSqlitepath = config.get("sqlitepath");
        webxmlSourcepath = config.get("sourcepath");
	}

	public String getSourcepath() {
		return sourcepath;
	}

	public void setSourcepath(String sourcepath) {
		this.sourcepath = sourcepath;
	}

}

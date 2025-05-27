package org.frameworkset.gencode.web.service;

import com.frameworkset.util.StringUtil;
import org.frameworkset.boot.ApplicationStart;
import org.frameworkset.spi.assemble.PropertiesContainer;
import org.frameworkset.spi.assemble.PropertiesUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

public class GencodeStart {
	private static Logger log = LoggerFactory.getLogger(GencodeStart.class);
	private static File appdir ;
	public GencodeStart() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		
        try {
            // 服务器的监听端口
            PropertiesContainer propertiesContainer = PropertiesUtil.getPropertiesContainer();
            
             
            String sqlitepath = propertiesContainer.getProperty("sqlitepath" );
            String sourcepath = propertiesContainer.getProperty("sourcepath" );
            if(StringUtil.isEmpty(sourcepath))
            {
                if(appdir != null)
                    org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH = StringUtil.getRealPath(appdir.getCanonicalPath(), "sourcecode");
            }
            else
            {
                org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH = sourcepath;
            }
            
            if(StringUtil.isEmpty(sqlitepath) )
            {
                if(appdir != null)
                    org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH = StringUtil.getRealPath(appdir.getCanonicalPath(), "gencodedb");
            }
            else
            {
                org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH = sqlitepath;
            }
        
             
            log.info("sqlitepath:"+org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH);
            log.info("sourcepath:"+org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH);
            ApplicationStart.setAppdir(appdir);
            ApplicationStart.main(args);
        } catch (FileNotFoundException e) {
            log.error("JettyStart failed:",e);
        }   catch (IOException e) {
            log.error("JettyStart failed:",e);
        } catch (Exception e) {
            log.error("JettyStart failed:",e);
        }
		

	}
	
	public static void setAppdir(File appdir) {
		GencodeStart.appdir = appdir;
	}

}

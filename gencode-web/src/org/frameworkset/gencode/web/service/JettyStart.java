package org.frameworkset.gencode.web.service;

import com.frameworkset.util.SimpleStringUtil;
import com.frameworkset.util.StringUtil;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.webapp.Configuration;
import org.eclipse.jetty.webapp.WebAppContext;
import org.frameworkset.spi.assemble.PropertiesContainer;
import org.frameworkset.spi.assemble.PropertiesUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

public class JettyStart {
	private static Logger log = LoggerFactory.getLogger(JettyStart.class);
	private static File appdir ;
	public JettyStart() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		
		{
			try {
				// 服务器的监听端口
                PropertiesContainer propertiesContainer = PropertiesUtil.getPropertiesContainer();
                
				String port = propertiesContainer.getProperty("port", "8088");
				if (port.equals(""))
					port = "8088";

                String webappbase = propertiesContainer.getProperty("webappbase",
                        "./");
				String contextPath = propertiesContainer.getProperty("context",
						"gencode");
				if (contextPath.equals(""))
					contextPath = "gencode";
                log.info("contextPath:"+contextPath);
                log.info("port:"+port);
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
			
				log.info("webappbase:"+webappbase);
                log.info("sqlitepath:"+org.frameworkset.gencode.core.GencodeServiceImpl.SQLITEPATH);
				log.info("sourcepath:"+org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH);
				int p = Integer.parseInt(port);
				Server server = new Server(p);
				// 关联一个已经存在的上下文
				WebAppContext context = new WebAppContext();
				// 设置描述符位置
                String webXml = SimpleStringUtil.getPath(webappbase,"WebRoot/WEB-INF/web.xml");
                log.info("webXml:"+webXml);
				context.setDescriptor(SimpleStringUtil.getPath(webappbase,"WebRoot/WEB-INF/web.xml"));
				// 设置Web内容上下文路径
                String webRoot = SimpleStringUtil.getPath(webappbase,"/WebRoot");
                log.info("webRoot:"+webRoot);
				context.setResourceBase(webRoot);
                String tempDirectory = SimpleStringUtil.getPath(webappbase,"/temp");
                log.info("tempDirectory:"+tempDirectory);
                context.setTempDirectory(new File(tempDirectory));
				// 设置上下文路径
				context.setContextPath(SimpleStringUtil.getPath("/", contextPath));
				context.setParentLoaderPriority(true);
				ContextHandlerCollection contexts = new ContextHandlerCollection();
				contexts.setHandlers(new Handler[] { context });

                // This webapp will use jsps and jstl. We need to enable the
                // AnnotationConfiguration in order to correctly
                // set up the jsp container
                Configuration.ClassList classlist = Configuration.ClassList
                        .setServerDefault( server );
                classlist.addBefore(
                        "org.eclipse.jetty.webapp.JettyWebXmlConfiguration"
                        ,"org.eclipse.jetty.annotations.AnnotationConfiguration"
                );

                // Set the ContainerIncludeJarPattern so that jetty examines these
                // container-path jars for tlds, web-fragments etc.
                // If you omit the jar that contains the jstl .tlds, the jsp engine will
                // scan for them instead.
                context.setAttribute(
                        "org.eclipse.jetty.server.webapp.ContainerIncludeJarPattern",
                        ".*/[^/]*servlet-api-[^/]*\\.jar$|.*/javax.servlet.jsp.jstl-.*\\.jar$|.*/[^/]*taglibs.*\\.jar$" );

                server.setHandler(contexts);
	
				// server.setHandler(context);
				// 启动
				server.start();
				System.out.println("http://localhost:"+port+"/"+contextPath);
				server.join();
			} catch (FileNotFoundException e) {
				log.error("JettyStart failed:",e);
			} catch (SAXException e) {
                log.error("JettyStart failed:",e);
			} catch (IOException e) {
                log.error("JettyStart failed:",e);
			} catch (Exception e) {
                log.error("JettyStart failed:",e);
			}
		}
		

	}
	
	public static void setAppdir(File appdir) {
		JettyStart.appdir = appdir;
	}

}

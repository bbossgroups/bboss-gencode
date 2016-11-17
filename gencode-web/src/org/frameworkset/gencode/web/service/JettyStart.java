package org.frameworkset.gencode.web.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.webapp.WebAppContext;
import org.frameworkset.runtime.CommonLauncher;
import org.xml.sax.SAXException;

import com.frameworkset.util.StringUtil;

public class JettyStart {
	private static Logger log = Logger.getLogger(JettyStart.class);
	private static File appdir ;
	public JettyStart() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		
		{
			try {
				// 服务器的监听端口
				String port = CommonLauncher.getProperty("port", "8088");
				if (port.equals(""))
					port = "8088";
				String contextPath = CommonLauncher.getProperty("context",
						"gencode");
				if (contextPath.equals(""))
					contextPath = "gencode";
				String sqlitepath = CommonLauncher.getProperty("sqlitepath" );
				String sourcepath = CommonLauncher.getProperty("sourcepath" );
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
				log.info("default sourcepath:"+org.frameworkset.gencode.core.GencodeServiceImpl.DEFAULT_SOURCEPATH);
				int p = Integer.parseInt(port);
				Server server = new Server(p);
				// 关联一个已经存在的上下文
				WebAppContext context = new WebAppContext();
				// 设置描述符位置
				context.setDescriptor("./WebRoot/WEB-INF/web.xml");
				// 设置Web内容上下文路径
				context.setResourceBase("./WebRoot");
				// 设置上下文路径
				context.setContextPath("/" + contextPath);
				context.setParentLoaderPriority(true);
				ContextHandlerCollection contexts = new ContextHandlerCollection();
				contexts.setHandlers(new Handler[] { context });
	
				server.setHandler(contexts);
	
				// server.setHandler(context);
				// 启动
				server.start();
				System.out.println("http://localhost:"+port+"/"+contextPath);
				server.join();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (SAXException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		

	}
	
	public static void setAppdir(File appdir) {
		JettyStart.appdir = appdir;
	}

}

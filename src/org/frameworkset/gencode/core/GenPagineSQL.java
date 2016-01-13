package org.frameworkset.gencode.core;

import bboss.org.apache.velocity.Template;
import bboss.org.apache.velocity.VelocityContext;

import com.frameworkset.util.VelocityUtil;

public class GenPagineSQL  extends AbstractGencode {
	private SQL sql;
	public GenPagineSQL(GencodeServiceImpl gencodeService,SQL sql) {
		super(gencodeService);
		this.sql = sql;
		
	}

	
	public void gen()
	{
		
		try {
			 
			 Template conftempalte = VelocityUtil.getTemplate("/gencode/conf/paginesql.vm");
			 VelocityContext context = new VelocityContext();
			
			 
			 context.put("conditions", gencodeService.getConditions());
			 context.put("sorts", gencodeService.getSortFields());
			 context.put("needsort", gencodeService.needsort());
			 context.put("tableName", gencodeService.getModuleMetaInfo().getTableName());
			 if(gencodeService.isPagineWithDBRownumberOver())
			 {
				 if( sql.getOptype() == Constant.listquery)
				 {
					 context.put("pagineWithDBRownumberOver", false);
					 context.put("pagineOrderBy", false);
				 }
				 else if( sql.getOptype() == Constant.pagineOrderBy)
				 {
					 context.put("pagineWithDBRownumberOver", true);
					 context.put("pagineOrderBy", true);
					 
				 }
				 else if( sql.getOptype() == Constant.paginequery)
				 {
					 context.put("pagineWithDBRownumberOver", true);
					 context.put("pagineOrderBy", false);
				 }
			 }
			 else
			 {
				 context.put("pagineWithDBRownumberOver", false);
			 }
			 sql.setSql(gencodeService.writetostring(  context,conftempalte,gencodeService.getModuleMetaInfo().getEncodecharset()));
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

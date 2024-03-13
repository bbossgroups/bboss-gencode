package org.frameworkset.gencode.core;

import org.frameworkset.gencode.entity.Method;

public interface MethodBodyGenerate {
	/**
	 * 
	 * @param method
	 * @param entityName
	 * @param paramName
	 * @param encodecharset
	 * @param exception
	 * @throws Exception
	 */
	public void gen(Method method, String entityName,String entityVarName,String paramName,String encodecharset,String exception,int componentType,GencodeServiceImpl gencodeService)  throws Exception;

}

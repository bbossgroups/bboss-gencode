/**
 *  Copyright 2008-2010 biaoping.yin
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package org.sqlserver.service;

import org.sqlserver.entity.*;
import com.frameworkset.util.ListInfo;
import com.frameworkset.common.poolman.ConfigSQLExecutor;
import org.apache.log4j.Logger;
import java.util.List;
import com.frameworkset.common.poolman.ConfigPagineOrderby;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * <p>Title: AppBomServiceImpl</p> <p>Description: MS分页测试管理业务处理类 </p>
 * <p>bboss</p> <p>Copyright (c) 2007</p> @Date 2016-01-15 01:39:06 @author
 * yin @version v1.0
 */
public class AppBomServiceImpl implements AppBomService {

	private static Logger log = Logger.getLogger(org.sqlserver.service.AppBomServiceImpl.class);

	private ConfigSQLExecutor executor;
	public void addAppBom(AppBom appBom) throws AppBomException {
		// 业务组件
		try {
			executor.insertBean("mssql", "addAppBom", appBom);
		} catch (Throwable e) {
			throw new AppBomException("add AppBom failed:", e);
		}

	}
	public void deleteAppBom(String id) throws AppBomException {
		try {
			executor.deleteWithDBName("mssql", "deleteByKey", id);
		} catch (Throwable e) {
			throw new AppBomException("delete AppBom failed::id=" + id, e);
		}

	}
	public void deleteBatchAppBom(String... ids) throws AppBomException {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			executor.deleteByKeysWithDBName("mssql", "deleteByKey", ids);
			tm.commit();
		} catch (Throwable e) {

			throw new AppBomException("batch delete AppBom failed::ids=" + ids, e);
		} finally {
			tm.release();
		}

	}
	public void updateAppBom(AppBom appBom) throws AppBomException {
		try {
			executor.updateBean("mssql", "updateAppBom", appBom);
		} catch (Throwable e) {
			throw new AppBomException("update AppBom failed::", e);
		}

	}
	public AppBom getAppBom(String id) throws AppBomException {
		try {
			AppBom bean = executor.queryObjectWithDBName(AppBom.class, "mssql", "selectById", id);
			return bean;
		} catch (Throwable e) {
			throw new AppBomException("get AppBom failed::id=" + id, e);
		}

	}
	public ListInfo queryListInfoAppBoms(AppBomCondition conditions, long offset, int pagesize) throws AppBomException {
		ListInfo datas = null;
		try {
			datas = executor.queryListInfoBeanWithDBName(AppBom.class, "mssql", "queryPagineAppBom", offset, pagesize,
					new ConfigPagineOrderby("AppBomOrderby", conditions));
		} catch (Exception e) {
			throw new AppBomException("pagine query AppBom failed:", e);
		}
		return datas;

	}
	public List<AppBom> queryListAppBoms(AppBomCondition conditions) throws AppBomException {
		try {
			List<AppBom> beans = executor.queryListBeanWithDBName(AppBom.class, "mssql", "queryListAppBom", conditions);
			return beans;
		} catch (Exception e) {
			throw new AppBomException("query AppBom failed:", e);
		}

	}
}
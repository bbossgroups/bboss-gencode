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

package com.yg.core.jsparea.service;

import com.yg.core.jsparea.entity.*;
import com.frameworkset.util.ListInfo;
import com.frameworkset.common.poolman.ConfigSQLExecutor;
import org.apache.log4j.Logger;
import java.util.List;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * <p>
 * Title: AuthoAreaServiceImpl
 * </p>
 * <p>
 * Description: 行政区划管理业务处理类
 * </p>
 * <p>
 * yuanguo
 * </p>
 * <p>
 * Copyright (c) 2007
 * </p>
 * 
 * @Date 2015-03-20 23:55:39
 * @author jinzhen
 * @version v1.0
 */
public class AuthoAreaServiceImpl implements AuthoAreaService {

	private static Logger log = Logger
			.getLogger(com.yg.core.jsparea.service.AuthoAreaServiceImpl.class);

	private ConfigSQLExecutor executor;

	public void addAuthoArea(AuthoArea authoArea) throws AuthoAreaException {
		// 业务组件
		try {
			executor.insertBean("addAuthoArea", authoArea);
		} catch (Throwable e) {
			throw new AuthoAreaException("add AuthoArea failed:", e);
		}

	}

	public void deleteAuthoArea(long areaId) throws AuthoAreaException {
		try {
			executor.delete("deleteByKey", areaId);
		} catch (Throwable e) {
			throw new AuthoAreaException("delete AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public void deleteBatchAuthoArea(long... areaIds) throws AuthoAreaException {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			executor.deleteByLongKeys("deleteByKey", areaIds);
			tm.commit();
		} catch (Throwable e) {

			throw new AuthoAreaException(
					"batch delete AuthoArea failed::areaIds=" + areaIds, e);
		} finally {
			tm.release();
		}

	}

	public void updateAuthoArea(AuthoArea authoArea) throws AuthoAreaException {
		try {
			executor.updateBean("updateAuthoArea", authoArea);
		} catch (Throwable e) {
			throw new AuthoAreaException("update AuthoArea failed::", e);
		}

	}

	public AuthoArea getAuthoArea(long areaId) throws AuthoAreaException {
		try {
			AuthoArea bean = executor.queryObject(AuthoArea.class,
					"selectById", areaId);
			return bean;
		} catch (Throwable e) {
			throw new AuthoAreaException("get AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public ListInfo queryListInfoAuthoAreas(AuthoAreaCondition conditions,
			long offset, int pagesize) throws AuthoAreaException {
		ListInfo datas = null;
		try {
			datas = executor.queryListInfoBean(AuthoArea.class,
					"queryListAuthoArea", offset, pagesize, conditions);
		} catch (Exception e) {
			throw new AuthoAreaException("pagine query AuthoArea failed:", e);
		}
		return datas;

	}

	public List<AuthoArea> queryListAuthoAreas(AuthoAreaCondition conditions)
			throws AuthoAreaException {
		try {
			List<AuthoArea> beans = executor.queryListBean(AuthoArea.class,
					"queryListAuthoArea", conditions);
			return beans;
		} catch (Exception e) {
			throw new AuthoAreaException("query AuthoArea failed:", e);
		}

	}
}
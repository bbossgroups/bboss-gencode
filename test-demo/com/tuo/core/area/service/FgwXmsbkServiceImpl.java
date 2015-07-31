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

package com.tuo.core.area.service;

import com.tuo.core.area.entity.*;
import com.frameworkset.util.ListInfo;
import com.frameworkset.common.poolman.ConfigSQLExecutor;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 * <p>
 * Title: FgwXmsbkServiceImpl
 * </p>
 * <p>
 * Description: 行政区划管理业务处理类
 * </p>
 * <p>
 * tuo
 * </p>
 * <p>
 * Copyright (c) 2007
 * </p>
 * 
 * @Date 2015-03-18 22:40:50
 * @author liy
 * @version v1.0
 */
public class FgwXmsbkServiceImpl implements FgwXmsbkService {

	private static Logger log = Logger
			.getLogger(com.tuo.core.area.service.FgwXmsbkServiceImpl.class);

	private ConfigSQLExecutor executor;

	public void addFgwXmsbk(FgwXmsbk fgwXmsbk) throws FgwXmsbkException {
		try {
			executor.insertBean("addFgwXmsbk", fgwXmsbk);
		} catch (Throwable e) {
			throw new FgwXmsbkException("add FgwXmsbk failed:", e);
		}

	}

	public void deleteFgwXmsbk(String sbxmid) throws FgwXmsbkException {
		try {
			executor.delete("deleteByKey", sbxmid);
		} catch (Throwable e) {
			throw new FgwXmsbkException("delete FgwXmsbk failed::sbxmid="
					+ sbxmid, e);
		}

	}

	public void deleteBatchFgwXmsbk(String... sbxmids) throws FgwXmsbkException {
		TransactionManager tm = new TransactionManager();
		try {
			tm.begin();
			executor.deleteByKeys("deleteByKey", sbxmids);
			tm.commit();
		} catch (Throwable e) {

			throw new FgwXmsbkException(
					"batch delete FgwXmsbk failed::sbxmids=" + sbxmids, e);
		} finally {
			tm.release();
		}

	}

	public void updateFgwXmsbk(FgwXmsbk fgwXmsbk) throws FgwXmsbkException {
		try {
			executor.updateBean("updateFgwXmsbk", fgwXmsbk);
		} catch (Throwable e) {
			throw new FgwXmsbkException("update FgwXmsbk failed::", e);
		}

	}

	public FgwXmsbk getFgwXmsbk(String sbxmid) throws FgwXmsbkException {
		try {
			FgwXmsbk bean = executor.queryObject(FgwXmsbk.class, "selectById",
					sbxmid);
			return bean;
		} catch (Throwable e) {
			throw new FgwXmsbkException(
					"get FgwXmsbk failed::sbxmid=" + sbxmid, e);
		}

	}

	public ListInfo queryListInfoFgwXmsbks(FgwXmsbkCondition conditions,
			long offset, int pagesize) throws FgwXmsbkException {
		ListInfo datas = null;
		try {
			datas = executor.queryListInfoBean(FgwXmsbk.class,
					"queryListFgwXmsbk", offset, pagesize, conditions);
		} catch (Exception e) {
			throw new FgwXmsbkException("pagine query FgwXmsbk failed:", e);
		}
		return datas;

	}

	public List<FgwXmsbk> queryListFgwXmsbks(FgwXmsbkCondition conditions)
			throws FgwXmsbkException {
		try {
			List<FgwXmsbk> beans = executor.queryListBean(FgwXmsbk.class,
					"queryListFgwXmsbk", conditions);
			return beans;
		} catch (Exception e) {
			throw new FgwXmsbkException("query FgwXmsbk failed:", e);
		}

	}
}
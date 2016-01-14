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

package org.sqlserver.ws;

import org.sqlserver.entity.*;
import org.sqlserver.service.*;
import com.frameworkset.util.RListInfo;
import com.frameworkset.util.ListInfo;
import java.util.List;
import javax.jws.WebService;

/**
 * <p>Title: WSAppBomServiceImpl</p> <p>Description:
 * MS分页测试webservice服务和hessian服务实现类. </p> <p>bboss</p> <p>Copyright (c)
 * 2007</p> @Date 2016-01-15 01:39:06 @author yin @version v1.0
 */
@WebService(name = "WSAppBomService", targetNamespace = "org.sqlserver.ws")
public class WSAppBomServiceImpl implements WSAppBomService {

	private AppBomService appBomService;
	public void addAppBom(AppBom appBom) throws AppBomException {
		// webservice服务
		try {
			appBomService.addAppBom(appBom);
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("add AppBom failed:", e);
		}

	}
	public void deleteAppBom(String id) throws AppBomException {
		// webservice服务
		try {
			appBomService.deleteAppBom(id);
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("delete AppBom failed::id=" + id, e);
		}

	}
	public void deleteBatchAppBom(String... ids) throws AppBomException {
		// webservice服务
		try {
			appBomService.deleteBatchAppBom(ids);
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("batch delete AppBom failed::ids=" + ids, e);
		}

	}
	public void updateAppBom(AppBom appBom) throws AppBomException {
		// webservice服务
		try {
			appBomService.updateAppBom(appBom);

		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("update AppBom failed::", e);
		}

	}
	public AppBom getAppBom(String id) throws AppBomException {
		// webservice服务
		try {
			AppBom appBom = appBomService.getAppBom(id);
			return appBom;
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("get AppBom failed::id=" + id, e);
		}

	}
	public RListInfo queryListInfoAppBoms(AppBomCondition conditions, long offset, int pagesize)
			throws AppBomException {
		// webservice服务
		try {

			String bm = conditions.getBm();
			if (bm != null && !bm.equals("")) {
				conditions.setBm("%" + bm + "%");
			}
			ListInfo appBoms = appBomService.queryListInfoAppBoms(conditions, offset, pagesize);
			return new RListInfo(appBoms);
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("pagine query AppBom failed:", e);
		}

	}
	public List<AppBom> queryListAppBoms(AppBomCondition conditions) throws AppBomException {
		// webservice服务
		try {
			String bm = conditions.getBm();
			if (bm != null && !bm.equals("")) {
				conditions.setBm("%" + bm + "%");
			}
			List<AppBom> appBoms = appBomService.queryListAppBoms(conditions);
			return appBoms;
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("query AppBom failed:", e);
		}

	}
}
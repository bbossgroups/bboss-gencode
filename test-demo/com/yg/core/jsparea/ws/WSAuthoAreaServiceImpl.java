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

package com.yg.core.jsparea.ws;

import com.yg.core.jsparea.entity.*;
import com.yg.core.jsparea.service.*;
import com.frameworkset.util.ListInfo;
import java.util.List;
import javax.jws.WebService;

/**
 * <p>
 * Title: WSAuthoAreaServiceImpl
 * </p>
 * <p>
 * Description: 行政区划webservice服务和hessian服务实现类.
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
@WebService(name = "WSAuthoAreaService", targetNamespace = "com.yg.core.jsparea.ws")
public class WSAuthoAreaServiceImpl implements WSAuthoAreaService {

	private AuthoAreaService authoAreaService;

	public void addAuthoArea(AuthoArea authoArea) throws AuthoAreaException {
		// webservice服务
		try {
			authoAreaService.addAuthoArea(authoArea);
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("add AuthoArea failed:", e);
		}

	}

	public void deleteAuthoArea(long areaId) throws AuthoAreaException {
		// webservice服务
		try {
			authoAreaService.deleteAuthoArea(areaId);
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("delete AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public void deleteBatchAuthoArea(long... areaIds) throws AuthoAreaException {
		// webservice服务
		try {
			authoAreaService.deleteBatchAuthoArea(areaIds);
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException(
					"batch delete AuthoArea failed::areaIds=" + areaIds, e);
		}

	}

	public void updateAuthoArea(AuthoArea authoArea) throws AuthoAreaException {
		// webservice服务
		try {
			authoAreaService.updateAuthoArea(authoArea);

		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("update AuthoArea failed::", e);
		}

	}

	public AuthoArea getAuthoArea(long areaId) throws AuthoAreaException {
		// webservice服务
		try {
			AuthoArea authoArea = authoAreaService.getAuthoArea(areaId);
			return authoArea;
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("get AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public ListInfo queryListInfoAuthoAreas(AuthoAreaCondition conditions,
			long offset, int pagesize) throws AuthoAreaException {
		// webservice服务
		try {
			ListInfo authoAreas = authoAreaService.queryListInfoAuthoAreas(
					conditions, offset, pagesize);
			return authoAreas;
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("pagine query AuthoArea failed:", e);
		}

	}

	public List<AuthoArea> queryListAuthoAreas(AuthoAreaCondition conditions)
			throws AuthoAreaException {
		// webservice服务
		try {
			List<AuthoArea> authoAreas = authoAreaService
					.queryListAuthoAreas(conditions);
			return authoAreas;
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("query AuthoArea failed:", e);
		}

	}
}
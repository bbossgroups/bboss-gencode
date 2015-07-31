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

package com.yg.core.jsparea.action;

import com.yg.core.jsparea.entity.*;
import com.frameworkset.util.ListInfo;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.Map;
import com.frameworkset.util.StringUtil;
import com.yg.core.jsparea.service.*;
import org.frameworkset.util.annotations.ResponseBody;
import org.frameworkset.web.servlet.ModelMap;
import org.frameworkset.util.annotations.PagerParam;
import org.frameworkset.util.annotations.MapKey;

/**
 * <p>
 * Title: AuthoAreaController
 * </p>
 * <p>
 * Description: 行政区划管理控制器处理类
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
public class AuthoAreaController {

	private static Logger log = Logger.getLogger(AuthoAreaController.class);

	private AuthoAreaService authoAreaService;

	public @ResponseBody
	String addAuthoArea(AuthoArea authoArea) {
		// 控制器
		try {
			authoAreaService.addAuthoArea(authoArea);
			return "success";
		} catch (AuthoAreaException e) {
			log.error("add AuthoArea failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("add AuthoArea failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String deleteAuthoArea(long areaId) {
		try {
			authoAreaService.deleteAuthoArea(areaId);
			return "success";
		} catch (AuthoAreaException e) {
			log.error("delete AuthoArea failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("delete AuthoArea failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String deleteBatchAuthoArea(long... areaIds) {
		try {
			authoAreaService.deleteBatchAuthoArea(areaIds);
			return "success";
		} catch (Throwable e) {
			log.error("delete Batch areaIds failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String updateAuthoArea(AuthoArea authoArea) {
		try {
			authoAreaService.updateAuthoArea(authoArea);
			return "success";
		} catch (Throwable e) {
			log.error("update AuthoArea failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public String getAuthoArea(long areaId, ModelMap model)
			throws AuthoAreaException {
		try {
			AuthoArea authoArea = authoAreaService.getAuthoArea(areaId);
			model.addAttribute("authoArea", authoArea);
			return "path:getAuthoArea";
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("get AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public String queryListInfoAuthoAreas(
			AuthoAreaCondition conditions,
			@PagerParam(name = PagerParam.SORT, defaultvalue = "SORT_NUM") String sortKey,
			@PagerParam(name = PagerParam.DESC, defaultvalue = "true") boolean desc,
			@PagerParam(name = PagerParam.OFFSET) long offset,
			@PagerParam(name = PagerParam.PAGE_SIZE, defaultvalue = "10") int pagesize,
			ModelMap model) throws AuthoAreaException {
		try {
			if (sortKey != null && !sortKey.equals("")) {
				conditions.setSortKey(sortKey);
				conditions.setSortDesc(desc);
			}
			String areaName = conditions.getAreaName();
			if (areaName != null && !areaName.equals("")) {
				conditions.setAreaName("%" + areaName + "%");
			}
			String areaCode = conditions.getAreaCode();
			if (areaCode != null && !areaCode.equals("")) {
				conditions.setAreaCode("%" + areaCode + "%");
			}
			ListInfo authoAreas = authoAreaService.queryListInfoAuthoAreas(
					conditions, offset, pagesize);
			model.addAttribute("authoAreas", authoAreas);
			return "path:queryListInfoAuthoAreas";
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Exception e) {
			throw new AuthoAreaException("pagine query AuthoArea failed:", e);
		}

	}

	public String queryListAuthoAreas(AuthoAreaCondition conditions,
			ModelMap model) throws AuthoAreaException {
		try {

			String areaName = conditions.getAreaName();
			if (areaName != null && !areaName.equals("")) {
				conditions.setAreaName("%" + areaName + "%");
			}
			String areaCode = conditions.getAreaCode();
			if (areaCode != null && !areaCode.equals("")) {
				conditions.setAreaCode("%" + areaCode + "%");
			}
			List<AuthoArea> authoAreas = authoAreaService
					.queryListAuthoAreas(conditions);
			model.addAttribute("authoAreas", authoAreas);
			return "path:queryListAuthoAreas";
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Exception e) {
			throw new AuthoAreaException("query AuthoArea failed:", e);
		}

	}

	public String toUpdateAuthoArea(long areaId, ModelMap model)
			throws AuthoAreaException {
		try {
			AuthoArea authoArea = authoAreaService.getAuthoArea(areaId);
			model.addAttribute("authoArea", authoArea);
			return "path:updateAuthoArea";
		} catch (AuthoAreaException e) {
			throw e;
		} catch (Throwable e) {
			throw new AuthoAreaException("get AuthoArea failed::areaId="
					+ areaId, e);
		}

	}

	public String toAddAuthoArea() {
		return "path:addAuthoArea";
	}

	public String index() {
		return "path:index";

	}
}
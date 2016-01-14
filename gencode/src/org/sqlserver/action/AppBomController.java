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

package org.sqlserver.action;

import org.sqlserver.entity.*;
import com.frameworkset.util.ListInfo;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.Map;
import com.frameworkset.util.StringUtil;
import org.sqlserver.service.*;
import org.frameworkset.util.annotations.ResponseBody;
import org.frameworkset.web.servlet.ModelMap;
import org.frameworkset.util.annotations.PagerParam;
import org.frameworkset.util.annotations.MapKey;

/**
 * <p>Title: AppBomController</p> <p>Description: MS分页测试管理控制器处理类 </p>
 * <p>bboss</p> <p>Copyright (c) 2007</p> @Date 2016-01-15 01:39:06 @author
 * yin @version v1.0
 */
public class AppBomController {

	private static Logger log = Logger.getLogger(AppBomController.class);

	private AppBomService appBomService;
	public @ResponseBody String addAppBom(AppBom appBom) {
		// 控制器
		try {
			appBomService.addAppBom(appBom);
			return "success";
		} catch (AppBomException e) {
			log.error("add AppBom failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("add AppBom failed:", e);
			return StringUtil.formatBRException(e);
		}

	}
	public @ResponseBody String deleteAppBom(String id) {
		try {
			appBomService.deleteAppBom(id);
			return "success";
		} catch (AppBomException e) {
			log.error("delete AppBom failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("delete AppBom failed:", e);
			return StringUtil.formatBRException(e);
		}

	}
	public @ResponseBody String deleteBatchAppBom(String... ids) {
		try {
			appBomService.deleteBatchAppBom(ids);
			return "success";
		} catch (Throwable e) {
			log.error("delete Batch ids failed:", e);
			return StringUtil.formatBRException(e);
		}

	}
	public @ResponseBody String updateAppBom(AppBom appBom) {
		try {
			appBomService.updateAppBom(appBom);
			return "success";
		} catch (Throwable e) {
			log.error("update AppBom failed:", e);
			return StringUtil.formatBRException(e);
		}

	}
	public String getAppBom(String id, ModelMap model) throws AppBomException {
		try {
			AppBom appBom = appBomService.getAppBom(id);
			model.addAttribute("appBom", appBom);
			return "path:getAppBom";
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("get AppBom failed::id=" + id, e);
		}

	}
	public String queryListInfoAppBoms(AppBomCondition conditions,
			@PagerParam(name = PagerParam.SORT, defaultvalue = "BM") String sortKey,
			@PagerParam(name = PagerParam.DESC, defaultvalue = "false") boolean desc,
			@PagerParam(name = PagerParam.OFFSET) long offset,
			@PagerParam(name = PagerParam.PAGE_SIZE, defaultvalue = "10") int pagesize, ModelMap model)
					throws AppBomException {
		// Constant.component_type_actionimpl
		try {
			if (sortKey != null && !sortKey.equals("")) {
				conditions.setSortKey(sortKey);
				conditions.setSortDesc(desc);
			}
			String bm = conditions.getBm();
			if (bm != null && !bm.equals("")) {
				conditions.setBm("%" + bm + "%");
			}

			ListInfo appBoms = appBomService.queryListInfoAppBoms(conditions, offset, pagesize);
			model.addAttribute("appBoms", appBoms);
			return "path:queryListInfoAppBoms";
		} catch (AppBomException e) {
			throw e;
		} catch (Exception e) {
			throw new AppBomException("pagine query AppBom failed:", e);
		}

	}
	public String queryListAppBoms(AppBomCondition conditions, ModelMap model) throws AppBomException {
		try {
			String bm = conditions.getBm();
			if (bm != null && !bm.equals("")) {
				conditions.setBm("%" + bm + "%");
			}
			List<AppBom> appBoms = appBomService.queryListAppBoms(conditions);
			model.addAttribute("appBoms", appBoms);
			return "path:queryListAppBoms";
		} catch (AppBomException e) {
			throw e;
		} catch (Exception e) {
			throw new AppBomException("query AppBom failed:", e);
		}

	}
	public String toUpdateAppBom(String id, ModelMap model) throws AppBomException {
		try {
			AppBom appBom = appBomService.getAppBom(id);
			model.addAttribute("appBom", appBom);
			return "path:updateAppBom";
		} catch (AppBomException e) {
			throw e;
		} catch (Throwable e) {
			throw new AppBomException("get AppBom failed::id=" + id, e);
		}

	}
	public String toAddAppBom() {
		return "path:addAppBom";
	}
	public String index() {
		return "path:index";

	}
}
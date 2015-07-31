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

package com.tuo.core.area.action;

import com.tuo.core.area.entity.*;
import com.frameworkset.util.ListInfo;
import org.apache.log4j.Logger;
import java.util.List;
import java.util.Map;
import com.frameworkset.util.StringUtil;
import com.tuo.core.area.service.*;
import org.frameworkset.util.annotations.ResponseBody;
import org.frameworkset.web.servlet.ModelMap;
import org.frameworkset.util.annotations.PagerParam;
import org.frameworkset.util.annotations.MapKey;

/**
 * <p>
 * Title: FgwXmsbkController
 * </p>
 * <p>
 * Description: 行政区划管理控制器处理类
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
public class FgwXmsbkController {

	private static Logger log = Logger.getLogger(FgwXmsbkController.class);

	private FgwXmsbkService fgwXmsbkService;

	public @ResponseBody
	String addFgwXmsbk(FgwXmsbk fgwXmsbk) {
		try {
			fgwXmsbkService.addFgwXmsbk(fgwXmsbk);
			return "success";
		} catch (FgwXmsbkException e) {
			log.error("add FgwXmsbk failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("add FgwXmsbk failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String deleteFgwXmsbk(String sbxmid) {
		try {
			fgwXmsbkService.deleteFgwXmsbk(sbxmid);
			return "success";
		} catch (FgwXmsbkException e) {
			log.error("delete FgwXmsbk failed:", e);
			return StringUtil.formatBRException(e);
		} catch (Throwable e) {
			log.error("delete FgwXmsbk failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String deleteBatchFgwXmsbk(String... sbxmids) {
		try {
			fgwXmsbkService.deleteBatchFgwXmsbk(sbxmids);
			return "success";
		} catch (Throwable e) {
			log.error("delete Batch sbxmids failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public @ResponseBody
	String updateFgwXmsbk(FgwXmsbk fgwXmsbk) {
		try {
			fgwXmsbkService.updateFgwXmsbk(fgwXmsbk);
			return "success";
		} catch (Throwable e) {
			log.error("update FgwXmsbk failed:", e);
			return StringUtil.formatBRException(e);
		}

	}

	public String getFgwXmsbk(String sbxmid, ModelMap model)
			throws FgwXmsbkException {
		try {
			FgwXmsbk fgwXmsbk = fgwXmsbkService.getFgwXmsbk(sbxmid);
			model.addAttribute("fgwXmsbk", fgwXmsbk);
			return "path:getFgwXmsbk";
		} catch (FgwXmsbkException e) {
			throw e;
		} catch (Throwable e) {
			throw new FgwXmsbkException(
					"get FgwXmsbk failed::sbxmid=" + sbxmid, e);
		}

	}

	public String queryListInfoFgwXmsbks(
			FgwXmsbkCondition conditions,
			@PagerParam(name = PagerParam.SORT, defaultvalue = "jjid") String sortKey,
			@PagerParam(name = PagerParam.DESC, defaultvalue = "true") boolean desc,
			@PagerParam(name = PagerParam.OFFSET) long offset,
			@PagerParam(name = PagerParam.PAGE_SIZE, defaultvalue = "10") int pagesize,
			ModelMap model) throws FgwXmsbkException {
		try {
			if (sortKey != null && !sortKey.equals("")) {
				conditions.setSortKey(sortKey);
				conditions.setSortDesc(desc);
			}
			String xmgkdw = conditions.getXmgkdw();
			if (xmgkdw != null && !xmgkdw.equals("")) {
				conditions.setXmgkdw("%" + xmgkdw + "%");
			}
			String jsdz = conditions.getJsdz();
			if (jsdz != null && !jsdz.equals("")) {
				conditions.setJsdz("%" + jsdz + "%");
			}
			ListInfo fgwXmsbks = fgwXmsbkService.queryListInfoFgwXmsbks(
					conditions, offset, pagesize);
			model.addAttribute("fgwXmsbks", fgwXmsbks);
			return "path:queryListInfoFgwXmsbks";
		} catch (FgwXmsbkException e) {
			throw e;
		} catch (Exception e) {
			throw new FgwXmsbkException("pagine query FgwXmsbk failed:", e);
		}

	}

	public String queryListFgwXmsbks(FgwXmsbkCondition conditions,
			ModelMap model) throws FgwXmsbkException {
		try {

			String xmgkdw = conditions.getXmgkdw();
			if (xmgkdw != null && !xmgkdw.equals("")) {
				conditions.setXmgkdw("%" + xmgkdw + "%");
			}
			String jsdz = conditions.getJsdz();
			if (jsdz != null && !jsdz.equals("")) {
				conditions.setJsdz("%" + jsdz + "%");
			}
			List<FgwXmsbk> fgwXmsbks = fgwXmsbkService
					.queryListFgwXmsbks(conditions);
			model.addAttribute("fgwXmsbks", fgwXmsbks);
			return "path:queryListFgwXmsbks";
		} catch (FgwXmsbkException e) {
			throw e;
		} catch (Exception e) {
			throw new FgwXmsbkException("query FgwXmsbk failed:", e);
		}

	}

	public String toUpdateFgwXmsbk(String sbxmid, ModelMap model)
			throws FgwXmsbkException {
		try {
			FgwXmsbk fgwXmsbk = fgwXmsbkService.getFgwXmsbk(sbxmid);
			model.addAttribute("fgwXmsbk", fgwXmsbk);
			return "path:updateFgwXmsbk";
		} catch (FgwXmsbkException e) {
			throw e;
		} catch (Throwable e) {
			throw new FgwXmsbkException(
					"get FgwXmsbk failed::sbxmid=" + sbxmid, e);
		}

	}

	public String toAddFgwXmsbk() {
		return "path:addFgwXmsbk";
	}

	public String index() {
		return "path:index";

	}
}
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
import java.util.List;
import java.util.Map;

/**
 * <p>
 * Title: FgwXmsbkService
 * </p>
 * <p>
 * Description: 行政区划管理服务接口
 * </p>
 * <p>
 * tuo
 * </p>
 * <p>
 * Copyright (c) 2015
 * </p>
 * 
 * @Date 2015-03-18 22:40:50
 * @author liy
 * @version v1.0
 */
public interface FgwXmsbkService {
	public void addFgwXmsbk(FgwXmsbk fgwXmsbk) throws FgwXmsbkException;

	public void deleteFgwXmsbk(String sbxmid) throws FgwXmsbkException;

	public void deleteBatchFgwXmsbk(String... sbxmids) throws FgwXmsbkException;

	public void updateFgwXmsbk(FgwXmsbk fgwXmsbk) throws FgwXmsbkException;

	public FgwXmsbk getFgwXmsbk(String sbxmid) throws FgwXmsbkException;

	public ListInfo queryListInfoFgwXmsbks(FgwXmsbkCondition conditions,
			long offset, int pagesize) throws FgwXmsbkException;

	public List<FgwXmsbk> queryListFgwXmsbks(FgwXmsbkCondition conditions)
			throws FgwXmsbkException;
}
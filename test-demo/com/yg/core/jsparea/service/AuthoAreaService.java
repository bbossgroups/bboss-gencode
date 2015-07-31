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
import java.util.List;

/**
 * <p>
 * Title: AuthoAreaService
 * </p>
 * <p>
 * Description: 行政区划管理服务接口
 * </p>
 * <p>
 * yuanguo
 * </p>
 * <p>
 * Copyright (c) 2015
 * </p>
 * 
 * @Date 2015-03-20 23:55:39
 * @author jinzhen
 * @version v1.0
 */
public interface AuthoAreaService {
	public void addAuthoArea(AuthoArea authoArea) throws AuthoAreaException;

	public void deleteAuthoArea(long areaId) throws AuthoAreaException;

	public void deleteBatchAuthoArea(long... areaIds) throws AuthoAreaException;

	public void updateAuthoArea(AuthoArea authoArea) throws AuthoAreaException;

	public AuthoArea getAuthoArea(long areaId) throws AuthoAreaException;

	public ListInfo queryListInfoAuthoAreas(AuthoAreaCondition conditions,
			long offset, int pagesize) throws AuthoAreaException;

	public List<AuthoArea> queryListAuthoAreas(AuthoAreaCondition conditions)
			throws AuthoAreaException;
}
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
import java.util.List;

/**
 * <p>Title: AppBomService</p> <p>Description: MS分页测试管理服务接口 </p> <p>bboss</p>
 * <p>Copyright (c) 2015</p> @Date 2016-01-15 01:39:06 @author yin @version v1.0
 */
public interface AppBomService {
	public void addAppBom(AppBom appBom) throws AppBomException;
	public void deleteAppBom(String id) throws AppBomException;
	public void deleteBatchAppBom(String... ids) throws AppBomException;
	public void updateAppBom(AppBom appBom) throws AppBomException;
	public AppBom getAppBom(String id) throws AppBomException;
	public ListInfo queryListInfoAppBoms(AppBomCondition conditions, long offset, int pagesize) throws AppBomException;
	public List<AppBom> queryListAppBoms(AppBomCondition conditions) throws AppBomException;
}
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
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

/**
 * <p>
 * Title: WSAuthoAreaService
 * </p>
 * <p>
 * Description: 行政区划webservice服务和hessian服务接口.
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
@WebService(name = "WSAuthoAreaService", targetNamespace = "com.yg.core.jsparea.ws")
public interface WSAuthoAreaService {
	public void addAuthoArea(
			@WebParam(name = "authoArea", partName = "partAuthoArea") AuthoArea authoArea)
			throws AuthoAreaException;

	public void deleteAuthoArea(
			@WebParam(name = "areaId", partName = "partAreaId") long areaId)
			throws AuthoAreaException;

	public void deleteBatchAuthoArea(
			@WebParam(name = "areaIds", partName = "partAreaIds") long... areaIds)
			throws AuthoAreaException;

	public void updateAuthoArea(
			@WebParam(name = "authoArea", partName = "partAuthoArea") AuthoArea authoArea)
			throws AuthoAreaException;

	public @WebResult(name = "authoArea", partName = "partAuthoArea")
	AuthoArea getAuthoArea(
			@WebParam(name = "areaId", partName = "partAreaId") long areaId)
			throws AuthoAreaException;

	public @WebResult(name = "authoAreas", partName = "partAuthoAreas")
	ListInfo queryListInfoAuthoAreas(
			@WebParam(name = "conditions", partName = "partConditions") AuthoAreaCondition conditions,
			@WebParam(name = "offset", partName = "partOffset") long offset,
			@WebParam(name = "pagesize", partName = "partPagesize") int pagesize)
			throws AuthoAreaException;

	public @WebResult(name = "authoAreas", partName = "partAuthoAreas")
	List<AuthoArea> queryListAuthoAreas(
			@WebParam(name = "conditions", partName = "partConditions") AuthoAreaCondition conditions)
			throws AuthoAreaException;
}
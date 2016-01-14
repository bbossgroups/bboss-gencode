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
import java.util.List;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

/**
 * <p>Title: WSAppBomService</p> <p>Description: MS分页测试webservice服务和hessian服务接口.
 * </p> <p>bboss</p> <p>Copyright (c) 2015</p> @Date 2016-01-15 01:39:06 @author
 * yin @version v1.0
 */
@WebService(name = "WSAppBomService", targetNamespace = "org.sqlserver.ws")
public interface WSAppBomService {
	public void addAppBom(@WebParam(name = "appBom", partName = "partAppBom") AppBom appBom) throws AppBomException;
	public void deleteAppBom(@WebParam(name = "id", partName = "partId") String id) throws AppBomException;
	public void deleteBatchAppBom(@WebParam(name = "ids", partName = "partIds") String... ids) throws AppBomException;
	public void updateAppBom(@WebParam(name = "appBom", partName = "partAppBom") AppBom appBom) throws AppBomException;
	public @WebResult(name = "appBom", partName = "partAppBom") AppBom getAppBom(
			@WebParam(name = "id", partName = "partId") String id) throws AppBomException;
	public @WebResult(name = "appBoms", partName = "partAppBoms") RListInfo queryListInfoAppBoms(
			@WebParam(name = "conditions", partName = "partConditions") AppBomCondition conditions,
			@WebParam(name = "offset", partName = "partOffset") long offset,
			@WebParam(name = "pagesize", partName = "partPagesize") int pagesize) throws AppBomException;
	public @WebResult(name = "appBoms", partName = "partAppBoms") List<AppBom> queryListAppBoms(
			@WebParam(name = "conditions", partName = "partConditions") AppBomCondition conditions)
					throws AppBomException;
}
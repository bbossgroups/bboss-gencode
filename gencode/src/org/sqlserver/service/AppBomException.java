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

/**
 * <p>Title: AppBomException</p> <p>Description: MS分页测试管理异常处理类 </p> <p>bboss</p>
 * <p>Copyright (c) 2007</p> @Date 2016-01-15 01:39:06 @author yin @version v1.0
 */
public class AppBomException extends RuntimeException {

	public AppBomException() {
		super();
	}
	public AppBomException(String message, Throwable cause) {
		super(message, cause);
	}

	public AppBomException(String message) {
		super(message);
	}

	public AppBomException(Throwable cause) {
		super(cause);
	}

}
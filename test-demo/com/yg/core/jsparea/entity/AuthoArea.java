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

package com.yg.core.jsparea.entity;

import com.frameworkset.orm.annotation.PrimaryKey;

/**
 * <p>
 * Title: AuthoArea
 * </p>
 * <p>
 * Description: 行政区划管理服务实体类
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
public class AuthoArea implements java.io.Serializable {
	@PrimaryKey(pkname = "ta_autho_area")
	private long areaId;
	private String areaCode;
	private String areaName;
	private String parentAreaCode;
	private long sortNum;

	public AuthoArea() {
	}

	public void setAreaId(long areaId) {
		this.areaId = areaId;
	}

	public long getAreaId() {
		return areaId;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setParentAreaCode(String parentAreaCode) {
		this.parentAreaCode = parentAreaCode;
	}

	public String getParentAreaCode() {
		return parentAreaCode;
	}

	public void setSortNum(long sortNum) {
		this.sortNum = sortNum;
	}

	public long getSortNum() {
		return sortNum;
	}
}
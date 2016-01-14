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

package org.sqlserver.entity;

/**
 * <p>Title: AppBomCondition</p> <p>Description: MS分页测试管理查询条件实体类 </p>
 * <p>bboss</p> <p>Copyright (c) 2007</p> @Date 2016-01-15 01:39:06 @author
 * yin @version v1.0
 */
public class AppBomCondition implements java.io.Serializable {
	private String bm;
	private String sortKey;
	private boolean sortDesc;
	public AppBomCondition() {
	}
	public void setBm(String bm) {
		this.bm = bm;
	}

	public String getBm() {
		return bm;
	}

	public void setSortKey(String sortKey) {
		this.sortKey = sortKey;
	}

	public String getSortKey() {
		return sortKey;
	}

	public void setSortDesc(boolean sortDesc) {
		this.sortDesc = sortDesc;
	}

	public boolean getSortDesc() {
		return sortDesc;
	}

}
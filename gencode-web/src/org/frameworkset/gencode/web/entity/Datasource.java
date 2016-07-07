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

package org.frameworkset.gencode.web.entity;

import com.frameworkset.orm.annotation.PrimaryKey;

/**
 * <p>
 * Title: Datasource
 * </p>
 * <p>
 * Description: 数据源管理管理服务实体类
 * </p>
 * <p>
 * bboss
 * </p>
 * <p>
 * Copyright (c) 2007
 * </p>
 * 
 * @Date 2015-10-09 11:45:23
 * @author yinbp
 * @version v1.0
 */
public class Datasource implements java.io.Serializable {
	@PrimaryKey
	private String id;
	private String dbdesc;
	private String dbname;
	private String dbpassword;
	private String dburl;
	private String dbuser;
	private String dbdriver;
	private String validationQuery;
	private long createDate;
	private long updateDate;

	public Datasource() {
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setDbdesc(String dbdesc) {
		this.dbdesc = dbdesc;
	}

	public String getDbdesc() {
		return dbdesc;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
	}

	public String getDbname() {
		return dbname;
	}

	public void setDbpassword(String dbpassword) {
		this.dbpassword = dbpassword;
	}

	public String getDbpassword() {
		return dbpassword;
	}

	public void setDburl(String dburl) {
		this.dburl = dburl;
	}

	public String getDburl() {
		return dburl;
	}

	public void setDbuser(String dbuser) {
		this.dbuser = dbuser;
	}

	public String getDbuser() {
		return dbuser;
	}

	public String getDbdriver() {
		return dbdriver;
	}

	public void setDbdriver(String dbdriver) {
		this.dbdriver = dbdriver;
	}

	public String getValidationQuery() {
		return validationQuery;
	}

	public void setValidationQuery(String validationQuery) {
		this.validationQuery = validationQuery;
	}

	public long getCreateDate() {
		return createDate;
	}

	public void setCreateDate(long createDate) {
		this.createDate = createDate;
	}

	public long getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(long updateDate) {
		this.updateDate = updateDate;
	}
}
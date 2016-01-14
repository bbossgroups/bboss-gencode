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

import com.frameworkset.orm.annotation.PrimaryKey;
/**
 * <p>Title: AppBom</p> <p>Description: MS分页测试管理服务实体类 </p> <p>bboss</p>
 * <p>Copyright (c) 2007</p> @Date 2016-01-15 01:39:06 @author yin @version v1.0
 */
public class AppBom implements java.io.Serializable {
	@PrimaryKey
	private String id;
	private String appName;
	private String appNameEn;
	private String applyDomain;
	private String bm;
	private String dbType;
	private String departmentDevelop;
	private String departmentMaintain;
	private String description;
	private String developTool;
	private String domainUrl;
	private String evolveDepart;
	private String evolvePlan;
	private String evolveStrategy;
	private String mainDescription;
	private long manageScope;
	private long planType;
	private String productManager;
	private long rdType;
	private String softLanguage;
	private long softLevel;
	private String startYear;
	private long state;
	private String structMode;
	private String supplier;
	private String sysManager;
	private String versionNo;
	public AppBom() {
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppNameEn(String appNameEn) {
		this.appNameEn = appNameEn;
	}

	public String getAppNameEn() {
		return appNameEn;
	}

	public void setApplyDomain(String applyDomain) {
		this.applyDomain = applyDomain;
	}

	public String getApplyDomain() {
		return applyDomain;
	}

	public void setBm(String bm) {
		this.bm = bm;
	}

	public String getBm() {
		return bm;
	}

	public void setDbType(String dbType) {
		this.dbType = dbType;
	}

	public String getDbType() {
		return dbType;
	}

	public void setDepartmentDevelop(String departmentDevelop) {
		this.departmentDevelop = departmentDevelop;
	}

	public String getDepartmentDevelop() {
		return departmentDevelop;
	}

	public void setDepartmentMaintain(String departmentMaintain) {
		this.departmentMaintain = departmentMaintain;
	}

	public String getDepartmentMaintain() {
		return departmentMaintain;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setDevelopTool(String developTool) {
		this.developTool = developTool;
	}

	public String getDevelopTool() {
		return developTool;
	}

	public void setDomainUrl(String domainUrl) {
		this.domainUrl = domainUrl;
	}

	public String getDomainUrl() {
		return domainUrl;
	}

	public void setEvolveDepart(String evolveDepart) {
		this.evolveDepart = evolveDepart;
	}

	public String getEvolveDepart() {
		return evolveDepart;
	}

	public void setEvolvePlan(String evolvePlan) {
		this.evolvePlan = evolvePlan;
	}

	public String getEvolvePlan() {
		return evolvePlan;
	}

	public void setEvolveStrategy(String evolveStrategy) {
		this.evolveStrategy = evolveStrategy;
	}

	public String getEvolveStrategy() {
		return evolveStrategy;
	}

	public void setMainDescription(String mainDescription) {
		this.mainDescription = mainDescription;
	}

	public String getMainDescription() {
		return mainDescription;
	}

	public void setManageScope(long manageScope) {
		this.manageScope = manageScope;
	}

	public long getManageScope() {
		return manageScope;
	}

	public void setPlanType(long planType) {
		this.planType = planType;
	}

	public long getPlanType() {
		return planType;
	}

	public void setProductManager(String productManager) {
		this.productManager = productManager;
	}

	public String getProductManager() {
		return productManager;
	}

	public void setRdType(long rdType) {
		this.rdType = rdType;
	}

	public long getRdType() {
		return rdType;
	}

	public void setSoftLanguage(String softLanguage) {
		this.softLanguage = softLanguage;
	}

	public String getSoftLanguage() {
		return softLanguage;
	}

	public void setSoftLevel(long softLevel) {
		this.softLevel = softLevel;
	}

	public long getSoftLevel() {
		return softLevel;
	}

	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	public String getStartYear() {
		return startYear;
	}

	public void setState(long state) {
		this.state = state;
	}

	public long getState() {
		return state;
	}

	public void setStructMode(String structMode) {
		this.structMode = structMode;
	}

	public String getStructMode() {
		return structMode;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSysManager(String sysManager) {
		this.sysManager = sysManager;
	}

	public String getSysManager() {
		return sysManager;
	}

	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}

	public String getVersionNo() {
		return versionNo;
	}

}
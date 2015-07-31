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

package com.tuo.core.area.entity;

import java.sql.Timestamp;
import com.frameworkset.orm.annotation.PrimaryKey;

/**
 * <p>
 * Title: FgwXmsbk
 * </p>
 * <p>
 * Description: 行政区划管理服务实体类
 * </p>
 * <p>
 * tuo
 * </p>
 * <p>
 * Copyright (c) 2007
 * </p>
 * 
 * @Date 2015-03-18 22:40:50
 * @author liy
 * @version v1.0
 */
public class FgwXmsbk implements java.io.Serializable {
	@PrimaryKey
	private String sbxmid;
	private long bndscztz;
	private long bw;
	private long bx;
	private String bz;
	private String csdw;
	private String dbxm;
	private String dbxmid;
	private long dj;
	private long gsztz;
	private String hyid;
	private String itemname;
	private String jjid;
	private String jsdz;
	private String jsgm;
	private String jsnd;
	private long jsxzid;
	private String ksnd;
	private String lsgxid;
	private String lxrjfs;
	private String qqgzjz;
	private String qqgzrw;
	private String regionId;
	private String regionName;
	private String sbdw;
	private String sbdwid;
	private long sbnd;
	private String sbr;
	private String sbrlxfs;
	private Timestamp sbrq;
	private String sfbxg;
	private long sfsbj;
	private String sfyjbyy;
	private long sshj;
	private String tbdwid;
	private Timestamp tbsj;
	private String tbyh;
	private String tjjdid;
	private String tzlx;
	private String xmbh;
	private String xmdw;
	private String xmgkdw;
	private String xmlbid;
	private long xmxz;
	private String yqid;
	private long zt;
	private String zyjsnr;

	public FgwXmsbk() {
	}

	public void setSbxmid(String sbxmid) {
		this.sbxmid = sbxmid;
	}

	public String getSbxmid() {
		return sbxmid;
	}

	public void setBndscztz(long bndscztz) {
		this.bndscztz = bndscztz;
	}

	public long getBndscztz() {
		return bndscztz;
	}

	public void setBw(long bw) {
		this.bw = bw;
	}

	public long getBw() {
		return bw;
	}

	public void setBx(long bx) {
		this.bx = bx;
	}

	public long getBx() {
		return bx;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getBz() {
		return bz;
	}

	public void setCsdw(String csdw) {
		this.csdw = csdw;
	}

	public String getCsdw() {
		return csdw;
	}

	public void setDbxm(String dbxm) {
		this.dbxm = dbxm;
	}

	public String getDbxm() {
		return dbxm;
	}

	public void setDbxmid(String dbxmid) {
		this.dbxmid = dbxmid;
	}

	public String getDbxmid() {
		return dbxmid;
	}

	public void setDj(long dj) {
		this.dj = dj;
	}

	public long getDj() {
		return dj;
	}

	public void setGsztz(long gsztz) {
		this.gsztz = gsztz;
	}

	public long getGsztz() {
		return gsztz;
	}

	public void setHyid(String hyid) {
		this.hyid = hyid;
	}

	public String getHyid() {
		return hyid;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemname() {
		return itemname;
	}

	public void setJjid(String jjid) {
		this.jjid = jjid;
	}

	public String getJjid() {
		return jjid;
	}

	public void setJsdz(String jsdz) {
		this.jsdz = jsdz;
	}

	public String getJsdz() {
		return jsdz;
	}

	public void setJsgm(String jsgm) {
		this.jsgm = jsgm;
	}

	public String getJsgm() {
		return jsgm;
	}

	public void setJsnd(String jsnd) {
		this.jsnd = jsnd;
	}

	public String getJsnd() {
		return jsnd;
	}

	public void setJsxzid(long jsxzid) {
		this.jsxzid = jsxzid;
	}

	public long getJsxzid() {
		return jsxzid;
	}

	public void setKsnd(String ksnd) {
		this.ksnd = ksnd;
	}

	public String getKsnd() {
		return ksnd;
	}

	public void setLsgxid(String lsgxid) {
		this.lsgxid = lsgxid;
	}

	public String getLsgxid() {
		return lsgxid;
	}

	public void setLxrjfs(String lxrjfs) {
		this.lxrjfs = lxrjfs;
	}

	public String getLxrjfs() {
		return lxrjfs;
	}

	public void setQqgzjz(String qqgzjz) {
		this.qqgzjz = qqgzjz;
	}

	public String getQqgzjz() {
		return qqgzjz;
	}

	public void setQqgzrw(String qqgzrw) {
		this.qqgzrw = qqgzrw;
	}

	public String getQqgzrw() {
		return qqgzrw;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setSbdw(String sbdw) {
		this.sbdw = sbdw;
	}

	public String getSbdw() {
		return sbdw;
	}

	public void setSbdwid(String sbdwid) {
		this.sbdwid = sbdwid;
	}

	public String getSbdwid() {
		return sbdwid;
	}

	public void setSbnd(long sbnd) {
		this.sbnd = sbnd;
	}

	public long getSbnd() {
		return sbnd;
	}

	public void setSbr(String sbr) {
		this.sbr = sbr;
	}

	public String getSbr() {
		return sbr;
	}

	public void setSbrlxfs(String sbrlxfs) {
		this.sbrlxfs = sbrlxfs;
	}

	public String getSbrlxfs() {
		return sbrlxfs;
	}

	public void setSbrq(Timestamp sbrq) {
		this.sbrq = sbrq;
	}

	public Timestamp getSbrq() {
		return sbrq;
	}

	public void setSfbxg(String sfbxg) {
		this.sfbxg = sfbxg;
	}

	public String getSfbxg() {
		return sfbxg;
	}

	public void setSfsbj(long sfsbj) {
		this.sfsbj = sfsbj;
	}

	public long getSfsbj() {
		return sfsbj;
	}

	public void setSfyjbyy(String sfyjbyy) {
		this.sfyjbyy = sfyjbyy;
	}

	public String getSfyjbyy() {
		return sfyjbyy;
	}

	public void setSshj(long sshj) {
		this.sshj = sshj;
	}

	public long getSshj() {
		return sshj;
	}

	public void setTbdwid(String tbdwid) {
		this.tbdwid = tbdwid;
	}

	public String getTbdwid() {
		return tbdwid;
	}

	public void setTbsj(Timestamp tbsj) {
		this.tbsj = tbsj;
	}

	public Timestamp getTbsj() {
		return tbsj;
	}

	public void setTbyh(String tbyh) {
		this.tbyh = tbyh;
	}

	public String getTbyh() {
		return tbyh;
	}

	public void setTjjdid(String tjjdid) {
		this.tjjdid = tjjdid;
	}

	public String getTjjdid() {
		return tjjdid;
	}

	public void setTzlx(String tzlx) {
		this.tzlx = tzlx;
	}

	public String getTzlx() {
		return tzlx;
	}

	public void setXmbh(String xmbh) {
		this.xmbh = xmbh;
	}

	public String getXmbh() {
		return xmbh;
	}

	public void setXmdw(String xmdw) {
		this.xmdw = xmdw;
	}

	public String getXmdw() {
		return xmdw;
	}

	public void setXmgkdw(String xmgkdw) {
		this.xmgkdw = xmgkdw;
	}

	public String getXmgkdw() {
		return xmgkdw;
	}

	public void setXmlbid(String xmlbid) {
		this.xmlbid = xmlbid;
	}

	public String getXmlbid() {
		return xmlbid;
	}

	public void setXmxz(long xmxz) {
		this.xmxz = xmxz;
	}

	public long getXmxz() {
		return xmxz;
	}

	public void setYqid(String yqid) {
		this.yqid = yqid;
	}

	public String getYqid() {
		return yqid;
	}

	public void setZt(long zt) {
		this.zt = zt;
	}

	public long getZt() {
		return zt;
	}

	public void setZyjsnr(String zyjsnr) {
		this.zyjsnr = zyjsnr;
	}

	public String getZyjsnr() {
		return zyjsnr;
	}
}
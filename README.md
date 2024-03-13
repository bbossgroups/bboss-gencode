#功能介绍
本项目包含的功能如下
1. 数据库管理 数据库快速查询，数据库管理，数据库连接池监控
2. 代码生成  代码自动生成工具
3. 数据库连接池监控 活动链接、连接池配置（最大连接数、最小连接数、空闲连接数等）、正在使用链接监控
4. bboss mvc、ioc、持久层配置、Elasticsearch客户端配置等等SPI组件监控
5. 虚拟机内存使用情况监控，FreeMemory、TotalMemory、MaxMemory
6. 数据库管理工具：数据库管理和快速查询等
# 自动代码生成工具功能说明

使用参考文档：

https://doc.bbossgroups.com/#/tools

自动代码生成器是针对bboss框架和bboss开发平台的自动代码生成工具，可以根据模板，自动生成给定表的增、删、改、分页查询、列表查询、国际化功能对应的程序和配置文件：

## 1.mvc控制器
## 2.业务组件
## 3.实体类
## 4.jsp文件 可以定制不同风格的界面模板，目前提供了平台的基础ui风格
## 5.cxf webservice服务类文件
## 6.hessian服务类文件
## 7.sql配置文件
## 8.ioc/mvc组件装配部署和服务发布配置文件.
## 9.国际化属性文件和国际化配置
## 10.readme.txt 代码和配置文件集成配置说明

生成的所有文件存放在服务器上，代码生成器会提供打包下载功能

## 项目中包含的两个eclipse工程说明
gencode-core - 代码生成器核心工程

gencode-web - 代码生成器web工程

gencode-web-app - 代码生成器管理配置工程,发布war包和工具zip包

commonstyle - 为common ui风格模板提供运行环境,只需要将生成的common风格的程序集成commonstyle工程中，就可以看实际运行效果


# 自动代码生成框架构建运行说明
源码下载完毕，解压到目录d:/bboss-gencode(指定自己的目录即可)，采用gradle进行构建：
## 1.安装gradle 并将gradle设置到环境变量 参考文档：https://docs.gradle.org/current/userguide/userguide_single.html#installation
## 2.在命令行执行 
cd d:/bboss-gencode 

以war包方式发布版本（可以部署到tomcat等容器中运行工具），则执行指令： 

gradle :gencode-web-app:releaseRuntimeWar 

以zip包方式发布版本（内置jetty容器，解压zip包，linux/mac/unix等环节运行startup.sh,windows环境运行里面的startup.bat即可），则执行指令： 

gradle :gencode-web-app:releaseRuntimeZip 
## 3.构建成功后(gradle :gencode-web-app:releaseRuntimeZip)： 
windows环境下运行d:/bboss-gencode/gencode-web-app/build/dist/gencode/startup.bat 
linux/unix/mac os环境下运行startup.sh 

同时在d:/bboss-gencode/gencode-web-app/build/distributions会发布出一个带jetty容器独立运行的zip包和可以部署到tomcat的war包： 

gencode-4.10.8.zip 

gencode-4.10.8.war 

更是使用配置和使用手册参考文档：http://yin-bp.iteye.com/blog/2256948

即可启动自动代码生成框架应用，在浏览器端访问以下地址，即可在界面中配置数据源，
配置表单，生成源代码、查看自动生成的代码部署说明文档、浏览并下载源代码：

http://localhost/gencode

## License

The BBoss Framework is released under version 2.0 of the [Apache License][].

[Apache License]: http://www.apache.org/licenses/LICENSE-2.0

## todo list

ui输入类型支持textarea、选择部门、选择用户、当前部门、当前机构、当前时间等类型

### 添加历史sql创建时间字段

ALTER TABLE sql_history ADD COLUMN CREATETIME number(10);



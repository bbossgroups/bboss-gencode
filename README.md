# 自动代码生成工具功能说明

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
bboss-gencode - 自动代码生成器eclipse工程

bboss-gencode/gencode - 为common ui风格模板提供运行环境的eclipse工程

# 自动代码生成框架构建运行说明：
## 1.安装好ant构建环境和jdk 1.7或以上版本
## 2.运行工程根目录下的build.bat指令
## 3.构建成功后：

windows环境下运行distrib/run/startup.bat，

linux/unix/mac os环境下运行distrib/run/startup.sh

即可启动自动代码生成框架应用，在浏览器端访问以下地址，即可在界面中配置数据源，
配置表单，生成源代码、查看自动生成的代码部署说明文档、浏览并下载源代码：

http://localhost/gencode

## License

The BBoss Framework is released under version 2.0 of the [Apache License][].

[Apache License]: http://www.apache.org/licenses/LICENSE-2.0

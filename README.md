# lw-oa: 在线文档管理(企业版)

#### 更新记录

2019-1-26 

	1.适配手机端
	2.文件上传获取不到项目路径问题
	3.表单提交中文数据库乱码问题
	4.手机端下载tomcat报错（未解决）

2018-1-27

	1. 设置文件查看权限	

2019-3-5

	1. 支持文件夹功能
	2. 文件夹分享可以查看所有子目录
	3. 支持文件夹内的单个文件分享，和2可以并存
	4. 表结构变动
	5. 手机端不支持新建文件夹，支持上传文件
	
2019-3-5
	
	1. 文件夹支持重命名：amazeui modal confirm会重复提交，不支持remote远程请求，恶心，搞了几晚上
	2. 重写 cancel/confirm 按钮的事件处理函数: http://amazeui.org/javascript/modal#
	
2019-3-7 计划
	
	1. 提取JSP共同代码块进行单独维护，权限抽离
	2. 考虑文件夹移动
	3. SpringBoot之使用Druid连接池以及SQL监控和spring监控: https://www.cnblogs.com/shyroke/p/8045077.html
	   druid不同版本，SQL监控会没有SQL打印
	4. 

#### 介绍
项目由来：

有个朋友说他们公司文档管理不规范，报价单改来改去也不知道是不是最新的，最后给客户出现多个报价单的情况，所以才有了这个项目

项目功能：
1. 人员管理：支持管理员后台新增，删除，编辑人员；设置账号状态：启用或禁用；并且可设置人员权限：管理员和普通员工
2. 我的文档：管理员才有权限进入我的文档，支持上传，下载，删除，授权哪些用户可查看。支持查询不分页
3. 文档下载：所有人都有的权限，只有你被赋值了文件查看权限，才能看到哪些你可以看到，并且下载.。支持查询不分页


#### 软件架构
Springboot 1.5.10 + JdbcTemplate + Mybatis + Amazeui

注：个人觉得使用jdbctemplate开始简单，但是对于功能稍微复杂系统来说，有点繁琐，SQL维护起来有点困难，在分支mybatis里面会替换掉


#### 安装教程

1. mavne打包命令：maven package
2. cmd命令：java -jar lw-springboot-oa-1.0-SNAPSHOT.war
3. 项目日志：C:/logs/lw-oa/lw-oa.log

#### 使用说明

1. xxxx
2. xxxx
3. xxxx


# 项目介绍
数据桥接网关--处理数据提供方数据加工--数据加工厂
# 数据桥接网关安装手册
### 一、JDK安装
1.    进入orcale官网选择需要下载的版本jdk1.8.0_171
* 建议版本：jdk-8u171-linux-x64.rpm（建议安装1.8及以上）
* linux系统用命令行下载、安装和配置jdk1.8的详细步骤https://blog.csdn.net/zhangtxsir/article/details/72685357
2.    安装jdk :rpm -ivh jdk-8u171-linux-x64.rpm
* 如果下载的是tar.gz包,直接用命令tar -zxvf jdk-8u171-linux-x64.tar.gz解压即可
3.    配置环境变量
* 执行vi /etc/profile，在文件末尾添加
* export JAVA_HOME=/home/roo/jdk1.8.0_171  (这里修改为自己的jak安装路径)
* export PATH=$JAVA_HOME/bin:$PATH
* export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
4.    然后执行java -version看看是否配置成功

### 二、Tomcat安装
5.    下载解压tomcat（http://tomcat.apache.org/）建议：Tomcat 8.0
建议下载zip或tar.gz直接解压使用

### 三、Mysql安装
6.    进入mysql官网选择需要下载的版本
建议版本：Server version: 5.7.20 MySQL Community Server
7.    设置用户名：例如：eds_root
8.    设置密码：例如：eds_pass
9.    设置端口：3306(建议使用默认端口)

### 四、数据库导入
##### 假设数据库文件目录：/Users/lufeng/Desktop/eds/ud_eds_db.sql
1.    mysql -h localhost -u root -p（进入mysql下面）
2.    create database xxx;(创建数据库)
3.    show databases;(就可看到所有已经存在的数据库，及刚刚创建的数据库xxx)
4.    use xxx;(进入xxx数据库下面)
5.    show tables;(查看xxx数据库下面的所有表,空的)
6.    source  /Users/lufeng/Desktop/eds/ud_eds_db.sql（导入数据库表）
7.    show tables;(查看xxx数据库下面的所有表,就可以看到导入的表了)

### 五、修改配置文件
1.    在路径../Tomcat/webapps/config(需创建)目录下创建application.properties配置文件
2.    增加private.key=用户私钥
3.    增加spring.datasource.druid.url=(对应mysql服务器：端口、数据库名称)
增加spring.datasource.druid.username=对应本地设置的username)
增加spring.datasource.druid.password=(对应本地设置的password)
* 注意：重新修改项目配置文件application.properties,需重新启动Tomcat才能生效。


### 六、自定义类处理模式
##### sdk包：ud-eds-sdk-1.0.jar 基于sdk进行自定义类开发
1.  加载mvn install:install-file -Dfile=.../ud-eds-sdk-1.0.jar -DgroupId=org.unitedata.eds -DartifactId=ud-eds-sdk -Dversion=1.0 -Dpackaging=jar
2. 
<dependency>
<groupId>org.unitedata.eds</groupId>
<artifactId>ud-eds-sdk</artifactId>
<version>1.0</version>
</dependency>
1.    自定义类xxx.java实现IChange接口：
public interface IChange {
//获取需求方所需数据
DataSet change(OutPutDefinition outPutDefinition, Map<String, String> params);
//数据获取方式测试接口
int validate(Table table, OutPutDefinition outPutDefinition, Map<String, String> params);
}
* 注：
* SUCCESS(0,"测试通过!"),
* FAILURE(1,"测试不通过，无法获取数据!"),
* DISAGREE(2,"测试不通过，请检查数据是否与标准数据字典对应!");

2.    编译自定义类为xxx.class
3.    将编译成功xxx.class文件放在…/Tomcat/webapps/classes(需创建)目录之下

### 七、War包部署
##### war包：ud-eds.war 企业内部系统web应用程序
1.    将ud-eds.war放在Tomcat安装目录中的/webapps目录下
2.    运行Tomcat（bin目录下执行：sudo sh startup.sh）
3.    浏览器访问http://localhost:8080/ud-eds/ 测试部署是否成功 (若失败，请检查以上操作或咨询相关人员)

### 八、匿踪配置
1.    准备数据库创建hidden_info表：
CREATE TABLE `hidden_info` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '匿踪ID',
`md5` varchar(20) DEFAULT NULL COMMENT '数据的md5码',
`realvalue` varchar(30) DEFAULT NULL COMMENT '数据的原始值',
`type` varchar(20) DEFAULT NULL COMMENT '匿踪类型',
`bizkey` varchar(20) DEFAULT NULL COMMENT '业务类别',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='匿踪信息';
* 注：
* md5 数据的md5码
* type 暂时支持 两种类型 1.idno （身份证）2.mobile （手机号）
* bizkey 指匿踪业务类别，对应于数据桥接网关匿踪配置页面的业务类别

2.    hidden_info表中插入数据，以供匿踪查询
3.    数据桥接网关配置匿踪数据所在数据库信息
4.    数据桥接网关配置匿踪配置，持久化合约与业务类别对应关系

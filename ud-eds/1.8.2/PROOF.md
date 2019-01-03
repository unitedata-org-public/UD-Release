## 凭证上传操作文档

#### 黑名单凭证数据结构
![image](https://github.com/unitedata-org-public/UD-Release/blob/master/ud-eds/1.8.3/images/blacklist.png)

#### 黑名单凭证数据表
```
DROP TABLE IF EXISTS `blacklist_info`;
CREATE TABLE `blacklist_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `overdue_data` text DEFAULT NULL COMMENT '逾期信息',
  `time_stamp` bigint(20) DEFAULT NULL COMMENT '时间戳',
  `random_code` bigint(20) DEFAULT NULL COMMENT '静态随机码',
  `hit_two_hash` varchar(100) DEFAULT NULL COMMENT '二要素MD5',
  `hit_two_random_hash` varchar(100) DEFAULT NULL COMMENT '二要素凭证（二要素MD5,静态随机码）',
  `base_hash` varchar(100) DEFAULT NULL COMMENT '基础数据MD5（二要素MD5，逾期信息）',
  `privacy_hash` varchar(100) DEFAULT NULL COMMENT '私有数据MD5（二要素MD5,数据,时间戳,静态随机码）',
  `sign_hash` varchar(200) DEFAULT NULL COMMENT '数字签名（私有数据MD5,私钥签名）',
  `account` varchar(50) DEFAULT NULL COMMENT '创建者账户',
  `trx_id` varchar(64) DEFAULT NULL COMMENT '凭证交易ID',
  `block_num` bigint(20) DEFAULT NULL COMMENT '区块高度',
  `sync_time` bigint(20) DEFAULT NULL COMMENT '同步时间',
  `sync_status` int DEFAULT '0' COMMENT '同步状态 0-未同步，1-已同步',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_key` (`base_hash`) USING BTREE,
  INDEX `IDX_HIT_TWO_HASH` (`hit_two_hash`),
  INDEX `IDX_HIT_TWO_RANDOM_HASH` (`hit_two_random_hash`),
  INDEX `IDX_BASE_HASH` (`base_hash`),
  INDEX `IDX_TRX_ID` (`trx_id`),
  INDEX `IDX_SYNC_STATUS` (`sync_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黑名单数据';
```
#### 基本数据上传
##### 基本上传接口
* 通过数据桥接网关黑名单基础数据上传接口创建数据
* url
```
http://localhost:8080/ud-eds/api/blacklist/add
```
* method

```
POST
```
* requestParam

```
[
    {
    "hitTwoHash":"b5cd14dac17836fbaf1175f38d151da7",//姓名+身份证的hash值
    "overdueData":"overdue data"//逾期信息json值       
    }
]
```
* responseDemo

```json
{
"code": "200",
"message": "请求成功",
"data": "success"
}
```

* 注：上传数据会进行手机号校验、身份证校验，未通过校验的数据会被过滤，不予创建。

##### 批量上传工具
通过斑马合约上传工具
* 将数据源导出到明文二要素csv文件，格式为（姓名，身份证,逾期信息）。 示例：

    张三,32098219880703086X,{"overdueMonth":"2018-01-01","overdueDays":"5","overdueQuantity":" 500 RMB"}
    王五,11098219880703086X,{"overdueMonth":"2018-01-01","overdueDays":"5","overdueQuantity":" 500 RMB"}

* 通过密文生成工具，将明文二要素转换为密文文件

    java -jar test-tool-1.9.2.jar -gu 明文csv文件

* 将密文文件通过上传工具页面上传
```
http://localhost:8080/ud-eds/blacklist-upload
```
* 支持功能

1. 上传Csv文件---检验数据格式---解析文件---录入数据

* responseDemo

```json
{
"code": "200",
"message": "请求成功",
"data": "上传成功"
}
```

#### 凭证数据生成规则（上链凭证）
1.hit_two_hash（二要素MD5） ：（姓名+身份证）MD5

2.hit_two_random_hash（身份凭证）：（二要素MD5+静态随机码）MD5

3.privacy_hash （逾期凭证）： （（姓名+身份证）MD5+逾期信息+时间戳+静态随机码）MD5 

4.sign_hash （数字签名）： （逾期凭证）私钥签名

注：random_code ：静态随机码

#### 黑名单凭证上链流程
![image](https://github.com/unitedata-org-public/UD-Release/blob/master/ud-eds/1.8.3/images/proof.png)

#### EDS匿踪查询&精确查询

##### 1.匿踪查询：
入参：二要素MD5

出参：二要素MD5、身份凭证、静态随机码、上传时间戳

##### 2.精确查询：
入参：身份凭证

出参：姓名、手机号、身份证、逾期信息、上传时间戳、静态随机码、二要素MD5、身份凭证、逾期凭证、数字签名、凭证提供方、交易号、区块号、同步时间


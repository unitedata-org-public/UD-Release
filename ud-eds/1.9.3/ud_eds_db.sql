#数据库配置信息表
DROP TABLE IF EXISTS `dataserver_info`;
CREATE TABLE `dataserver_info` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`server_name` varchar(255) DEFAULT NULL COMMENT '显示名称',
`server_ip` varchar(255) DEFAULT NULL COMMENT '主机',
`server_port` bigint(11) DEFAULT NULL COMMENT '端口号',
`user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
`pass_word` varchar(255) DEFAULT NULL COMMENT '密码',
`db_name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
`db_type` varchar(255) DEFAULT NULL COMMENT '数据库类型',
`created_person` varchar(100) DEFAULT NULL COMMENT '创建人',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_person` varchar(100) DEFAULT NULL COMMENT '修改人',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库信息';

#数据输出定义信息表
DROP TABLE IF EXISTS `outputdefinition_info`;
CREATE TABLE `outputdefinition_info` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`table_name` varchar(255) DEFAULT NULL COMMENT '关联表名称',
`schema_name` varchar(255) DEFAULT NULL COMMENT '关联表类型名称',
`def_sql` varchar(3000) DEFAULT NULL COMMENT '定义sql',
`change_mode` varchar(255) DEFAULT NULL COMMENT '转换模式',
`ds_id` bigint(11) DEFAULT NULL COMMENT '数据库标识',
`created_person` varchar(100) DEFAULT NULL COMMENT '创建人',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_person` varchar(100) DEFAULT NULL COMMENT '修改人',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
PRIMARY KEY (`id`),
  INDEX IDX_SCHEMA_TABLE(`schema_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='输出定义信息';

#提供方参与合约信息表
DROP TABLE IF EXISTS `contract_info`;
CREATE TABLE `contract_info` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合约ID',
`provider` varchar(255) DEFAULT NULL COMMENT '提供方',
`contract_account` varchar(255) DEFAULT NULL COMMENT '合约账号',
`contract_name` varchar(255) DEFAULT NULL COMMENT '合约名称',
`join_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '参与时间',
`contract_status_type` int(6) DEFAULT NULL COMMENT '合约状态',
`table_param_list` varchar(255) DEFAULT NULL COMMENT '合约数据字典',
`hidden` tinyint(1) DEFAULT '0' COMMENT '匿踪标识:0=不匿踪,1=匿踪',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '停用标识:0=不停用,1=停用',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合约信息';

#匿踪信息表
DROP TABLE IF EXISTS `hidden_info`;
CREATE TABLE `hidden_info` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '匿踪ID',
`md5` varchar(20) DEFAULT NULL COMMENT '数据的md5码',
`realvalue` varchar(30) DEFAULT NULL COMMENT '数据的原始值',
`type` varchar(20) DEFAULT NULL COMMENT '匿踪类型',
`bizkey` varchar(20) DEFAULT NULL COMMENT '业务类别',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
PRIMARY KEY (`id`),
INDEX idx_md5(`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='匿踪信息';

#合约业务信息表
DROP TABLE IF EXISTS `contract_biz`;
CREATE TABLE `contract_biz` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '标识ID',
`contract_id` varchar(20) DEFAULT NULL COMMENT '合约ID',
`bizkey` varchar(20) DEFAULT NULL COMMENT '业务类别',
`ds_id` bigint(11) DEFAULT NULL COMMENT '数据库标识',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
PRIMARY KEY (`id`),
INDEX idx_contract_id(`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合约对应业务信息';

#仓储空间信息表
DROP TABLE IF EXISTS `cache_info`;
CREATE TABLE `cache_info` (
`id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`key_info` varchar(200) NOT NULL COMMENT '查询的key',
`value_info` text COMMENT '查询的value',
`type_info` int not null default '0' comment '数据类型',
`state` tinyint not null default '0' comment '数据状态',
`mods` int not null default '0' comment '变更次数',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
PRIMARY KEY (`id`),
UNIQUE KEY `uk_key` (`key_info`,`type_info`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='持久化数据对象库';

#第三方授权存证数据表
drop table if exists `tb_certification_log`;
create table `tb_certification_log`(
`id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`key_info` varchar(32) DEFAULT NULL COMMENT '存证 key',
`token` varchar(128) DEFAULT NULL COMMENT '存证',
`scope` varchar(16) DEFAULT NULL COMMENT '存证所属域',
`account` varchar(16) DEFAULT NULL COMMENT '存证存储账户',
`factor` bigint DEFAULT NULL COMMENT '存证计算因子，一个随机数',
`time_stamp` bigint DEFAULT NULL COMMENT '存证计算时间',
`parameters` varchar(1024) DEFAULT NULL COMMENT '存证计算参数',
`sign` varchar(128) DEFAULT NULL COMMENT '存证签名',
`sta` int DEFAULT NULL COMMENT '操作状态：描述当前操作的状态',
`descrip` varchar(256) DEFAULT NULL COMMENT '操作描述：描述当前操作的说明',
`block_num` bigint DEFAULT NULL COMMENT '区块高度',
`trx_id` varchar(128) DEFAULT NULL COMMENT '交易ID',
`sync_time` bigint DEFAULT NULL COMMENT '区块同步到达时间',
`send_sync_time` bigint DEFAULT NULL COMMENT '发起同步时间',
`sync_status` int DEFAULT NULL COMMENT '同步状态',
`active` tinyint(1) DEFAULT 1 COMMENT '逻辑删除标识:0=无效,1=有效',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
PRIMARY KEY (`id`),
INDEX idx_certify_log_key (`key_info`),
INDEX idx_certify_log_token (`token`),
INDEX idx_trx_id(`trx_id`),
INDEX idx_sync_status(`sync_status`),
INDEX idx_block_num(`block_num`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARSET = utf8 COMMENT = '第三方存证操作日志';

#黑名单数据表
DROP TABLE IF EXISTS `blacklist_info`;
#凭证管理表
CREATE TABLE proof_upload_history(
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
	`upload_id` bigint(20) DEFAULT NULL COMMENT '上传批次id',
	`contract_address` varchar(50) DEFAULT NULL COMMENT '合约地址',
    `file` varchar(256) DEFAULT NULL COMMENT '文件名',
    `account` varchar(100) DEFAULT NULL COMMENT '上传者',
    `hash` varchar(256) DEFAULT NULL COMMENT 'Hash(合约地址，文件名, 上传者)',
    `records_num` int DEFAULT 0 COMMENT '文件包含条目数',
    `to_db_num` int DEFAULT 0 COMMENT '入库成功数链',
	`success_num` int DEFAULT 0 COMMENT '上链同步成功数量',
	`push_time` timestamp NOT NULL COMMENT '上传时间',
    `status` int DEFAULT NULL COMMENT '状态',
    `status_desc` varchar(50) DEFAULT NULL COMMENT '状态描述',
	`createdby` varchar(100) DEFAULT NULL COMMENT '创建人',
    `pushchain_errors` text DEFAULT NULL COMMENT '上链异常',
    `upload_errors` mediumtext DEFAULT NULL COMMENT '上传遇到的问题',
	`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
	`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
	 PRIMARY KEY (`id`),
	 UNIQUE KEY `uk_key` (`upload_id`) USING BTREE,
	 INDEX `IDX_UPLOADID` (`upload_id`)
 );

CREATE TABLE `blacklist_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contract_address` varchar(50) DEFAULT 'ud.blacklist' COMMENT '合约地址',
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
  `upload_id` bigint(20) DEFAULT NULL COMMENT '上传批次id',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_key` (`contract_address`,`base_hash`) USING BTREE,
  INDEX `IDX_CONTRACT_ADDRESS` (`contract_address`),
  INDEX `IDX_HIT_TWO_HASH` (`hit_two_hash`),
  INDEX `IDX_HIT_TWO_RANDOM_HASH` (`hit_two_random_hash`),
  INDEX `IDX_BASE_HASH` (`base_hash`),
  INDEX `IDX_TRX_ID` (`trx_id`),
  INDEX `IDX_SYNC_STATUS` (`sync_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黑名单数据';


 CREATE TABLE lock_entries(
     `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
	`name` varchar(100) DEFAULT NULL COMMENT '锁名',
	`owner` varchar(255) DEFAULT NULL COMMENT '持有者',
    `last_accuired_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
	UNIQUE KEY `uk_key` (`name`) USING BTREE
 )

#黑名单需求方请求数据表
DROP TABLE IF EXISTS `hide_request_info`;
CREATE TABLE `hide_request_info` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`order_id` bigint(20) DEFAULT NULL COMMENT '请求订单ID',
`name` varchar(50) DEFAULT NULL COMMENT '姓名',
`idno` varchar(30) DEFAULT NULL COMMENT '身份证号',
`time_stamp` bigint(20) DEFAULT NULL COMMENT '请求时间戳',
`two_md` varchar(100) DEFAULT NULL COMMENT '二要素MD5',
`request_random_code` bigint(20) DEFAULT NULL COMMENT '请求凭证随机数',
`request_proof` varchar(100) DEFAULT NULL COMMENT '请求凭证',
`sign` varchar(200) DEFAULT NULL COMMENT '需求方签名',
`comment` varchar(200) DEFAULT NULL COMMENT '备注',
`createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='需求方请求数据';

#黑名单提供方响应数据表
DROP TABLE IF EXISTS `provide_response_info`;
CREATE TABLE `provide_response_info` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`order_id` bigint(20) DEFAULT NULL COMMENT '请求订单ID',
`hide_md` varchar(100) DEFAULT NULL COMMENT 'MD5（二要素MD5+匿踪随机数）',
`hide_random_code` bigint(20) DEFAULT NULL COMMENT '匿踪随机数',
`request_proof` varchar(100) DEFAULT NULL COMMENT '请求凭证',
`random_code` bigint(20) DEFAULT NULL COMMENT '身份凭证随机数',
`hit_two_random_hash` varchar(100) DEFAULT NULL COMMENT '身份凭证',
`upload_time_stamp` bigint(20) DEFAULT NULL COMMENT '上传时间戳',
`back_time_stamp` bigint(20) DEFAULT NULL COMMENT '返回时间戳',
`data_summary` varchar(100) DEFAULT NULL COMMENT '上报数据摘要',
`sign` varchar(200) DEFAULT NULL COMMENT '提供方签名',
`comment` varchar(200) DEFAULT NULL COMMENT '备注',
`createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提供方响应数据';

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `role` int DEFAULT '0' COMMENT '角色 0-普通用户(默认)，1-管理员',
  `status` int DEFAULT '1' COMMENT '状态 0-禁用，1-启用(默认)',
  `actor` varchar(50) DEFAULT NULL COMMENT '最后操作人',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户管理表';
INSERT INTO user_info(`account`,`password`,`name`,`email`,`role`,`status`) VALUES(`admin`,`123456`,`admin`,`admin@admin.com`,1,1);


#用户登陆token表
DROP TABLE IF EXISTS `token_info`;
CREATE TABLE `token_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户标识',
  `token` varchar(200) DEFAULT NULL COMMENT '登陆标识',
  `login_time` bigint(20) DEFAULT NULL COMMENT '登陆时间',
  `comment` varchar(200) DEFAULT NULL COMMENT '备注',
  `createdby` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedby` bigint(20) DEFAULT NULL COMMENT '修改人',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '逻辑删除标识:0=无效,1=有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登陆token表';


#合约操作信息表
ALTER TABLE cache_info ADD COLUMN (
`sync_cnt` bigint(20) DEFAULT '0' COMMENT '同步次数',
`sync_status` int(6) DEFAULT '0' COMMENT '同步状态');
ALTER TABLE cache_info ADD INDEX IDX_SYNC_STATUS(`sync_status`);

#合约信息表增加合约类型字段
ALTER TABLE contract_info ADD COLUMN `contract_type` int(6) DEFAULT '0' COMMENT '合约类型0-链上交易合约，1-记账模式合约，2-主题合约';
ALTER TABLE blacklist_info
ADD COLUMN  `contract_address` varchar(50) DEFAULT 'ud.blacklist' COMMENT '合约地址',
DROP KEY `uk_key`,
ADD UNIQUE KEY `uk_key_contract` (`contract_address`,`base_hash`) ,
ADD INDEX `IDX_CONTRACT_ADDRESS` (`contract_address`);



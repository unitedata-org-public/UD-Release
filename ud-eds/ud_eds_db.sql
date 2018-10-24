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
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='输出定义信息';

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
`active` tinyint(1) DEFAULT '1' COMMENT '停用标识:0=不停用,1=停用',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合约信息';

DROP TABLE IF EXISTS `hidden_info`;
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

DROP TABLE IF EXISTS `contract_biz`;
CREATE TABLE `contract_biz` (
`id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '标识ID',
`contract_id` varchar(20) DEFAULT NULL COMMENT '合约ID',
`bizkey` varchar(20) DEFAULT NULL COMMENT '业务类别',
`ds_id` bigint(11) DEFAULT NULL COMMENT '数据库标识',
`created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合约对应业务信息';

DROP TABLE IF EXISTS `cache_info`;
CREATE TABLE `cache_info` (
`id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`key_info` varchar(255) NOT NULL COMMENT '查询的key',
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

ALTER TABLE hidden_info ADD index idx_md5(`md5`);
ALTER TABLE contract_biz ADD index idx_contract_id(`contract_id`);

#黑名单数据表增加合约标识字段
ALTER TABLE blacklist_info
ADD COLUMN  `contract_address` varchar(50) DEFAULT 'ud.blacklist' COMMENT '合约地址',
DROP KEY `uk_key`,
ADD UNIQUE KEY `uk_key_contract` (`contract_address`,`base_hash`) ,
ADD INDEX `IDX_CONTRACT_ADDRESS` (`contract_address`);

#用户管理表
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

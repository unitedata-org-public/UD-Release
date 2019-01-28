#黑名单数据表增加合约标识字段
ALTER TABLE blacklist_info
ADD COLUMN  `contract_address` varchar(50) DEFAULT 'ud.blacklist' COMMENT '合约地址',
DROP KEY `uk_key`,
ADD UNIQUE KEY `uk_key_contract` (`contract_address`,`base_hash`) ,
ADD INDEX `IDX_CONTRACT_ADDRESS` (`contract_address`);


# 1.6.1-RELEASE

## 更新日志

### 简化配置内容

> 新增配置

```java
model.data.repository=default
```

> 移除配置

```java
contract.resolver=org.unitedata.producer.server.domain.contract.eos.EosDataContractRepository
persistence.service=org.unitedata.producer.server.domain.persistable.EdsDataContractRepository
```

移除 spring redis 相关配置：

```java
spring.redis.password=
spring.redis.host=localhost
spring.redis.port=6379
spring.redis.pool.max-active=8
spring.redis.pool.max-wait=-1
spring.redis.pool.max-idle=8
spring.redis.pool.min-idle=0
spring.redis.timeout=3000
```

增加 jedis 相关配置，并支持外部配置，详细过程请查看 [jedis 外部配置](DEPLOY.md)：

```java
redis.host=localhost
redis.port=6379
redis.password=
redis.timeout=3000
redis.pool.max-active=8
redis.pool.max-wait=-1
redis.pool.max-idle=8
redis.pool.min-idle=0
```

### 优化业务流程

* 移除基于 redis 的持久化数据仓库
* 新增基于 redis 的数据缓存仓库
* 新增基于 EDS 数据桥接网关的持久化数据仓库
* 新增区块链数据同步模块
* 新增支持业务操作消息上报模块
* 其它请自行体验...

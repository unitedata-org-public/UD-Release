
# 数据需求方-数据服务 API 部署文档

```plaintext
数据服务 api 是基于 http[s] 协议的一个数据需求方服务端服务。
它给数据需求方提供了一种方便的内部数据访问的可靠服务，包含了所有的需求方相关业务。
并且提供了一组 restful API 风格的简单接口

版本：1.9.6.FINAL
```

## 部署和运行

1. [使用 jar 包部署](DEPLOY-WITH-JAR)

## 数据服务配置

数据服务可配置内容：

```java
# 需求方链上账户名称
consumer.account=
# 需求方链上账户密匙
consumer.key=
# 自动创建合约订单状态。默认为 true
trx.create-auto=true

# 安全检查启用状态。需要配合 security.api 结合使用，在启用状态（true）时，需要指明 security.api ，
# 否则讲会抛出错误。
# 默认为 false。
# 将在用户每一次的业务调用过程之前，将用户的所有参数向 security.api 指向的地址发起调用。
# 并需要返回 SUCCESS 结果；否则标识安全检查失败。
security.enable=false
# 安全检查 http[s] 远程访问地址
security.api=
```

## 自定义外部配置

```plaintext
请参照 spring boot 配置文件
```

## 日志

默认日志文件：${user.home}/logs/ud/consumer-server.log

## API 文档说明

* [API 说明文档](API)
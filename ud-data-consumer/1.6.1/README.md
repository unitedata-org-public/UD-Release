
# 1.6.1-RELEASE

* [ud-data-consumer-sdk-1.6.1.release.tar.gz](ud-data-consumer-sdk-1.6.1.release.tar.gz?raw=true)
* [ud-data-consumer-server-1.6.1.release.tar.gz](ud-data-consumer-server-1.6.1.release.tar.gz?raw=true)
* [SDK 接入说明](SDK.md)
* [服务部署说明](DEPLOY.md)

## 更新日志

> DataQueryClient 新增函数

```java
/**
 * 释放占用的所有资源
 */
public static void dispose()
```

> DataQueryProtocol

```java
移除 setTransactionTicks(int) 使用 setTradeType(byte,int)代替
移除 getTransactionMode() 使用 getTradeType() 代替
移除 getMinPreviousTransactionSize() 使用 getMinPreviousTransactionQuantity() 代替
移除 setMinPreviousTransactionSize(int) 使用 setMinPreviousTransactionQuantity(int) 代替

移除 setTransactionRepository(TransactionRepository)
移除 getTransactionRepository()
移除 getContractHandler()
移除 setDataContractHandler(DataContractHandler)
移除 query(TransactionMode, String, String,Map<String, Object>)

限制 setTransactionIdentityBuilder(TransactionIdentityBuilder)
```

> 新增模块

```java
1. 消息上报模块，核心接口 org.unitedata.data.consumer.data.message.TransactionPublishedMessageData
2. 多方计算处理模块，核心接口 org.unitedata.data.consumer.multi.MultiCalcResolver
```
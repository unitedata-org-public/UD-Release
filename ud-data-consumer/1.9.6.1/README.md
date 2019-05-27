
# 1.9.6.1-RELEASE

* [需求方服务](DEPLOY.md)
* [简单需求方 sdk 接入](SDK-DEPENDANCY-CORE.md)
* [第三方存证 sdk 接入](SDK-DEPENDANCY-CERTIFICATION.md)
* [“斑马” 服务 sdk 接入](SDK-DEPENDANCY-ZEBRA.md)
* [id-mapping 用户影像 sdk 接入](SDK-DEPENDANCY-IDMAPPING.md)

## 更新日志

``` plaintext
1，优化 eos 构建订单交易体过程，将链交互过程由 3 次减少为 1 次
2，优化需求方和提供方斑马业务过程
3，优化需求方 idmapping 服务存证生成过程
4，优化提供方 idmapping 在没有得到存证授权参数时，放弃处理，代替上一版本的抛出错误的处理
5，优化了 rpc 内部类型声明的情况
6，其他...
```

## 项目结构

* [项目结构](../shared/consumer-struct.1.0.md)


# 需求方服务 API 说明文档

## 返回值

> 返回值结构:

```json
{
    "code": "0",
    "data": Object,
    "error": "OK"
}
```

名称|类型|说明
---|---|----
code|string|code=0 时标识请求业务成功；否则返回相应的错误代码，在 error 中能够获取具体的错误内容。
error|string|错误详细内容
data|object|返回数据正文

## 简单存证业务

```plaintext
简单存证业务是一个附着在主业务线上的一种例外业务，可以由用户决定是否启用。
启用方式就是在请求的参数加入一个名称为 cert 的 CertSupport 结构实例
```

> CertSupport 结构

```json
{
    "bizId": "string",
    "bizName": "string",
    "encryptType": "string",
    "protocolDigest": "string",
    "publicKey": "string"
}
```

名称|类型|必填|说明
---|---|-|----
bizId|string|true|业务 ID
bizName|string|true|业务名称
protocolDigest|string|true|已备案协议摘要
encryptType|string|false|存证签名方式
publicKey|string|false|签名验证公钥

## 根据指定的二要素(证件号码，姓名)查询黑名单内容

```plaintext
[POST] /query/credit
```

> 参数说明

```json
{
  "contractId": "string",
  "detailRequired": true,
  "id": "330987197506230098",
  "name": "张三",
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
detailRequired|boolean|true|是否需要查询黑名单详细信息
id|string|true|二要素证件号码
name|string|true|二要素姓名
transactionId|string|false|交易订单 id
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递

> 返回结果

```json
{
  "code": "string",
  "data": {
    "details": [{}],
    "hasDetail": true,
    "hit": true
  },
  "error": "string"
}
```

名称|类型|说明
---|---|----
hit|boolean|是否命中状态
hasDetail|boolean|是否查询详细
details|array[map]|一组命中的详细信息

## 第三方存证认证

```plaintext
[POST] /certification/register
```

> 参数说明

```json
{
  "args": {},
  "contractId": "string",
  "producer": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
producer|string|true|第三方存证提供方账户名称
args|map|true|查询参数，接收业务性参数内容

> 返回结果

```json
{
  "code": "string",
  "data": {
    "account": "string",
    "factor": 0,
    "key": "string",
    "parameters": [
      "string"
    ],
    "scope": "string",
    "sign": "string",
    "state": "string",
    "timestamp": 0,
    "token": "string"
  },
  "error": "string"
}
```

名称|类型|说明
---|---|----
account|string|存证账户
factor|long|一个随机数，计算当前存证的随机因子
key|string|当前存证唯一标识
token|string|另外一种形式的存证唯一标识，这个值用来开放使用
parameters|array[string]|参与计算当前存证的参数名称
scope|string|当前存证所属域
sign|string|当前存证签名
state|string|当前存证状态：活动(active)，移除(removed)
timestamp|long|当前存证认证时间戳

## 第三方存证获取

```plaintext
[POST] /certification/acquire
```

> 参数说明

```json
{
  "args": {},
  "contractId": "string",
  "producer": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
producer|string|true|第三方存证提供方账户名称
args|map|true|查询参数，接收业务性参数内容

> 返回结果

```json
{
  "code": "string",
  "data": {
    "account": "string",
    "factor": 0,
    "key": "string",
    "parameters": [
      "string"
    ],
    "scope": "string",
    "sign": "string",
    "state": "string",
    "timestamp": 0,
    "token": "string"
  },
  "error": "string"
}
```

名称|类型|说明
---|---|----
account|string|存证账户
factor|long|一个随机数，计算当前存证的随机因子
key|string|当前存证唯一标识
token|string|另外一种形式的存证唯一标识，这个值用来开放使用
parameters|array[string]|参与计算当前存证的参数名称
scope|string|当前存证所属域
sign|string|当前存证签名
state|string|当前存证状态：活动(active)，移除(removed)
timestamp|long|当前存证认证时间戳

## 第三方存证移除

```plaintext
[POST] /certification/remove
```

> 参数说明

```json
{
  "contractId": "string",
  "producer": "string",
  "token": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
producer|string|true|第三方存证提供方账户名称
token|string|true|第三方存证令牌

> 返回结果

```json
{
  "code": "string",
  "data": {
    "account": "string",
    "factor": 0,
    "key": "string",
    "parameters": [
      "string"
    ],
    "scope": "string",
    "sign": "string",
    "state": "string",
    "timestamp": 0,
    "token": "string"
  },
  "error": "string"
}
```

名称|类型|说明
---|---|----
account|string|存证账户
factor|long|一个随机数，计算当前存证的随机因子
key|string|当前存证唯一标识
token|string|另外一种形式的存证唯一标识，这个值用来开放使用
parameters|array[string]|参与计算当前存证的参数名称
scope|string|当前存证所属域
sign|string|当前存证签名
state|string|当前存证状态：活动(active)，移除(removed)
timestamp|long|当前存证认证时间戳

## 支持基于身份证件号码进行匿踪阶段的简单数据查询

```plaintext
[POST] /query/idcard
```

> 参数说明

```json
{
  "anonymousKeys": [
    "string"
  ],
  "args": {},
  "contractId": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
args|map|true|查询参数，接收业务性参数内容
anonymousKeys|array[string]|false|一组基于证件号码的匿踪查询的 key，若指定具体的数据，则意味着进行匿踪查询

> 返回结果

```json
{
  "code": "string",
  "data": [{}],
  "error": "string"
}
```

名称|类型|说明
---|---|----
data|array[map]|根据业务返回相应的数据

## 支持基于电话号码进行匿踪阶段的简单数据查询

```plaintext
[POST] /query/telephone
```

> 参数说明

```json
{
  "anonymousKeys": [
    "string"
  ],
  "args": {},
  "contractId": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
args|map|true|查询参数，接收业务性参数内容
anonymousKeys|array[string]|false|一组基于电话号码的匿踪查询的 key，若指定具体的数据，则意味着进行匿踪查询

> 返回结果

```json
{
  "code": "string",
  "data": [{}],
  "error": "string"
}
```

名称|类型|说明
---|---|----
data|array[map]|根据业务返回相应的数据

## 获取用户画像信息

```plaintext
[POST] /idmapping/portrait
```

> 参数说明

```json
{
  "cert": {
    "bizId": "string",
    "bizName": "string",
    "encryptType": "string",
    "protocolDigest": "string",
    "publicKey": "string"
  },
  "contractId": "string",
  "telephone": "string",
  "tradeMode": 0,
  "tradeQuantity": 0,
  "transactionId": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
contractId|string|true|合约地址
transactionId|string|false|交易订单 id
tradeMode|byte|true|交易模型：0，按时间计算；1：按次数计算。需要配合参数 tradeQuantity 使用
tradeQuantity|int|true|交易量，配合参数 tradeMode 使用。若 mode 的值为 0，则表示当前交易的有效天数；1，则表示当前交易的可用最大次数
userAgent|map|false|用户代理数据，非业务性参数应该使用当前字段传递
telephone|string|true|一个 32 位电话号码 MD5 值
cert|CertSupport|false|存证业务支持

> 返回结果

```json
{
  "code": "string",
  "data": [
    {
      "name": "string",
      "value": "string"
    }
  ],
  "error": "string"
}
```

名称|类型|说明
---|---|----
data|array[PortraitTag]|一组用户影像标签

> PortraitTag 结构

名称|类型|说明
---|---|----
name|string|标签名称
value|string|标签数据
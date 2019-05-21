
# 代理服务 API 文档

```plaintext
代理服务 API 文档
```

## 服务地址

* 测试环境 [https://preview.unitedata.link/ud-proxy](https://preview.unitedata.link/ud-proxy)
* 生产环境 [https://www.unitedata.link/ud-proxy](https://www.unitedata.link/ud-proxy)

## 返回值

> 返回值结构:

```json
{
  "code": "0",
  "data": object,
  "message": "Ok",
  "ok": true
}
```

名称|类型|说明
---|---|----
code|string|code=0 时标识请求业务成功；否则返回相应的错误代码，在 error 中能够获取具体的错误内容。
message|string|请求相应消息
data|object|返回数据正文
ok|boolean|请求处理状态

## 访问签名

### 获取token

```plaintext
token 地址：
    测试环境：https://preview.unitedata.link/wallet/wallet-proxy/ud-wallet/v1
    生产环境：https://www.unitedata.link/wallet/wallet-proxy/ud-wallet/v1

根据链上用户名称和密匙向指定的环境获取 token
```

### 签名

```java
首先准备参数，如：
{
  "method": "sum",
  "parameters": "[{\"valueType\":\"java.lang.Integer\",\"value\":0}]",
  "returnType": "java.lang.Integer",
  "service": "org.unitedata.proxy.server.domain.mock.MockRpcService",
  "sign": "string",
  "timestamp": 0,
  "token": "string"
}

从参数得到数据：
String[] arr = {
    "${method}",
    "${parameters}",
    "${returnType}",
    "${service}",
    "${timestamp}",
    "${token}"
};

将得到的数据按字母升序排列
String[] sortedArr = Arrars.sort(arr);

连接排序好的数据，得到明文数据
String plaintext = String.join("", sortedArr);

计算明文数据的 md5 值，得到最终的签名
String sign = md5(plaintext);
```

## RPC 接口

```plaintext
[POST] /api/rpc
```

> 参数说明

```json
{
  "method": "sum",
  "parameters": "[{\"valueType\":\"java.lang.Integer\",\"value\":0}]",
  "returnType": "java.lang.Integer",
  "service": "org.unitedata.proxy.server.domain.mock.MockRpcService",
  "sign": "string",
  "timestamp": 0,
  "token": "string"
}
```

名称|类型|必填|说明
---|---|-|----
service|string|true|RPC 接口名称
method|string|true|RPC 执行函数名称
parameters|array[Arg]|true|RPC 函数执行参数
returnType|string|true|RPC 函数返回值类型
token|string|true|安全访问令牌（[获取](#获取token)）
timestamp|long|true|当前请求时间戳
sign|string|true|当前请求数据签名（[获取](#签名)）

> Arg 结构

名称|类型|必填|说明
---|---|-|----
value|string|true|参数内容
valueType|string|true|参数类型名称

> 返回结果

```json
{
  "code": "0",
  "data": "string",
  "message": "Ok",
  "ok": true
}
```

名称|类型|说明
---|---|----
data|string|RPC 处理结果 json 对象

## 简单存证协议备案

```plaintext
[POST] /api/cert/registry/protocol
```

> 参数说明

```json
{
  "bizId": "string",
  "bizName": "string",
  "content": "string",
  "md5": "string",
  "registrant": "string",
  "registrySignature": "string",
  "sign": "string",
  "timestamp": 0,
  "token": "string"
}
```

名称|类型|必填|说明
---|---|-|----
bizId|string|true|业务 ID
bizName|string|true|业务名称
content|string|true|协议内容正文
md5|string|true|协议内容 MD5 值
registrant|string|true| 协议备案登记人账户
registrySignature|string|true|备案签名（[获取](simple-certification-signature.md#协议备案签名)）
token|string|true|安全访问令牌（[获取](#获取token)）
timestamp|long|true|当前请求时间戳
sign|string|true|当前请求数据签名（[获取](#签名)）

## 存证协议备案摘要计算公式

在进行存证之前，需要先进行[存证协议备案](#简单存证协议备案)。
在经过存证协议备案之后，需要计算得到存证协议备案摘要。详细公式如下：

```java
1，得到如下的存证协议内容
{
  "bizId": "string",
  "bizName": "string",
  "content": "string",
  "md5": "string",
  "registrant": "string",
  "registrySignature": "string",
  "sign": "string",
  "timestamp": 0,
  "token": "string"
}

2，从上文的备案协议内容中，获取协议摘要内容，得到如下数据：
String[] arr = {
  "${md5}",
  "${bizId}",
  "${bizName}",
  "${registrant}",
  "${timestamp}"
};

3，将获取得到的协议摘要内容连接，得到计算明文数据：
String plaintext = String.join("", arr);

4，计算明文的 md5，得到协议备案签名:
String protocolDigest = md5(plaintext);

```

## 简单存证

```plaintext
[POST] /api/cert/registry/inf
```

> 参数说明

```json
{
  "bizId": "string",
  "bizName": "string",
  "directAuthorizer": "string",
  "directSignature": "string",
  "indirectAuthorizer": "string",
  "indirectSignature": "string",
  "protocolDigest": "string",
  "sign": "string",
  "timestamp": 0,
  "token": "string",
  "userAgent": {}
}
```

名称|类型|必填|说明
---|---|-|----
bizId|string|true|业务 ID
bizName|string|true|业务名称
protocolDigest|string|true|已备案协议摘要（[获取](#存证协议备案摘要计算公式)）
directAuthorizer|string|true|直接授权人账户
directSignature|string|true|直接授权人签名（[获取](simple-certification-signature.md#直接授权签名)）
indirectAuthorizer|string|false|间接授权人账户
indirectSignature|string|false|间接授权人签名（[获取](simple-certification-signature.md#间接授权签名)）
userAgent|map|false|用户信息
token|string|true|安全访问令牌（[获取](#获取token)）
timestamp|long|true|当前请求时间戳
sign|string|true|当前请求数据签名（[获取](#签名)）
## 环境要求
* 系统中正确安装java8，并配置好JAVA_HOME环境变量。

## 数据准备
* 查询数据文件采用是csv格式。有两列数据，第一列是姓名，第二列是身份证号，逗号间隔，结尾换行。内容示例如下：

```
张三,1231231245125125
李四,1231231245125126
```

## 使用说明

1. 开启命令行，切换到本工具目录。
2. 执行启动命令 ```java -jar test-tool-for-consumer-core-1.9.0.jar -s PREVIEW -a [account] -p [private-key] FILE```。
3. 查询结束后，默认在当前目录生成```out.csv```，输出格式也是csv格式，对比输入文件增加第三列是否命中，true表示命中，error表示查询异常。


## 参数介绍

* 使用```java -jar test-tool-for-consumer-core-1.9.0.jar -h``` 查看工具参数介绍：
* 其中用户名```-a```和私钥```-p```为必传参数；```-s```选择环境，有```TEST,PREVIEW,PROD```可选；```-t```是启动查询的线程数。其余参数介绍见详情。

```
Usage: simple-test-tool [-hV] [--eos-api-host=<eosHost>]
                        [--message-service-host=<messageServiceHost>]
                        [--rpc-service-url=<rpcServiceUrl>]
                        [--token-service-host=<tokenServiceHost>] -a=<account>
                        [-d=<contractId>] [-o=<outFilePath>] -p=<privateKey>
                        [-s=<stage>] [-t=<threads>] FILE...
      FILE...               二要素文件地址
      --eos-api-host=<eosHost>
                            数链eosAPI节点地址
      --message-service-host=<messageServiceHost>
                            消息服务地址。
      --rpc-service-url=<rpcServiceUrl>
                            代理服务器地址
      --token-service-host=<tokenServiceHost>
                            获取用户登录token服务器地址
  -a, --account=<account>   需求方账号名
  -d, --data-contract=<contractId>
                            黑名单合约的地址
                              Default: ud.blacklist
  -h, --help                Show this help message and exit.
  -o, --output-file-path=<outFilePath>
                            输出结果文件
                              Default: out.csv
  -p, --private-key=<privateKey>
                            需求方账号对应私钥
  -s, --stage=<stage>       选择环境，有效的参数如下: TEST, PROD, PREVIEW
                              Default: TEST
  -t, --threads=<threads>   查询的线程数
                              Default: 1
  -V, --version             Print version information and exit.

```


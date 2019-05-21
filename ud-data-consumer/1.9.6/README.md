
# 1.9.6.FINAL-RELEASE

* [需求方服务](DEPLOY.md)
* [简单需求方 sdk 接入](SDK-DEPENDANCY-CORE.md)
* [第三方存证 sdk 接入](SDK-DEPENDANCY-CERTIFICATION.md)
* [“斑马” 服务 sdk 接入](SDK-DEPENDANCY-ZEBRA.md)
* [id-mapping 用户影像 sdk 接入](SDK-DEPENDANCY-IDMAPPING.md)

## 更新日志

``` plaintext
修复了已知的所有错误；
新增 id-mapping 用户影像业务场景支持；
新增简单存证业务场景支持；
调整项目结构；
其他...
```

## 项目结构

```struct
                        核心服务(consumer-core)---------------------------------+
                        /       |       \         \                            |
                       /        |        \          \                          |
                      /         |         \           \                        |
                     /          |          \            \                      |
                    /           |           \             \                    |
                   /            |            \              \                  |
                  /             |             \               \                |
                 /              |              \                \              |
                /               |               \                 \            |
 第三方存证(certification)   黑名单(zebar)   用户影像(id-mapping)  其他场景(...)    |
               |                |                |                             |
               |                |                |                             |
               |                |                |                             |
               +----------------+----------------+-----------需求方服务(consumer-server)

```

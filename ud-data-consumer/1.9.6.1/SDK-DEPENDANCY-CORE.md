
# 简单 SDK 接入文档

```plaintext
实现一种简单的需求方基础业务功能实现。
```

## 示例

> 下载 sdk 包

* [ud-data-consumer-core-1.9.6.1.jar](ud-data-consumer-core-1.9.6.1.jar.tar.gz?raw=true)

```java

<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-core</artifactId>
    <version>1.9.6.1</version>
</dependency>

// 单元测试
public class DataQueryClientTest {

    // 需求方链上账户名称
    private static final String ACCOUNT         = "";
    // 需求方链上账户密匙
    private static final String PRIVATE_KEY     = "";
    // 区块链环境：测试环境（test），生产环境（prod）
    private static final String ACTIVE_PROFILE  = "test";

    // 用户参数
    private Map<String, Object> parameters;

    @Before
    public void doInit(){
        parameters = new HashMap<>();
        parameters.put("name", "lufeng");
        parameters.put("mobile", "18738121039");
        parameters.put("idno", "41152419960527843x");
    }

    /**
     * 构建查询协议测试
     */
    @Test
    public void buildProtocolTest() {
        DataClient client = DataQueryClient.getClient();
        assert null != client;
        SimpleProtocol protocol = client.newProtocol(SimpleProtocol.class);
        assert null != protocol;
        client.dispose();
    }

    /**
     * {@link SimpleProtocol} 简单查询协议处理测试：
     * 支持规格合约的
     */
    @Test
    public void simpleProtocolTest() {
        String profile = ACTIVE_PROFILE;
        String account = ACCOUNT;
        String privateKey = PRIVATE_KEY;
        ConfigurableDataClientBuilder builder = DataQueryClient.getBuilder();
        DataClient client = builder.build(account, privateKey, profile);
        // 合约地址
        String contractId = "ddp4h35mpfq3";
        SafeSimpleProtocol protocol =
                (new SafeSimpleProtocol(client.newProtocol(SimpleProtocol.class)));
        // 设置匿踪
        protocol.setAnonymousKeysAtIdCard("41152419960527843x")
                .setTradeMode(TradeModel.TYPE_COUNT, 100);
        // 执行查询
        Map<String, Object>[] data = protocol.query(contractId, parameters);
        // 断言
        assert Arrays.stream(data).allMatch(Objects::nonNull);
        // 释放客户占用的系统资源。为了性能考虑，通常这应该在服务结束时调用，此处在测试完成之后，没有更多的操作
        client.dispose();
    }
}

```

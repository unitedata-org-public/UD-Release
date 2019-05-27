
# 第三方存证 SDK 接入文档

```plaintext
实现一种支持第三方存证的业务场景的一组业务功能。
```

## 示例

> 下载 sdk 包

* [ud-data-consumer-core-1.9.6.1.jar](ud-data-consumer-core-1.9.6.1.jar.tar.gz?raw=true)
* [ud-data-consumer-certification-1.9.6.1.jar](ud-data-consumer-certification-1.9.6.1.jar.tar.gz?raw=true)

```java

<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-core</artifactId>
    <version>1.9.6.1</version>
</dependency>
<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-certification</artifactId>
    <version>1.9.6.1</version>
</dependency>

// 单元测试
public class CertificationServerTest {

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
        parameters.put("imei", String.valueOf(DateUtils.unixNano()));
        parameters.put("idfa", String.valueOf(DateUtils.unixNano()));
        parameters.put("deviceId", String.valueOf(DateUtils.unixNano()));
        parameters.put("appId", String.valueOf(DateUtils.unixNano()));
    }

    @Test
    public void processTest() {
        // 合约地址
        String contractId = "ddk11skzagfu";
        CertificationServer server =
                CertificationServer.getBuilder()
                .setAccount(ACCOUNT)
                .setPrivateKey(PRIVATE_KEY)
                .setActiveProfile(ACTIVE_PROFILE)
                .setContract(contractId)
                .setTradeModel(TradeModel.TYPE_COUNT, 100)
                .build();
        // 第三方存证账户
        String producer = ACCOUNT;
        // 第三方存证认证
        Certification token = server.register(producer, parameters);
        assert null != token;
        assert token.getState() == CertificationState.STATE_ACTIVE.getValue();
        String tokenStr = token.getToken();
        assert StringUtils.hasText(tokenStr);

        // 第三方存证获取
        Certification acquired = server.getToken(tokenStr, producer, parameters);
        assert null != acquired;
        assert token.getState() == CertificationState.STATE_ACTIVE.getValue();

        // 移除第三方存证
        Certification cleaned = server.remove(tokenStr, producer, parameters);
        assert null != cleaned;
        assert token.getState() == CertificationState.STATE_INVALID.getValue();
    }
}
```
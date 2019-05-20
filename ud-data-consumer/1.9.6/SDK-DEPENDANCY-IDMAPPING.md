
# ID-Mapping 用户影像 SDK 接入文档

```plaintext
实现一种支持 id-mapping 用户影像的业务场景的一组业务功能。
```

## 示例

> 下载 sdk 包

* [ud-data-consumer-core-1.9.6.FINAL.jar](ud-data-consumer-core-1.9.6.FINAL.jar.tar.gz)
* [ud-data-consumer-idmapping-1.9.6.FINAL.jar](ud-data-consumer-idmapping-1.9.6.FINAL.jar.tar.gz)

```java

<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-core</artifactId>
    <version>1.9.6.FINAL</version>
</dependency>
<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-idmapping</artifactId>
    <version>1.9.6.FINAL</version>
</dependency>

// 单元测试
public class IdMappingServiceTest {

    // 需求方链上账户名称
    private static final String ACCOUNT         = "";
    // 需求方链上账户密匙
    private static final String PRIVATE_KEY     = "";
    // 区块链环境：测试环境（test），生产环境（prod）
    private static final String ACTIVE_PROFILE  = "test";

    @Test
    public void mainTest() {
        // 一个 32 位电话号码 MD5，例如：7445B8B804853B4115146D4329BF9E76
        final String tel = "";
        // 画像合约
        final String portraitContract = "";
        // mapping 合约
        final String mappingContract = "";
        // 指定具体的订单
        final String trxId = "";
        // 获取服务实例
        IdMappingService service =
                IdMappingService.getBuilder()
                .setAccount(ACCOUNT)
                .setPrivateKey(PRIVATE_KEY)
                .setActiveProfile(ACTIVE_PROFILE)
                .setPortraitContract(portraitContract)
                .setMappingContract(mappingContract)
                .setTradeModel(TradeModel.TYPE_COUNT, 100)
                .setTrxId(trxId)
                .build();
        // 获取画像
        PortraitTag[] tags = service.getPortrait(tel);
        // 测试断言
        assert null != tags;
    }
}
```
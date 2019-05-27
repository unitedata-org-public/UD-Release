
# “斑马” SDK 接入文档

```plaintext
实现一种支持 id-mapping 用户影像的业务场景的一组业务功能。
```

## 示例

> 下载 sdk 包

* [ud-data-consumer-core-1.9.6.1.jar](ud-data-consumer-core-1.9.6.1.jar.tar.gz?raw=true)
* [ud-data-consumer-zebra-1.9.6.1.jar](ud-data-consumer-zebra-1.9.6.1.jar.tar.gz?raw=true)

```java

<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-core</artifactId>
    <version>1.9.6.1</version>
</dependency>
<dependency>
    <groupId>org.unitedata</groupId>
    <artifactId>ud-data-consumer-zebra</artifactId>
    <version>1.9.6.1</version>
</dependency>

// 单元测试
public class ZebraServiceTest {

    // 需求方链上账户名称
    private static final String ACCOUNT         = "";
    // 需求方链上账户密匙
    private static final String PRIVATE_KEY     = "";
    // 区块链环境：测试环境（test），生产环境（prod）
    private static final String ACTIVE_PROFILE  = "test";

    /**
     * 斑马合约单元测试
     */
    @Test
    public void zebraTest() {
        // 合约
        final String contract = "ud.blacklist";
        // 订单
        final String trxId = "";
        // 证件号码
        final String id = "361712197812039061";
        // 证件名称
        final String name = "张三";
        ZebraService zebraService =
                ZebraService.createBuilder()
                .setAccount(ACCOUNT) // 账户
                .setPrivateKey(PRIVATE_KEY) // 密匙
                .setActiveProfile(ACTIVE_PROFILE) // 配置
                .setContract(contract) // 合约
                .setRandomFactor(DateUtils.unixMill()) // 随机因子
                .setDetailRequired(true) // 详细信息查询确认
                .setMayReport(false) // 上报需求状态
                .setMayCheckProof(false) // 凭证检查状态
                .setTrxId(trxId) // 订单
                .setAutoCreateTrx(true) // 订单创建确认
                .build();
        ZebraMatchResult result = zebraService.match(id, name);
        System.out.println("[Data] ->> "+ JsonUtils.toStringIfThrow(result));
        assert null != result;
        if(zebraService.isDetailRequired() && result.isHasDetail()){
            assert null != result.getDetails();
            assert !result.isHit() || 0 < result.getDetails().length;
        }
    }
}
```
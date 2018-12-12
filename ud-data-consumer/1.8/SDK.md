
# SDK 接入说明

## 示例

```java
/**
 * 第三方存证服务单元测试
 *
 * @author baimao
 * @create 2018/11/16
 */
public class CertificationServiceTest {

    /**
     * 存证参数实现
     *
     * @author baimao
     */
    private final class Parameter implements CertificationParameterValue{

        // 参数
        private final Map.Entry<String, Object> entry;

        // .ctor
        Parameter(Map.Entry<String, Object> entry) {
            this.entry = entry;
        }

        @Override
        public String getName() {

            return entry.getKey();
        }

        @Override
        public Object getValue() {

            return entry.getValue();
        }
    }

    private static final String contractExtraServiceUrl = "https://preview.unitedata.link/ud-market";
    private static final String contractUrl = "https://preview.unitedata.link/v1";

    private static final String account = "jwheqwieibjb";
    private static final String privateKey = "5JbzYNrNv55Lgzy9Ue8ZGzkeVWWUdqo4EzX6axfGibhiVjb3Xfc";
    private static final String contractId = "dsn4eixbdafb";

    private static final String producer = "account12345";

    private Map<String, Object> parameters;

    @Before
    public void initParameter(){
        parameters = new HashMap<>(16);
        parameters.put("imei", String.valueOf(DateUtils.unixNano()));
        parameters.put("idfa", String.valueOf(DateUtils.unixNano()));
        parameters.put("deviceId", String.valueOf(DateUtils.unixNano()));
        parameters.put("appId", String.valueOf(DateUtils.unixNano()));
    }

    @Test
    public void certificateServiceTest(){
        CertificationOptions options =
                CertificationService.getOptions(account, privateKey)
                        .setContract(contractUrl, contractId, TradeType.typeCount, 100)
                        .setParameterServiceUrl(contractExtraServiceUrl);
        CertificationParameterValue[] values = parameters.entrySet().stream()
                .map(Parameter::new)
                .toArray(Parameter[]::new);
        Certification certification = options.authorize(producer, values);
        assert Objects.nonNull(certification);

        final ReentrantLock lock = new ReentrantLock(false);
        final Condition exit = lock.newCondition();
        final List<Long> col = new LinkedList<>();
        final int size = 10;
        for (int i = 1; i <= size; i++) {
            final int offset = i;
            Executors.newSingleThreadExecutor().execute(() -> {
                System.out.println(offset);
                StopWatch watch = StopWatch.createStarted();
                String token = null;
                try {
                    Map<String, Object> parameters = new HashMap<>(16);
                    parameters.put("imei", String.valueOf(DateUtils.unixNano()));
                    parameters.put("idfa", String.valueOf(DateUtils.unixNano()));
                    parameters.put("deviceId", String.valueOf(DateUtils.unixNano()));
                    parameters.put("appId", String.valueOf(DateUtils.unixNano()));
                    CertificationParameterValue[] arr = parameters.entrySet().stream()
                            .map(Parameter::new)
                            .toArray(Parameter[]::new);
                    Certification cert = options.authorize(producer, arr);
                    token = cert.getToken();
//                    assert options.verify(producer, certification.getToken(), values);
//                    assert options.verify(producer, null, values);
//                    options.clean(producer, certification.getToken(), values);
                }
                catch (Exception cause){
                    cause.printStackTrace();
                }
                finally {
                    watch.stop();
                }

                long sec = watch.getTime(TimeUnit.MILLISECONDS);
                System.out.println("[time] [watch] ["+ token +"] ["+ sec +"]");

                lock.lock();
                try{
                    col.add(sec);
                    if(size == col.size()){
                        System.out.println("[time] [watch] [unlock]");
                        exit.signal();
                    }
                }
                finally {
                    lock.unlock();
                }
            });
        }

        while (size > col.size()){
            lock.lock();
            try{
                exit.awaitUninterruptibly();
            }
            finally {
                lock.unlock();
            }
        }

        long sum = 0;
        for (Long aLong : col) {
            sum += aLong;
        }
        System.out.println();
        System.out.println("[time] [avg] "+ sum / col.size());
        System.out.println("[time] [min] "+ col.stream().min(Comparator.comparing(a -> a)).orElse(0L));
        System.out.println("[time] [max] "+ col.stream().max(Comparator.comparing(a -> a)).orElse(0L));
    }
}
```

## 配置 API

```java

/**
     * 设置当前上下文消息服务 DNS 地址
     * @param url DNS 地址
     * @return 返回 {@code this} 实例
     */
    CertificationOptions setMessageServiceUrl(String url);

    /**
     * 设置当前上下文访问令牌服务 DNS 地址
     * @param url DNS 地址
     * @return 返回 {@code this} 实例
     */
    CertificationOptions setTokenServiceUrl(String url);

    /**
     * 设置当前上下文参数服务 DNS 地址
     * @param url DNS 地址
     * @return 返回 {@code this} 实例
     */
    CertificationOptions setParameterServiceUrl(String url);

    /**
     * 设置当前上下文合约内容
     * @param contractId 合约 ID
     * @param tradeType 交易模式 {@link TradeType}
     * @param transactionQuantity 交易数量
     * @return 返回 {@code this} 实例
     */
    CertificationOptions setContract(
            String contractUrl,
            String contractId, byte tradeType, int transactionQuantity);

    /**
     * 发起第三方认证处理
     * @param producerAccount 提供方账号
     * @param parameters 一组有效的认证参数
     * @return 返回 {@link Certification} 实例对象
     */
    Certification authorize(
            String producerAccount, CertificationParameterValue... parameters);

    /**
     * 清楚指定的第三方认证信息
     * @param producerAccount 提供方账号
     * @param token 第三方存证 token
     * @param parameters 一组有效的认证参数
     */
    void clean(
            String producerAccount,
            String token, CertificationParameterValue... parameters);

    /**
     * 确认指定的第三方认证信息
     * @param producerAccount 提供方账号
     * @param token 第三方存证 token
     * @param parameters 一组有效的认证参数
     * @return 若指定的第三方存证有效，返回 {@code true}；否则，返回 {@code false}
     */
    boolean verify(
            String producerAccount,
            String token, CertificationParameterValue... parameters);

```
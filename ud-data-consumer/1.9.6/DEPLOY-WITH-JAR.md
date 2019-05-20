
# 数据需求方-数据服务 API 部署文档

```plaintext
版本：1.9.6.FINAL
```

## 部署

1. 自行搭建服务器
2. 安装 jdk，版本 1.8 +
3. 安装 redis 服务
4. 下载数据服务 jar 包 ([ud-data-consumer-server-1.9.6.FINAL.jar.tar.gz](ud-data-consumer-server-1.9.6.FINAL.jar.tar.gz?raw=true))
5. 解压包文件到指定的路径，并配置参数，具体配置请查看数据服务配置
6. 使用 jdk 运行下载的 jar 包
7. 打开浏览器，输入地址 http://{域名}/swagger-ui.html 可以看到实时 API 文档

## 运行

项目使用 spring boot 框架，并打包成 jar。因此使用以下命令运行：

```cmd
测试环境：java -jar -Dspring.profiles.active=test ud-data-consumer-server-1.9.6.FINAL.jar

生产环境：java -jar -Dspring.profiles.active=prod ud-data-consumer-server-1.9.6.FINAL.jar
```

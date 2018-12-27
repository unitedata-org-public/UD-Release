## 身份Hash生成及逾期信息生成说明
#### 生成身份Hash生成

````
     /**
       * 获取二要素Hash
       * @param name 用户姓名
       * @param idno 用户身份证号
       * @return 用户身份hash值
       * @throws Exception
       */
      public static String twoHash(String name,String idno) throws Exception{
            String nameLowerCase = name.toLowerCase();
            String idnoLowerCase = idno.toLowerCase();
            String[] twoArray = {nameLowerCase,idnoLowerCase};
            Arrays.sort(twoArray);
            String two = String.join("",twoArray);
            return DigestUtils.md5(two);

      }
````

#### 逾期信息生成说明

1. 逾期类型枚举：
	* long:长（M3+）
	* medium:中(M2)
	* short:短(M1)
2. 逾期金额枚举：
	* big:大(3000+)
	* medium:中(2000-3000)
	* small:小(<1000)
3. 逾期发生时间枚举：
	* recent：近期(半年以内)
	* medium:中期（半年-一年）
	* long_term:长期（一年以上） 

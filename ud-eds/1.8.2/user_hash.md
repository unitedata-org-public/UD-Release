## 身份Hash生成代码
#### 以下代码用来生成身份Hash

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

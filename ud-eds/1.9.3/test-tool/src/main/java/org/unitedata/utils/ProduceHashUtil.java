package org.unitedata.utils;

import org.bitcoinj.core.Sha256Hash;
import org.unitedata.eos.crypto.ECKey;
import org.unitedata.eos.crypto.EosSignatureProcessor;
import org.unitedata.eos.crypto.KeyFormatTransformer;

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.UUID;

/**
 * Created by sry-cpu on 2018/11/28.
 */
public class ProduceHashUtil {

      /**
       * 获取基础数据Hash
       * @param name
       * @param idno
       * @return
       * @throws Exception
       */
      public static String baseHash (String name,String idno,String overdueData) throws Exception{
            String nameLowerCase = name.toLowerCase();
            String idnoLowerCase = idno.toLowerCase();
            String overdueDataLowerCase = overdueData.toLowerCase();
            String[] baseArray = {nameLowerCase,idnoLowerCase,overdueDataLowerCase};
            Arrays.sort(baseArray);
            String base = String.join("",baseArray);
            return DigestUtils.md5(base);
      }

      /**
       * 获取二要素Hash
       * @param name
       * @param idno
       * @return
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

      /**
       * 随机码Hash
       * @param hash
       * @param randomCode
       * @return
       * @throws Exception
       */
      public static String randomHash(String hash,String randomCode) throws Exception{
            String[] rehashArray = {hash,randomCode};
            Arrays.sort(rehashArray);
            String rehash = String.join("",rehashArray);
            return DigestUtils.md5(rehash);

      }

      /**
       * 获取私有数据Hash
       * @param twoHash
       * @param overdueData
       * @param timeStamp
       * @param randomCode
       * @return
       * @throws Exception
       */
      public static String privacyHash(String twoHash,
                                       String overdueData,
                                       String timeStamp,
                                       String randomCode) throws Exception{
            String[] privacyArray = {twoHash,overdueData,timeStamp,randomCode};
            Arrays.sort(privacyArray);
            String privacy = String.join("",privacyArray);
            return DigestUtils.md5(privacy);
      }

      /**
       * 私钥签名
       * @param privacyHash
       * @return
       */
      public static String getSign(String privacyHash,String privateKey){
            byte[] bytes = privacyHash.getBytes(Charset.forName("UTF-8"));
            ECKey key = new KeyFormatTransformer().fromWifToPrivateKey(privateKey);
            return  new EosSignatureProcessor().signHash(Sha256Hash.create(bytes),key);
      }

      /**
       * 混淆md5码
       * @return
       * @throws Exception
       */
      public static String getMockMd5() throws Exception{
            String data = UUID.randomUUID().toString();
            return DigestUtils.md5(data);
      }
}

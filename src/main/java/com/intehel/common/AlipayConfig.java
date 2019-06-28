package com.intehel.common;
import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2019061265533124";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key ="MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCCHe9RAdFHIhF+kLa28lBJEJfPOyuvOR7ySfZO6ePdc9dhfQYRKdwFrRvUpezCEFpqj/t21Gh93dDFbWwm7YQe+FFmXMRIPVi0pLqq3mBhV7vooudUAzJxnLeEloU3sDcPXmjM2uTAnZJUCSXG0ZiQure5RLcM3zSkIOMy+NIG0BGMS44CgcEidWblXbuv67N5BdUjV6co8WnvmOX0E2HMVRsy7oY4FoPeO/MVzcqMpYpI0+GQfbB9FasdoYsKRILMR8q/P4tNoQDUByB5Zw6OSMTytcVMT7rX/pnkvh9Vi2rvUiW9eu2LRiLvk80GxG2jYa1O/eHCq/3QchZhXEEpAgMBAAECggEAIdTGtLlUQLqK8e2OlGLMnTLDRg6MfTLM6RJyCHKn3JySE7b+LNhFbPRlmBTMSmkWGT72kx8HTDKwZaTdygFXqPXHtGXKYz4QImfyYRsQ1D6LjSFOJHnwU7n7vW2llaUrq8NQXHNNpwdRVKhMOjWlBXyG6JUFQ0OF3GbwrAAmG777SqqU3yFzC7hrpgb/lsPhYCBL50Yi6Yc82eWyatSdr1Oua48FK52W0XhB5LBs26FhtPxTCc/blGH7cYQsd59NS9ImNGTUYa5IKeBc3trsqFgm/RtImCiqX+scKGneEjY80chRjOWxRqE9flsXQSmwHynxRP6pt4vPgUnvp9zQAQKBgQDwUsD5lQZ2Mx+K2zNC0T5Ocr/Dmbs/Z4h8q0bYmqa5i8WM+dUJMfcIjI7wp/PVkGxWVnLOwHy8AK2VrWjzh6sbxfNkxwsFfz2jsCviTcKvrIT8fIpXNiPufre9KcIv+4hE0Qa6W3XSyOsZT9WIr9Azc4e38QunZeTYs30ncFfPiQKBgQCKms4h3OvBe4rfMBsA9L1goza+foXlt6Rxsl/PFYhpsf9dMqXbVOy51LHEN7tn8axiANTQYG0LBH7sCoxF2HoUaKbRFCnQdxd/ZCYjgCMdsOVyFndNlY0cvt+PRsrNCWv3mvjrqkOhLzU8lvXzJiTDjHw0mgqGd9t4kSgegkHcoQKBgQCntpjFlKK1ymew19imQLBivuHk91wdm3s8xarjbsn7ovdyssdha2UiqjT27b7Uw71XY20rrFlgOnjpg+NCUOOwtixtoBqo82to2IFHpUzAnH0SVzeUNUxOHFDNyl6ibb9jhxxS4ZEQUPcA6x3yDgAWaAHG9IlVgV57fIdTBqvBQQKBgC+dcsbrUApN2K1Hp18ytIQoTbwvVuxNpC5y6rsHWK+GuIVZyuSITjKgwNj5lGXm/iNEydcz6QHp73hDP2EXNwkf0n7tAFhfMTFQRFHZyTZ/+LKyyRVcFPgVElP0K+M4I2ESWgULnuQWhaFk8uUu615KOrkPWiJLtpe6th+U++9BAoGALsHlmoKWeBWhuoqg7QI2vVcvJmaO36eSkkYHAwmPiz2Dp6D/81LHsGtb9axRt55iJIceAi+BI0aqXGVIN99zNIIaZL2UaNrlhEwzzBXq+H0Spv7x/waO/xOEdpgZj3WrGDdjbp8sxBqI2o42mQ+OxY83tPfk0t5LFywjLME7PZo=";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key ="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAovjc5mZij+9oxwcvksWFEGJGXyYQVcBH6oGW7mSC9UmeJpAP+lej9PpXYD1EOv6/iGh/VwqmvEDKRTaGZ4vIqTWTOflb+TuDVx9pFrgXafk5jSvTYAuVQxT0/PsLumnwesinqCjPxxSfXDA0ZNi9nH5iESXYUEgSQQqEQ+ACo7+T3P7wjHF/2mkfWClWL+z2FZKmSSpkJgb0ffTBLO6Ow7fe35HpAVXXvIfjoh7gE74v0QDphL8jA9Oc4OrdXdRitHjFJCPQADBKxUNoWY9fgk/zHMXFxUQG7s4ysLofLiqsx0e4XSMpSBA2R0Eb9Q9mcRrhKgQJmxHc9pViErwJdQIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipay.com/gateway.do";

    // 支付宝网关
    public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}


package com.intehel.common.alipay;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class AlipayConfig {
	// 商户appid
	public static String APPID = "2019061265533124";
	// 私钥 pkcs8格式的
	public static String RSA_PRIVATE_KEY = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCCHe9RAdFHIhF+kLa28lBJEJfPOyuvOR7ySfZO6ePdc9dhfQYRKdwFrRvUpezCEFpqj/t21Gh93dDFbWwm7YQe+FFmXMRIPVi0pLqq3mBhV7vooudUAzJxnLeEloU3sDcPXmjM2uTAnZJUCSXG0ZiQure5RLcM3zSkIOMy+NIG0BGMS44CgcEidWblXbuv67N5BdUjV6co8WnvmOX0E2HMVRsy7oY4FoPeO/MVzcqMpYpI0+GQfbB9FasdoYsKRILMR8q/P4tNoQDUByB5Zw6OSMTytcVMT7rX/pnkvh9Vi2rvUiW9eu2LRiLvk80GxG2jYa1O/eHCq/3QchZhXEEpAgMBAAECggEAIdTGtLlUQLqK8e2OlGLMnTLDRg6MfTLM6RJyCHKn3JySE7b+LNhFbPRlmBTMSmkWGT72kx8HTDKwZaTdygFXqPXHtGXKYz4QImfyYRsQ1D6LjSFOJHnwU7n7vW2llaUrq8NQXHNNpwdRVKhMOjWlBXyG6JUFQ0OF3GbwrAAmG777SqqU3yFzC7hrpgb/lsPhYCBL50Yi6Yc82eWyatSdr1Oua48FK52W0XhB5LBs26FhtPxTCc/blGH7cYQsd59NS9ImNGTUYa5IKeBc3trsqFgm/RtImCiqX+scKGneEjY80chRjOWxRqE9flsXQSmwHynxRP6pt4vPgUnvp9zQAQKBgQDwUsD5lQZ2Mx+K2zNC0T5Ocr/Dmbs/Z4h8q0bYmqa5i8WM+dUJMfcIjI7wp/PVkGxWVnLOwHy8AK2VrWjzh6sbxfNkxwsFfz2jsCviTcKvrIT8fIpXNiPufre9KcIv+4hE0Qa6W3XSyOsZT9WIr9Azc4e38QunZeTYs30ncFfPiQKBgQCKms4h3OvBe4rfMBsA9L1goza+foXlt6Rxsl/PFYhpsf9dMqXbVOy51LHEN7tn8axiANTQYG0LBH7sCoxF2HoUaKbRFCnQdxd/ZCYjgCMdsOVyFndNlY0cvt+PRsrNCWv3mvjrqkOhLzU8lvXzJiTDjHw0mgqGd9t4kSgegkHcoQKBgQCntpjFlKK1ymew19imQLBivuHk91wdm3s8xarjbsn7ovdyssdha2UiqjT27b7Uw71XY20rrFlgOnjpg+NCUOOwtixtoBqo82to2IFHpUzAnH0SVzeUNUxOHFDNyl6ibb9jhxxS4ZEQUPcA6x3yDgAWaAHG9IlVgV57fIdTBqvBQQKBgC+dcsbrUApN2K1Hp18ytIQoTbwvVuxNpC5y6rsHWK+GuIVZyuSITjKgwNj5lGXm/iNEydcz6QHp73hDP2EXNwkf0n7tAFhfMTFQRFHZyTZ/+LKyyRVcFPgVElP0K+M4I2ESWgULnuQWhaFk8uUu615KOrkPWiJLtpe6th+U++9BAoGALsHlmoKWeBWhuoqg7QI2vVcvJmaO36eSkkYHAwmPiz2Dp6D/81LHsGtb9axRt55iJIceAi+BI0aqXGVIN99zNIIaZL2UaNrlhEwzzBXq+H0Spv7x/waO/xOEdpgZj3WrGDdjbp8sxBqI2o42mQ+OxY83tPfk0t5LFywjLME7PZo=";
	// 服务器异步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "";
	// 页面跳转同步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问 商户可以自定义同步跳转地址
	public static String return_url = "";
	// 请求网关地址

	public static String URL = "https://openapi.alipay.com/gateway.do";
	// 编码
	public static String CHARSET = "utf-8";
	// 返回格式
	public static String FORMAT = "json";
	// 支付宝公钥
	public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgh3vUQHRRyIRfpC2tvJQSRCXzzsrrzke8kn2Tunj3XPXYX0GESncBa0b1KXswhBaao/7dtRofd3QxW1sJu2EHvhRZlzESD1YtKS6qt5gYVe76KLnVAMycZy3hJaFN7A3D15ozNrkwJ2SVAklxtGYkLq3uUS3DN80pCDjMvjSBtARjEuOAoHBInVm5V27r+uzeQXVI1enKPFp75jl9BNhzFUbMu6GOBaD3jvzFc3KjKWKSNPhkH2wfRWrHaGLCkSCzEfKvz+LTaEA1AcgeWcOjkjE8rXFTE+61/6Z5L4fVYtq71IlvXrti0Yi75PNBsRto2GtTv3hwqv90HIWYVxBKQIDAQAB";
	// 日志记录目录
	public static String log_path = "/log";
	// RSA2
	public static String SIGNTYPE = "RSA2";

	// 将request中的参数转换成Map
	public Map<String, String> convertRequestParamsToMap(HttpServletRequest request) {
		Map<String, String> retMap = new HashMap<String, String>();
		Set<Map.Entry<String, String[]>> entrySet = request.getParameterMap().entrySet();
		for (Map.Entry<String, String[]> entry : entrySet) {
			String name = entry.getKey();
			String[] values = entry.getValue();
			int valLen = values.length;
			if (valLen == 1) {
				retMap.put(name, values[0]);
			} else if (valLen > 1) {
				StringBuilder sb = new StringBuilder();
				for (String val : values) {
					sb.append(",").append(val);
				}
				retMap.put(name, sb.toString().substring(1));
			} else {
				retMap.put(name, "");
			}
		}
		return retMap;
	}
}

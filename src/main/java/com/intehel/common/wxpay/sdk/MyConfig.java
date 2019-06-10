package com.intehel.common.wxpay.sdk;


import java.io.*;

public class MyConfig extends WXPayConfig {

    private byte[] certData;

    public MyConfig() throws Exception {
        String certPath = "/path/to/apiclient_cert.p12";
        File file = new File(certPath);
        InputStream certStream = new FileInputStream(file);
        this.certData = new byte[(int) file.length()];
        certStream.read(this.certData);
        certStream.close();
    }
    @Override
    public String getAppID() {
        return "wx8565264272b020b6";
    }
    @Override
    public String getMchID() {
        return "1532622521";
    }
    @Override
    public String getKey() {
        return "192006250b4c09247ec02edce69f6a2a";
    }
    @Override
    public InputStream getCertStream() {
        ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
        return certBis;
    }
    @Override
    public int getHttpConnectTimeoutMs() {
        return 8000;
    }
    @Override
    public int getHttpReadTimeoutMs() {
        return 10000;
    }

    @Override
    IWXPayDomain getWXPayDomain() {
        return null;
    }


}

package com.intehel.common.wxpay.sdk;


import java.io.*;

public class MyConfig extends WXPayConfig {

    private byte[] certData;

    public MyConfig() throws Exception {
        String certPath = "D:/apiclient_cert.p12";
        File file = new File(certPath);
        InputStream certStream = new FileInputStream(file);
        this.certData = new byte[(int) file.length()];
        certStream.read(this.certData);
        certStream.close();
    }
    /*@Override
    public String getAppID() {
        return "wx8397f8696b538317";
    }
    @Override
    public String getMchID() {
        return "1473426802";
    }
    @Override
    public String getKey() {
        return "T6m9iK73b0kn9g5v426MKfHQH7X8rKwb";
    }*/
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
        return "kle3YoeVR4XI9Z15EphtdUKYcJ0TEadq";
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
        IWXPayDomain iwxPayDomain = new IWXPayDomain() {

            public void report(String domain, long elapsedTimeMillis, Exception ex) {

            }

            public DomainInfo getDomain(WXPayConfig config) {
                return new IWXPayDomain.DomainInfo(WXPayConstants.DOMAIN_API, true);
            }
        };
        return iwxPayDomain;


    }
}


package com.lh.activemq.factory;

import lombok.Data;

@Data
public class AMQConfigBean {
    private String brokerURL;
    private String userName;
    private String password;
    private int sessionCacheSize;

    public AMQConfigBean() {

    }

    public AMQConfigBean(String brokerURL, String userName, String password, int sessionCacheSize) {
        this.brokerURL = brokerURL;
        this.userName = userName;
        this.password = password;
        this.sessionCacheSize = sessionCacheSize;
    }
}

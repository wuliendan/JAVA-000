package com.lh.activemq.factory;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.springframework.jms.connection.CachingConnectionFactory;

public class ConnectionFactory {

    private static final String URL = "tcp://127.0.0.1:61616";
    private static final String USERNAME = null;
    private static final String PASSWORD = null;
    private static final int SESSION_CACHE_SIZE = 20;
    private javax.jms.ConnectionFactory factory;

    public static synchronized javax.jms.ConnectionFactory getInstance() {
        if (SingletonHolder.INSTANCE.factory == null) {
            SingletonHolder.INSTANCE.build();
        }
        return SingletonHolder.INSTANCE.factory;
    }

    private void build() {
        AMQConfigBean bean = loadConfigure();
        this.factory = buildConnectionFactory(bean);
    }

    private javax.jms.ConnectionFactory buildConnectionFactory(AMQConfigBean bean) {
        javax.jms.ConnectionFactory targetFactory = new ActiveMQConnectionFactory(bean.getUserName(), bean.getPassword(), bean.getBrokerURL());

        CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
        connectionFactory.setTargetConnectionFactory(targetFactory);
        connectionFactory.setSessionCacheSize(bean.getSessionCacheSize());

        return connectionFactory;
    }

    private AMQConfigBean loadConfigure() {
        if (URL != null) {
            try {
                return new AMQConfigBean(URL, USERNAME, PASSWORD, SESSION_CACHE_SIZE);
            } catch (Exception e) {
                throw new IllegalStateException("Load amq config error!");
            }
        }
        throw new IllegalStateException("Load amq config error!");
    }

    private static class SingletonHolder {
        static ConnectionFactory INSTANCE = new ConnectionFactory();
    }
}

package com.lh.activemq.listener;

import com.lh.activemq.mq.MQ;
import org.springframework.stereotype.Repository;

/**
 * 项目启动即 开启
 * 通过 spring 依赖加载 Lister 订阅topic/send
 */
@Repository
public class Lister {

    public Lister() {
        JMSListener.startJmsTopicListener("topic/send", new MQ());
    }
}

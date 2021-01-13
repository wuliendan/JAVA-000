package com.lh.activemq.template;

import com.lh.activemq.factory.ConnectionFactory;
import org.springframework.jms.core.JmsTemplate;

public class JmsTemplateFactory {

    private final javax.jms.ConnectionFactory factory;
    private JmsTemplate topicJmsTemplate;
    private JmsTemplate queueJmsTemplate;

    public static JmsTemplateFactory getInstance() {
        return SingletonHolder.INSTANCE;
    }

    public JmsTemplateFactory() {
        this.factory = ConnectionFactory.getInstance();
    }

    public synchronized JmsTemplate getTopicJmsTemplate() {
        if (this.topicJmsTemplate == null) {
            this.topicJmsTemplate = createTemplate(this.factory, false);
        }
        return this.topicJmsTemplate;
    }

    public synchronized JmsTemplate getQueueJmsTemplate() {
        if (this.queueJmsTemplate == null) {
            this.queueJmsTemplate = createTemplate(this.factory, false);
        }
        return this.queueJmsTemplate;
    }

    private JmsTemplate createTemplate(javax.jms.ConnectionFactory factory, boolean pubSubDomain) {
        JmsTemplate template = new JmsTemplate(factory);
        template.setPubSubDomain(pubSubDomain);
        return template;
    }

    private static class SingletonHolder {
        static JmsTemplateFactory INSTANCE = new JmsTemplateFactory();
    }
}

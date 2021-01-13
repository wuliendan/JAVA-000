package com.lh.activemq.listener;

import com.lh.activemq.factory.ConnectionFactory;
import lombok.extern.slf4j.Slf4j;
import org.apache.activemq.command.ActiveMQQueue;
import org.apache.activemq.command.ActiveMQTopic;
import org.springframework.jms.listener.SimpleMessageListenerContainer;

import javax.jms.Destination;
import javax.jms.MessageListener;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
public class JMSListener {

    private static final Map<String, Destination> MQ_DESTS = new ConcurrentHashMap<>();

    public static synchronized void startJmsQueueListener(String queueName, MessageListener listener) {
        startJmsQueueListener(queueName, null, listener);
    }

    /**
     * 开启一个 点对点的 消息队列监听 的消费者
     *
     * @param queueName 队列名称
     * @param listener 订阅者的名字
     * @param listener 监听
     */
    public static synchronized void startJmsQueueListener(String queueName, String subName, MessageListener listener) {
        Destination destination = MQ_DESTS.get("QUEUE_" + queueName);
        if (destination == null) {
            ActiveMQQueue mqQueue = new ActiveMQQueue(queueName);
            startJmsListener(mqQueue, subName, listener);
            MQ_DESTS.put("QUEUE_" + queueName, mqQueue);
        } else {
            log.warn(queueName + " already started");
        }
    }

    public static synchronized void startJmsTopicListener(String topicName, MessageListener listener) {
        startJmsTopicListener(topicName, null, listener);
    }

    /**
     * 开始 消息监听器 消费者
     *
     * @param topicName 目的地
     * @param subName 持久订阅的名字
     * @param listener 消息监听器
     */
    public static synchronized void startJmsTopicListener(String topicName, String subName, MessageListener listener) {
        ActiveMQTopic mqTopic = new ActiveMQTopic(topicName);
        startJmsListener(mqTopic, subName, listener);
        MQ_DESTS.put("QUEUE_" + topicName, mqTopic);
    }


    private static void startJmsListener(Destination destination, String subName, MessageListener listener) {
        javax.jms.ConnectionFactory factory = ConnectionFactory.getInstance();

        SimpleMessageListenerContainer listenerContainer = new SimpleMessageListenerContainer();
        listenerContainer.setConnectionFactory(factory);
        listenerContainer.setDestination(destination);
        listenerContainer.setMessageListener(listener);
        if (subName != null && subName != "") {
            listenerContainer.setDurableSubscriptionName(subName);
        }

        listenerContainer.start();
    }
}

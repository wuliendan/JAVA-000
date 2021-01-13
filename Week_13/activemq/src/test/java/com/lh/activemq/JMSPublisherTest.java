package com.lh.activemq;

import com.lh.activemq.listener.JMSListener;
import com.lh.activemq.publisher.JMSPublisher;
import org.junit.Test;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;
import java.io.IOException;

public class JMSPublisherTest {

    public JMSPublisherTest() {
    }

    @Test
    public void testSendMessageToQueue() throws InterruptedException {
        for (int i = 0; i < 3; i++) {
            /**
             * 生产者 发布 消息到 queue/queue_b 的队列中
             */
            JMSPublisher.sendQueueMessage("queue/queue_b", String.valueOf(i * 1111));
        }
    }

//    @Test
    public void testSendMessageToTopic() {
        for (int i = 0; i < 3; i++) {
            /**
             * 生产者 发布消息 到 topic/send 的 Topic 主题中
             */
            JMSPublisher.sendTopicMessage("topic/send", String.valueOf(i * 1111));
        }
    }

//    @Test
    public void receiverTopic() {
        /**
         * 消费者 订阅主题 topic/sned 是否有消息发布，有则打印出来（通过 onMessage 监听）
         */
        JMSListener.startJmsTopicListener("topic/send", new MessageListener() {
            @Override
            public void onMessage(Message message) {
                if (message instanceof TextMessage) {
                    TextMessage msg = (TextMessage) message;
                    try {
                        System.out.println("收到一个 JMS 消息..." + msg.getText());
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            }
        });

        try {
            System.in.read();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void receiverQueue() {
        /**
         * 消费者 订阅队列 queue/queue_b 是否有消息发布
         */
        JMSListener.startJmsQueueListener("queue/queue_b", new MessageListener() {
            @Override
            public void onMessage(Message message) {
                if (message instanceof TextMessage) {
                    TextMessage msg = (TextMessage) message;
                    try {
                        System.out.println("收到一个 JMS 消息..." + msg.getText());
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            }
        });

        try {
            System.in.read();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

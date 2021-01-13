package com.lh.activemq.mq;

import org.apache.activemq.memory.list.MessageList;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

/**
 * 通过 实现 MessageListener 的 onMessage 来监听消息
 * 接受、处理消息
 */
public class MQ implements MessageListener {
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
}

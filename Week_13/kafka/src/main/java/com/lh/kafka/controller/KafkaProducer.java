package com.lh.kafka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KafkaProducer {

    @Autowired
    private KafkaTemplate template;

    @RequestMapping("/sendMessage")
    public String sendMsg(String topic, String message) {
        template.send(topic, message);
        return "SUCCESS";
    }
}

//
//  SGMQTTSubscribe.m
//  SGMQTT
//
//  Created by sungrow on 2020/4/9.
//

#import "SGMQTTSubscribe.h"

@implementation SGMQTTSubscribe

- (instancetype)initWithTopic:(NSString *)topic qos:(MQTTQosLevel)qos handler:(SGMQTTReceiveDataHandler)handler {
    if (self = [super init]) {
        self.topic = topic;
        self.qos = qos;
        self.handler = handler;
    }
    return self;
}

- (NSDictionary<NSString *, NSNumber *> *)subscription {
    return @{self.topic: [NSNumber numberWithInt:self.qos]};
}

@end

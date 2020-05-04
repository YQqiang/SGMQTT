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

- (BOOL)containsOtherTopic:(NSString *)other {
    return [self.class topic:self.topic containsOther:other];
}

+ (NSArray <NSString *>*)topics:(NSString *)topic {
    return [topic componentsSeparatedByString:@"/"];
}

+ (BOOL)topic:(NSString *)topic containsOther:(NSString *)other {
    NSArray <NSString *>*curComponents = [self topics:topic];
    NSArray <NSString *>*otherComponents = [self topics:other];
    if ([curComponents.lastObject isEqualToString:@"#"]) {
        BOOL result = YES;
        for (int i = 0; i < curComponents.count - 1 && i < otherComponents.count; i ++) {
            result = result && [curComponents[i] isEqualToString:otherComponents[i]];
            if (!result) return result;
        }
        return result;
    } else if ([curComponents containsObject:@"+"]) {
        if (curComponents.count != otherComponents.count) return NO;
        BOOL result = YES;
        for (int i = 0; i < curComponents.count && i < otherComponents.count; i ++) {
            if ([curComponents[i] isEqualToString:@"+"]) {
                continue;
            }
            result = result && [curComponents[i] isEqualToString:otherComponents[i]];
            if (!result) return result;
        }
        return result;
    }
    return [topic isEqualToString:other];
}

@end

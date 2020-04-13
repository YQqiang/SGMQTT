//
//  SGMQTTManageBuilder.m
//  SGMQTT
//
//  Created by sungrow on 2020/4/8.
//

#import "SGMQTTManageBuilder.h"

@interface SGMQTTManageBuilder ()

@property (nonatomic, strong) NSMutableArray <SGMQTTSubscribe *>*allSubscribe;
@property (nonatomic, strong) NSMutableArray <SGMQTTChangeState *>*allChangeState;

@property (nonatomic, strong) NSMutableDictionary <NSString *, SGMQTTReceiveDataHandler>*allReceiveHandle;

@end

@implementation SGMQTTManageBuilder

- (instancetype)init {
    if (self = [super init]) {
        [self reset];
    }
    return self;
}

- (void)reset {
    self.host = @"localhost";
    self.port = 1883;
    self.tls = NO;
    self.keepalive = 60;
    self.clean = YES;
    self.auth = NO;
    self.user = @"";
    self.pass = @"";
    self.will = YES;
    self.willTopic = [NSString stringWithFormat:@"willTopic/%@-%@",[UIDevice currentDevice].name, UIDevice.currentDevice.identifierForVendor.UUIDString];
    self.willMsg = [@"offline" dataUsingEncoding:NSUTF8StringEncoding];
    self.willQos = MQTTQosLevelExactlyOnce;
    self.willRetainFlag = NO;
    self.clientId = @"";
    self.securityPolicy = [MQTTSSLSecurityPolicy defaultPolicy];
    self.certificates = @[];
    self.protocolLevel = MQTTProtocolVersion311;
    self.runLoop = [NSRunLoop currentRunLoop];
    [self.allSubscribe removeAllObjects];
    [self.allReceiveHandle removeAllObjects];
}

- (NSMutableArray<SGMQTTSubscribe *> *)allSubscribe {
    if (!_allSubscribe) {
        _allSubscribe = [NSMutableArray array];
    }
    return _allSubscribe;
}

- (NSMutableDictionary<NSString *,SGMQTTReceiveDataHandler> *)allReceiveHandle {
    if (!_allReceiveHandle) {
        _allReceiveHandle = [NSMutableDictionary dictionary];
    }
    return _allReceiveHandle;
}

- (NSMutableArray<SGMQTTChangeState *> *)allChangeState {
    if (!_allChangeState) {
        _allChangeState = [NSMutableArray array];
    }
    return _allChangeState;
}

- (void)addSubscribe:(NSString *)topic qos:(MQTTQosLevel)qos handler:(SGMQTTReceiveDataHandler)handler {
    if (topic.length > 0 && handler) {
        [self.allSubscribe addObject:[[SGMQTTSubscribe alloc] initWithTopic:topic qos:qos handler:handler]];
    }
}

- (void)removeSubscribe:(NSString *)topic {
    if (topic.length > 0) {
        for (SGMQTTSubscribe *subscribe in self.allSubscribe.reverseObjectEnumerator) {
            if ([subscribe.topic isEqualToString:topic]) {
                [self.allSubscribe removeObject:subscribe];
            }
        }
    }
}

- (NSDictionary<NSString *,NSNumber *> *)subscriptions {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (SGMQTTSubscribe *subscribe in self.allSubscribe) {
        [dic addEntriesFromDictionary: subscribe.subscription];
    }
    return dic;
}

- (void)addReceive:(NSString *)label handler:(SGMQTTReceiveDataHandler)handler {
    if (label.length > 0 && handler) {
        [self.allReceiveHandle setObject:handler forKey:label];
    }
}

- (void)removeReceive:(NSString *)label {
    if (label.length > 0 && [self.allReceiveHandle.allKeys containsObject:label]) {
        [self.allReceiveHandle removeObjectForKey:label];
    }
}

- (void)addChangeState:(NSString *)label handler:(SGMQTTDidChangeStateHandler)handler {
    if (label.length > 0) {
        [self.allChangeState addObject: [[SGMQTTChangeState alloc] initWithLabel:label handler:handler]];
    }
}

- (void)removeChangeState:(NSString *)label {
    if (label.length > 0) {
        for (SGMQTTChangeState *changeState in self.allChangeState.reverseObjectEnumerator) {
            if ([changeState.label isEqualToString:label]) {
                [self.allChangeState removeObject:changeState];
            }
        }
    }
}

- (void)excuteReceiveDataHandlerSessionManager:(MQTTSessionManager *)sessionManager data:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    for (SGMQTTReceiveDataHandler handler in self.allReceiveHandle.allValues) {
        handler(sessionManager, data, topic, retained);
    }
    for (SGMQTTSubscribe *subscribe in self.allSubscribe) {
        if ([subscribe.topic isEqualToString:topic]) {
            subscribe.handler(sessionManager, data, topic, retained);
            break;
        }
    }
}

- (void)excuteDidChangeStateSessionManager:(MQTTSessionManager *)sessionManager newState:(MQTTSessionManagerState)newState {
    for (SGMQTTChangeState *changeState in self.allChangeState) {
        changeState.handler(sessionManager, newState);
    }
}

@end
